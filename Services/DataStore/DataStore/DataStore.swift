//
//  DataStore.swift
//  DataStore
//
//  Created by José Victor Pereira Costa on 11/04/21.
//  Copyright © 2021 José Victor Pereira Costa. All rights reserved.
//

import CoreData

public enum StorageType {
    case persistent, inMemory
}

public typealias ManagedData = [String: Any]

public final class DataStore {
    
    private let persistenceContainer: NSPersistentContainer
    
    public init(persistenceContainer: NSPersistentContainer = DataStorePersistenceContainer(),
                storageType: StorageType = .persistent) {
        self.persistenceContainer = persistenceContainer
        set(storageType: storageType)
        loadPersistenceContainer()
    }
    
    private func set(storageType: StorageType) {
        guard storageType == .inMemory else { return }
        persistenceContainer.persistentStoreDescriptions = [inMemoryPersistenStoreDescription]
    }
    
    private var inMemoryPersistenStoreDescription: NSPersistentStoreDescription {
        let description = NSPersistentStoreDescription()
        description.url = URL(fileURLWithPath: "/dev/null")
        return description
    }
    
    private func loadPersistenceContainer() {
        persistenceContainer.loadPersistentStores { description, error in
            if let error = error {
                fatalError(error.localizedDescription)
            } else {
                debugPrint(description)
            }
        }
    }
    
    public func save<ManagedObject: NSManagedObject>(_ managedObject: ManagedObject.Type,
                                                     withData data: ManagedData) throws {
        let context = persistenceContainer.viewContext
        let managedObject = ManagedObject(context: context)
        data.forEach { managedObject.setValue($0.value, forKey: $0.key) }
        try context.save()
    }
    
    public func fetch<ManagedObject: NSManagedObject>(_ managedObject: ManagedObject.Type) throws -> [ManagedObject] {
        let context = persistenceContainer.viewContext
        let entityName = String(describing: managedObject)
        let request = NSFetchRequest<ManagedObject>(entityName: entityName)
        return try context.fetch(request)
    }
}

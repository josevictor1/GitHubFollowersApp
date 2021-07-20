//
//  DataStore.swift
//  DataStore
//
//  Created by José Victor Pereira Costa on 11/04/21.
//  Copyright © 2021 José Victor Pereira Costa. All rights reserved.
//

import CoreData
import Commons

public enum StorageType {
    case persistent, inMemory
}

public typealias ManagedData = DictionaryConvertible

public final class DataStore {
    
    public static var shared = DataStore()
    public let persistenceContainer: NSPersistentContainer
    
    public init(persistenceContainer: NSPersistentContainer = DataStorePersistenceContainer(),
                storageType: StorageType = .inMemory) {
        self.persistenceContainer = persistenceContainer
        set(storageType: storageType)
        loadPersistenceContainer()
    }
    
    public func set(storageType: StorageType) {
        guard storageType == .inMemory else { return }
        persistenceContainer.persistentStoreDescriptions = [inMemoryPersistentStoreDescription]
    }
    
    private var inMemoryPersistentStoreDescription: NSPersistentStoreDescription {
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
        data.dictionary.forEach { managedObject.setValue($0.value, forKey: $0.key) }
        try context.save()
    }
    
    
    public func fetch<ManagedObject: NSManagedObject>() throws -> [ManagedObject] {
        let context = persistenceContainer.viewContext
        let entityName = ManagedObject.entity().name ?? String()
        let request = NSFetchRequest<ManagedObject>(entityName: entityName)
        return try context.fetch(request)
    }
    
    public func update() throws {
        let context = persistenceContainer.viewContext
        guard context.hasChanges else { return }
        try context.save()
    }
    
    public func delete<ManagedObject: NSManagedObject>(_ managedObject: ManagedObject) -> ManagedObject {
        let context = persistenceContainer.viewContext
        context.delete(managedObject)
        return managedObject
    }
}

enum DataStoreError: Error {
    case deletionFailed
}

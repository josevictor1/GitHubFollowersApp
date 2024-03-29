//
//  DataStoreTests.swift
//  DataStoreTests
//
//  Created by José Victor Pereira Costa on 11/04/21.
//

import XCTest
import CoreData
@testable import DataStore

final class DataStoreTests: XCTestCase {
    
    private lazy var dataStore: DataStore = {
        let dataStore = DataStore.shared
        dataStore.set(storageType: .inMemory)
        return dataStore
    }()
    
    private let favoriteMock = FavoriteMock(avatarURL: "test",
                                            login: "test",
                                            name: "test")
    
    func testSaveData() throws {
        try saveFavoriteMockData(in: dataStore)
    }
    
    func testFetchData() throws {
        try testObject()
        
        let result: [Favorite] = try dataStore.fetch()
        XCTAssertTrue(!result.isEmpty)
    }
    
    func testDeleteData() throws {
        let storedObject = try testObject()
        
        let deleteObject: Favorite = try dataStore.delete(storedObject)
        
        XCTAssertTrue(deleteObject.isDeleted)
        XCTAssertEqual(storedObject, deleteObject)
    }
    
    func testUpdateData() throws {
        let managedObject = try testObject()
        
        managedObject.login = "test_update"
        managedObject.avatarURL = "test"
        
        try dataStore.update()
    }
    
    @discardableResult
    private func testObject() throws -> Favorite  {
        let context = dataStore.persistenceContainer.viewContext
        let managedObject = Favorite(context: context)
        managedObject.avatarURL = "test"
        managedObject.login = "test"
        try context.save()
        return managedObject
    }
    
    private func saveFavoriteMockData(in dataStore: DataStore) throws {
        let data = ["login": favoriteMock.login, "avatarURL": favoriteMock.avatarURL]
        try dataStore.save(Favorite.self, withData: data)
    }
}

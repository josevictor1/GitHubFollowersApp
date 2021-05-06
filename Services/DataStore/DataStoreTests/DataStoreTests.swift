//
//  DataStoreTests.swift
//  DataStoreTests
//
//  Created by José Victor Pereira Costa on 11/04/21.
//

import XCTest
@testable import DataStore

final class DataStoreTests: XCTestCase {

    func testSaveData() throws {
        let dataStore = DataStore(storageType: .inMemory)
        try saveFavoriteMockData(in: dataStore)
    }
    
    func testFetchData() throws {
        let dataStore = DataStore(storageType: .inMemory)
        
        try saveFavoriteMockData(in: dataStore)
        
        let result = try dataStore.fetch(Favorite.self)
        XCTAssertTrue(!result.isEmpty)
    }
    
    private func saveFavoriteMockData(in dataStore: DataStore) throws {
        try dataStore.save(Favorite.self, withData: ["name": "Test",
                                                     "login" : "test",
                                                     "avatarURL": "test",
                                                     "numberOfFollowers": 1])
    }
}

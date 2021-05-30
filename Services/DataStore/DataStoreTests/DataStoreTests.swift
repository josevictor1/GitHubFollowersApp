//
//  DataStoreTests.swift
//  DataStoreTests
//
//  Created by José Victor Pereira Costa on 11/04/21.
//

import XCTest
@testable import DataStore

final class DataStoreTests: XCTestCase {
    
    private let dataStore: DataStore = .shared
    
    func testSaveData() throws {
        try saveFavoriteMockData(in: dataStore)
    }
    
    func testFetchData() throws {
        try saveFavoriteMockData(in: dataStore)
        
        let result: [Favorite] = try dataStore.fetch()
        XCTAssertTrue(!result.isEmpty)
    }
    
    func testDeleteData() throws {
        try saveFavoriteMockData(in: dataStore)
        
        let favorite: Favorite = dataStore.delete(["name": "Test",
                                                   "login" : "test",
                                                   "avatarURL": "test",
                                                   "numberOfFollowers": 1])
        
        XCTAssertTrue(favorite.isDeleted)
    }
    
    private func saveFavoriteMockData(in dataStore: DataStore) throws {
        try dataStore.save(Favorite.self, withData: ["name": "Test",
                                                     "login" : "test",
                                                     "avatarURL": "test",
                                                     "numberOfFollowers": 1])
    }
}

//
//  FavoriteProfilesService.swift
//  FavoriteProfilesTests
//
//  Created by José Victor Pereira Costa on 03/06/21.
//  Copyright © 2021 José Victor Pereira Costa. All rights reserved.
//

import XCTest
import DataStore
@testable import FavoriteProfiles

final class FavoriteProfilesServiceTests: XCTestCase {
    
    func testLoadProfiles() {
        let expectation = XCTestExpectation(description: "Should load profiles.")
        let sut = FavoriteProfilesService()
        
        sut.loadProfiles { result in
            switch result {
            case .success(let response):
                XCTAssertNotNil(response)
            case .failure:
                XCTFail()
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testDeleteProfile() throws {
        let expectation = XCTestExpectation(description: "Shoud update profiles.")
        let sut = FavoriteProfilesService()
        let profilesMock = FavoriteProfilesMocks().favoriteProfilesMock
        let profileMock = profilesMock.first!
        try setUpDataStoreWithMockData()
        
        sut.loadProfiles { _ in }
        
        sut.delete(profileMock) { result in
            switch result {
            case .success:
                expectation.fulfill()
            case .failure:
                XCTFail()
            }
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    
    func testDeleteNonExistantProfile() throws {
        let expectation = XCTestExpectation(description: "Should failed when try to delete.")
        let sut = FavoriteProfilesService()
        let profilesMock = FavoriteProfilesMocks().favoriteProfilesMock
        let profileMock = profilesMock.first!
        
        sut.loadProfiles { _ in }
        
        sut.delete(profileMock) { result in
            switch result {
            case .success:
                XCTFail()
            case .failure:
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    private func setUpDataStoreWithMockData() throws {
        let dataStore: DataStore = .shared
        let data = FavoriteProfilesMocks().favoriteProfilesMock.first!
        try dataStore.save(Favorite.self,
                           withData: data)
    }
}


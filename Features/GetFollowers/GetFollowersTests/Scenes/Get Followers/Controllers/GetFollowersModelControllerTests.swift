//
//  GetFollowersModelController.swift
//  GetFollowersTests
//
//  Created by José Victor Pereira Costa on 31/03/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import XCTest
@testable import GetFollowers

class GetFollowersModelControllerTests: XCTestCase {
    
    // MARK: - Mocks
    
    let followersProviderMock = FollowersServiceMock()
    
    // MARK: - SUT Factory
    
    func makeSUT() -> GetFollowersLogicController {
        GetFollowersLogicController(provider: followersProviderMock)
    }
    
    // MARK: - Tests
    
    func testGetFollowersWithSuccess() {
        let sut = makeSUT()
        
        followersProviderMock.followers = []
        var receivedFollowers: [Follower]?
        
        sut.getFollowers(of: "test") { result in
            switch result {
            case .success(let followers):
                receivedFollowers = followers
            case .failure:
                XCTFail("The getFollowers method should return with success")
            }
        }
        
        XCTAssertNotNil(receivedFollowers, "The received followers on success should not be nil")
    }
    
    func testGetFollowersWithInvalidUser() {
        let sut = makeSUT()
        followersProviderMock.error = .invalidUsername
        var receivedError: GetFollowersError?
        
        sut.getFollowers(of: "test") { result in
            switch result {
            case .success:
                XCTFail("The getFollowers method should return with error")
            case .failure(let error):
                receivedError = error
            }
        }
        
        XCTAssertEqual(receivedError, .invalidUsername, "The received error should be invalid usename")
    }
    
    func testGetFollowersWithRequestFail() {
        let sut = makeSUT()
        followersProviderMock.error = .requestFail
        var receivedError: GetFollowersError?
        
        sut.getFollowers(of: "test") { result in
            switch result {
            case .success:
                XCTFail("The getFollowers method should return with error")
            case .failure(let error):
                receivedError = error
            }
        }
        
        XCTAssertEqual(receivedError, .requestFail, "The received error should be request fail")
    }
    
}

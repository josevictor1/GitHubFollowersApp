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

    func testGetFollowersWithSuccess() {
        let provider = FollowersServiceMock()
        provider.followers = []
        let sut = GetFollowersModelController(provider: provider)
        
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
        let error = NSError(domain: "Not Found", code: 403, userInfo: nil)
        let provider = FollowersServiceMock()
        provider.error = error
        
        let sut = GetFollowersModelController(provider: provider)
        
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
        let error = NSError(domain: "Internal Server Error", code: 500, userInfo: nil)
        let provider = FollowersServiceMock()
        provider.error = error
        
        let sut = GetFollowersModelController(provider: provider)
        
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

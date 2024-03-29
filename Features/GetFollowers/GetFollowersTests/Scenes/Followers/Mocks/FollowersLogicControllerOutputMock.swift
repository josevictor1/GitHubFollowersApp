//
//  FollowersLogicControllerOutputMock.swift
//  GetFollowersTests
//
//  Created by José Victor Pereira Costa on 21/02/21.
//  Copyright © 2021 José Victor Pereira Costa. All rights reserved.
//

import XCTest
import Commons
@testable import GetFollowers

final class FollowersLogicControllerOutputMock: FollowersLogicControllerOutput {
    
    var error: GetFollowersError?
    var followers = [Follower]()
    var login = String()
    var expectation: XCTestExpectation?

    init() {}

    func followersNotFound() {
        expectation?.fulfill()
    }

    func showUserInformation(forLogin login: String) {
        self.login = login
    }
    
    func failedAddUserToFavorites() {
        
    }
    
    func didAddUser() {
        
    }
    
    func failedOnFetchFollowers(_ error: GetFollowersError) {
        self.error = error
        expectation?.fulfill()
    }
    
    func didFetchFollowers(_ followers: [Follower]) {
        self.followers = followers
        expectation?.fulfill()
    }
    
    func didFetchSelectedUserOnFavorites() {
        
    }
    
    func selectedUserNotFound() {
        
    }
}

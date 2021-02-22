//
//  FollowersLogicControllerOutputMock.swift
//  GetFollowersTests
//
//  Created by José Victor Pereira Costa on 21/02/21.
//  Copyright © 2021 José Victor Pereira Costa. All rights reserved.
//

import XCTest
@testable import GetFollowers

final class FollowersLogicControllerOutputMock: FollowersLogicControllerOutput {
    var error: GetFollowersError?
    var followers = [Follower]()
    var login = String()
    var expection: XCTestExpectation?
    
    init() {}
    
    func showFollowersNotFound() {
        expection?.fulfill()
    }
    
    func showFailureOnFetchFollowers(_ error: GetFollowersError) {
        self.error = error
        expection?.fulfill()
    }
    
    func showFollowers(_ followers: [Follower]) {
        self.followers = followers
        expection?.fulfill()
    }
    
    func showUserInformation(for login: String) {
        self.login = login
    }
}

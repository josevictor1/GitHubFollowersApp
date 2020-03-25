//
//  GetFollowersViewControllerTests.swift
//  GitHubTests
//
//  Created by José Victor Pereira Costa on 23/03/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import XCTest
@testable import GitHubFollowers

class GetFollowersViewControllerTests: XCTestCase {

    func testOnGetFollowersButtonTapped() {
        let sut = GetFollowersViewController()
    
        var getFollowersTapped = false
        let username = "test"
        var receivedUsername = String()
        
        sut.onGetFollowersButtonTapped = { userName in
            getFollowersTapped.toggle()
            receivedUsername = userName
        }
        
        sut.getFollowersView.getFollowersButtonTapped?(username)
        
        XCTAssert(getFollowersTapped, "The get followers button should be tapped")
        XCTAssertEqual(username, receivedUsername, "The received user name should be equal to typed username")
    }
    
}

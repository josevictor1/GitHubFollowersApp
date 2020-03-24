//
//  GetFollowersViewControllerTests.swift
//  GitHubTests
//
//  Created by José Victor Pereira Costa on 23/03/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import XCTest
@testable import GitHub

class GetFollowersViewControllerTests: XCTestCase {

    func testOnGetFollowersButtonTapped() {
        let sut = GetFollowersViewController()
    
        var getFollowersTapped = false
        let typedUsername = "test"
        var receivedUsername = ""
        sut.onGetFollowersButtonTapped = { userName in
            getFollowersTapped.toggle()
            receivedUsername = userName
        }
        
        sut.getFollowersView.getFollowersButtonTapped?(typedUsername)
        
        XCTAssert(getFollowersTapped, "The get followers button should be tapped")
        XCTAssertEqual(typedUsername, receivedUsername, "The received user name should be equal to typed username")
    }
    
    
}

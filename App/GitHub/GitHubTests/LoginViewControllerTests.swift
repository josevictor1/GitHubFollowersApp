//
//  LoginViewControllerTests.swift
//  GitHubTests
//
//  Created by José Victor Pereira Costa on 23/03/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import XCTest
@testable import GitHub

class LoginViewControllerTests: XCTestCase {

    func testOnGetFollowersButtonTapped() {
        let sut = LoginViewController()
        
        var getFollowersTapped = false
        let userName = "test"
        var receivedUsername = ""
        sut.onGetFollowersButtonTapped = { userName in
            getFollowersTapped.toggle()
            receivedUsername = userName
        }
        
        sut.loginView.getFollowersButtonTapped?(userName)
        
        XCTAssert(getFollowersTapped, "The onGetFollowersButtonTapped should be called")
        XCTAssertEqual(userName, receivedUsername)
    }
    
    
}

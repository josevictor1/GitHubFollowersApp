//
//  GetFollowersViewControllerTests.swift
//  GitHubTests
//
//  Created by José Victor Pereira Costa on 23/03/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import XCTest
@testable import GetFollowers

class GetFollowersViewControllerTests: XCTestCase {
    
    // MARK: - Mocks
    
    let modelControllerMock = GetFollowersModelControllerMock()
    let alertPresenterMock = GetFollowersAlertPresenterMock()
    let delegateMock = GetFollowersViewControllerDelegateMock()
    
    // MARK: - SUT Factory
    
    func makeSUT() -> GetFollowersViewController {
        let viewController = GetFollowersViewController()
        viewController.modelController = modelControllerMock
        viewController.presenter = alertPresenterMock
        viewController.delegate = delegateMock
        return viewController
    }
    
    // MARK: - Tests
    
    func testOnGetFollowersButtonTapped() {
        let sut = makeSUT()

        var getFollowersTapped = false
        let username = "test"
        var receivedUsername = String()
        sut.onGetFollowersButtonTapped = { userName in
            getFollowersTapped.toggle()
            receivedUsername = userName ?? ""
        }

        sut.getFollowersView.onGetFollowersButtonTapped?(username)

        XCTAssert(getFollowersTapped, "The get followers button should be tapped")
        XCTAssertEqual(username, receivedUsername, "The received user name should be equal to typed username")
    }
    
    func testGetFollowersFailWithRequestFailMessage() {
        let sut = makeSUT()
        
        var presentedError: GetFollowersError?
        alertPresenterMock.onAlertPresented = { error in
            presentedError = error
        }
        let username = "test"
        
        sut.onGetFollowersButtonTapped(username)

        XCTAssertEqual(presentedError, .requestFail, "The alert should be presented with request fail error")
    }
    
    func testGetFollowersFailWithIvalidUsernameMessage() {
        let sut = makeSUT()
        
        modelControllerMock.error = .invalidUsername
        var presentedError: GetFollowersError?
        alertPresenterMock.onAlertPresented = { error in
            presentedError = error
        }
        let username = "test"
        
        sut.onGetFollowersButtonTapped(username)
        
        XCTAssertEqual(presentedError, .invalidUsername, "The alert should be presented with invalid username error")
    }
    
    func testGetFollowersWithSuccess() {
        let sut = makeSUT()
        
        modelControllerMock.followers = []
        sut.delegate = delegateMock
        let username = "test"
        
        sut.onGetFollowersButtonTapped(username)
        
        XCTAssertTrue(delegateMock.didViewControllerGotFollowers, "The delegate shold be called")
    }
    
}

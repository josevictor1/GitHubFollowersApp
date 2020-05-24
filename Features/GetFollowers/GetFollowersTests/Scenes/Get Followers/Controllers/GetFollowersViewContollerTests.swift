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
    
    let logicController = GetFollowersLogicControllerMock()
    let alertPresenterMock = GetFollowersAlertPresenterMock()
    let delegateMock = GetFollowersViewControllerDelegateMock()
    
    // MARK: - SUT Factory
    
    func makeSUT() -> GetFollowersViewController {
        .makeGetFollowers(delegate: delegateMock,
                          presenter: alertPresenterMock,
                          logicController: logicController)
    }
    
    // MARK: - Tests
    
    func testGetFollowersFailWithRequestFailMessage() {
        let sut = makeSUT()
        logicController.error = .requestFail
        var presentedError: GetFollowersError?
        let username = "test"
        let expectation = XCTestExpectation(description: "The onAlertPresented closure should be executed")
        alertPresenterMock.onAlertPresented = { error in
            presentedError = error
            expectation.fulfill()
        }
        
        sut.onGetFollowersButtonTapped(username)
        wait(for: [expectation], timeout: 1)
        XCTAssertEqual(presentedError, .requestFail, "The alert should be presented with request fail error")
    }
    
    func testGetFollowersFailWithIvalidUsernameMessage() {
        let sut = makeSUT()
        logicController.error = .invalidUsername
        var presentedError: GetFollowersError?
        let username = "test"
        let expectation = XCTestExpectation(description: "The onAlertPresented closure should be executed")
        alertPresenterMock.onAlertPresented = { error in
            presentedError = error
            expectation.fulfill()
        }
        
       
        
        sut.onGetFollowersButtonTapped(username)
        wait(for: [expectation], timeout: 1)
        XCTAssertEqual(presentedError, .invalidUsername, "The alert should be presented with invalid username error")
    }
    
    func testGetFollowersWithSuccess() {
        let sut = makeSUT()
        logicController.followers = []
        let expectation = XCTestExpectation(description: "The viewControllerDidGetFollowers should be called")
        delegateMock.expectationCompletion = { [weak expectation] in
            expectation?.fulfill()
        }
        let username = "test"
        
        sut.onGetFollowersButtonTapped(username)
        wait(for: [expectation], timeout: 1)
        XCTAssertTrue(delegateMock.didViewControllerGotFollowers, "The delegate shold be called")
    }
    
}

//
//  GetFollowersViewControllerTests.swift
//  GitHubTests
//
//  Created by José Victor Pereira Costa on 23/03/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import XCTest
@testable import GetFollowers

final class GetFollowersViewControllerTests: XCTestCase {

    // MARK: - Mocks

    private let logicControllerMock = GetFollowersLogicControllerMock()
    private let alertPresenterMock = GetFollowersAlertPresenterMock()
    private let delegateMock = GetFollowersViewControllerDelegateMock()
    private var presentedError: GetFollowersError?
    
    // MARK: - SUT Factory

    private lazy var sut: GetFollowersViewController = {
        .makeGetFollowers(delegate: delegateMock,
                          presenter: alertPresenterMock,
                          logicController: logicControllerMock)
    }()
    
    
    private func prepareLogicController(with error: GetFollowersError) {
        logicControllerMock.error = error
    }
    
    private func prepareAlerPresenterMock(with expectation: XCTestExpectation) {
        alertPresenterMock.onAlertPresented = { [weak expectation, weak self] error in
            self?.presentedError = error
            expectation?.fulfill()
        }
    }
    
    private func setUpLogicControllersFollowersAsEmpty() {
        logicControllerMock.followers = []
    }
    
    private func prepareGetFollowersControllerDalegate(with expectation: XCTestExpectation) {
        delegateMock.expectationCompletion = { [weak expectation] in
            expectation?.fulfill()
        }
    }
    
    private func callGetFollowersButtonTappedMethod() {
        //let username = "test"
        //sut.onGetFollowersButtonTapped(username)
    }

    // MARK: - Tests

    func testGetFollowersFailWithRequestFailMessage() {
        let expectation = XCTestExpectation(description: "The onAlertPresented closure should be executed")
        prepareLogicController(with: .requestFail)
        prepareAlerPresenterMock(with: expectation)

        callGetFollowersButtonTappedMethod()

        wait(for: [expectation], timeout: 1)
        XCTAssertEqual(presentedError, .requestFail, "The alert should be presented with request fail error")
    }

    func testGetFollowersFailWithIvalidUsernameMessage() {
        let expectation = XCTestExpectation(description: "The onAlertPresented closure should be executed")
        prepareLogicController(with: .invalidUsername)
        prepareAlerPresenterMock(with: expectation)

        callGetFollowersButtonTappedMethod()

        wait(for: [expectation], timeout: 1)
        XCTAssertEqual(presentedError, .invalidUsername, "The alert should be presented with invalid username error")
    }

    func testGetFollowersWithSuccess() {
        let expectation = XCTestExpectation(description: "The viewControllerDidGetFollowers should be called")
        setUpLogicControllersFollowersAsEmpty()
        prepareGetFollowersControllerDalegate(with: expectation)
        
        callGetFollowersButtonTappedMethod()

        wait(for: [expectation], timeout: 1)
        XCTAssertTrue(delegateMock.didViewControllerGotFollowers, "The delegate shold be called")
    }
}

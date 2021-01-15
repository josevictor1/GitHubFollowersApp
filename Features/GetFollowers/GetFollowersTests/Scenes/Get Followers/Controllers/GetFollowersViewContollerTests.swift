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
    private let keyboardObseverMock = KeyboardObserverMock()
    private let viewMock = GetFollowersViewMock()
    private var presentedError: GetFollowersError?
    
    // MARK: - SUT Factory
    
    private lazy var sut: GetFollowersViewController = {
        .makeGetFollowers(view: viewMock,
                          delegate: delegateMock,
                          presenter: alertPresenterMock,
                          logicController: logicControllerMock,
                          keyboardObserver: keyboardObseverMock)
    }()
    
    
    private func prepareLogicController(with error: GetFollowersError) {
        logicControllerMock.error = error
    }
    
    private func prepareAlertPresenterMock(with expectation: XCTestExpectation) {
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
        setUpViewDelegate()
        viewMock.getFllowersButtonTapped()
    }
    
    private func checkPresentedError(with expectation: XCTestExpectation, error: GetFollowersError) {
        wait(for: [expectation], timeout: 1)
        XCTAssertEqual(presentedError, error, "The alert should be presented with \(error) error")
    }
    
    private func checkViewControllerFetchDataWithSuccess(with expectation: XCTestExpectation) {
        wait(for: [expectation], timeout: 1)
        XCTAssertTrue(delegateMock.didViewControllerGotFollowers, "The delegate shold be called")
    }
    
    private func prepareViewController() {
        setUpViewDelegate()
        sut.viewDidLoad()
    }
    
    private func setUpViewDelegate() {
        viewMock.delegate = sut
    }
    
    private func setUpKeyboardAsTouched() {
        keyboardObseverMock.callKeyboardAppeard()
    }
    
    private func checkViewDidScroll() {
        XCTAssertTrue(viewMock.scrollUpCalled)
    }
    
    
    // MARK: - Tests
    
    func testGetFollowersFailWithRequestFailMessage() {
        let expectation = XCTestExpectation(description: "The onAlertPresented closure should be executed")
        prepareAlertPresenterMock(with: expectation)
        prepareLogicController(with: .requestFail)
        
        callGetFollowersButtonTappedMethod()
        
        checkPresentedError(with: expectation, error: .requestFail)
    }
    
    func testGetFollowersFailWithIvalidUsernameMessage() {
        let expectation = XCTestExpectation(description: "The onAlertPresented closure should be executed")
        prepareAlertPresenterMock(with: expectation)
        prepareLogicController(with: .invalidUsername)
        
        callGetFollowersButtonTappedMethod()
        
        checkPresentedError(with: expectation, error: .invalidUsername)
    }
    
    func testGetFollowersWithSuccess() {
        let expectation = XCTestExpectation(description: "The viewControllerDidGetFollowers should be called")
        prepareGetFollowersControllerDalegate(with: expectation)
        setUpLogicControllersFollowersAsEmpty()
        
        callGetFollowersButtonTappedMethod()
        
        checkViewControllerFetchDataWithSuccess(with: expectation)
    }
    
    func testGetFollowerViewControllerNotifyKeyboardDidAppeard() {
        prepareViewController()
        
        setUpKeyboardAsTouched()
        
        checkViewDidScroll()
    }
}

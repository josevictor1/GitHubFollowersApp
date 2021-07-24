//
//  GetFollowersViewControllerTestAPI.swift
//  GetFollowersTests
//
//  Created by José Victor Pereira Costa on 20/02/21.
//  Copyright © 2021 José Victor Pereira Costa. All rights reserved.
//

import XCTest
import Commons
@testable import GetFollowers

final class GetFollowersViewControllerTestAPI {
    private let serviceMock = UserInformationServiceMock()
    private let alertPresenterMock = GetFollowersAlertPresenterMock()
    private let delegateMock = GetFollowersViewControllerDelegateMock()
    private let keyboardObserverMock = KeyboardObserverMock()
    private lazy var logicControllerMock: GetFollowersLogicController = {
        let provider = GetFollowersProvider(userInformationService: serviceMock)
        return GetFollowersLogicController(provider: provider)
        
    }()
    private let viewMock = GetFollowersViewMock()
    private var presentedError: GetFollowersError?
    
    private lazy var sut: GetFollowersViewController = {
        GetFollowersViewController(view: viewMock,
                                   logicController: logicControllerMock,
                                   presenter: alertPresenterMock,
                                   delegate: delegateMock,
                                   keyboardObserver: keyboardObserverMock)
    }()
    
    func prepareLogicController(with error: GetFollowersError) {
        serviceMock.error = error
    }
    
    func prepareAlertPresenterMock(with expectation: XCTestExpectation) {
        alertPresenterMock.onAlertPresented = { [weak expectation, weak self] error in
            self?.presentedError = error
            expectation?.fulfill()
        }
    }
    
    func prepareGetFollowersControllerDelegate(with expectation: XCTestExpectation) {
        delegateMock.expectationCompletion = { [weak expectation] in
            expectation?.fulfill()
        }
    }
    
    func callGetFollowersButtonTappedMethod() {
        setUpViewDelegate()
        viewMock.getFollowersButtonTapped()
    }
    
    func checkPresentedError(error: GetFollowersError) {
        XCTAssertEqual(presentedError, error, "The alert should be presented with \(error) error")
    }
    
    func checkViewControllerFetchDataWithSuccess() {
        XCTAssertTrue(delegateMock.didViewControllerGotFollowers, "The delegate should be called")
    }
    
    func prepareViewController() {
        setUpViewDelegate()
        sut.viewDidLoad()
    }
    
    private func setUpViewDelegate() {
        viewMock.delegate = sut
    }
    
    func setUpKeyboardAsTouched() {
        keyboardObserverMock.callKeyboardAppeared()
    }
    
    func checkViewDidScroll() {
        XCTAssertTrue(viewMock.scrollUpCalled)
    }
}

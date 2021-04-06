//
//  GetFollowersViewControllerTestAPI.swift
//  GetFollowersTests
//
//  Created by José Victor Pereira Costa on 20/02/21.
//  Copyright © 2021 José Victor Pereira Costa. All rights reserved.
//

import XCTest
@testable import GetFollowers

final class GetFollowersViewControllerTestAPI {
    private let serviceMock = UserInformationServiceMock()
    private let alertPresenterMock = GetFollowersAlertPresenterMock()
    private let delegateMock = GetFollowersViewControllerDelegateMock()
    private let keyboardObseverMock = KeyboardObserverMock()
    private lazy var logicControllerMock: GetFollowersLogicController = {
        let provider = GetFollowersProvider(userInformationService: serviceMock)
        return GetFollowersLogicController(provider: provider)
        
    }()
    private let viewMock = GetFollowersViewMock()
    private var presentedError: GetFollowersError?

    private lazy var sut: GetFollowersViewController = {
        .makeGetFollowers(view: viewMock,
                          delegate: delegateMock,
                          presenter: alertPresenterMock,
                          logicController: logicControllerMock,
                          keyboardObserver: keyboardObseverMock)
    }()

    func prepareLogicController(with error: GetFollowersError) {
        switch error {
        case .invalidUsername:
            serviceMock.error = .client(NSError(), nil)
        case .requestFail:
            serviceMock.error = .server(NSError(), nil)
        default:
            break
        }
    }

    func prepareAlertPresenterMock(with expectation: XCTestExpectation) {
        alertPresenterMock.onAlertPresented = { [weak expectation, weak self] error in
            self?.presentedError = error
            expectation?.fulfill()
        }
    }

    func prepareGetFollowersControllerDalegate(with expectation: XCTestExpectation) {
        delegateMock.expectationCompletion = { [weak expectation] in
            expectation?.fulfill()
        }
    }

    func callGetFollowersButtonTappedMethod() {
        setUpViewDelegate()
        viewMock.getFllowersButtonTapped()
    }

    func checkPresentedError(error: GetFollowersError) {
        XCTAssertEqual(presentedError, error, "The alert should be presented with \(error) error")
    }

    func checkViewControllerFetchDataWithSuccess() {
        XCTAssertTrue(delegateMock.didViewControllerGotFollowers, "The delegate shold be called")
    }

    func prepareViewController() {
        setUpViewDelegate()
        sut.viewDidLoad()
    }

    private func setUpViewDelegate() {
        viewMock.delegate = sut
    }

    func setUpKeyboardAsTouched() {
        keyboardObseverMock.callKeyboardAppeard()
    }

    func checkViewDidScroll() {
        XCTAssertTrue(viewMock.scrollUpCalled)
    }
}

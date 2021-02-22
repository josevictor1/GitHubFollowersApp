//
//  FollowersLogicControllerTestsAPI.swift
//  GetFollowersTests
//
//  Created by José Victor Pereira Costa on 21/02/21.
//  Copyright © 2021 José Victor Pereira Costa. All rights reserved.
//

import Foundation
import XCTest
@testable import GetFollowers

final class FollowersLogicControllerTestsAPI {
    private let logicControllerOutputMock = FollowersLogicControllerOutputMock()
    private let serviceMock = FollowersServiceMock()
    private let userInformationMock = UserInformation(login: "test",
                                                      numberOfFollowers: 1)
    private var filteredFollowers = [Follower]()
    private lazy var sut: FollowersLogicController = {
        FollowersLogicController(viewController: logicControllerOutputMock,
                                 userFollowers: userInformationMock,
                                 service: serviceMock)
    }()
    
    func loadTestFollowers() {
        sut.loadFollowers()
    }
    
    func loadNextFollowersPage() {
        sut.loadNextPage()
    }
    
    func setUpEmptyReturnWhenLoadFollowers() {
        serviceMock.shouldReturnEmpty = true
    }
    
    func searchForTestFollowers() {
        sut.searchFollower(withLogin: "octocat")
    }
    
    func cancelSearch() {
        sut.cancelSearch()
    }
    
    func setUpSearchState(with expectation: XCTestExpectation) {
        setUpLogicControllerOutput(with: expectation)
        loadTestFollowers()
        searchForTestFollowers()
        filteredFollowers = logicControllerOutputMock.followers
    }
    
    func setUpLoadFollowersWithError() {
        serviceMock.resetTestVariables()
        serviceMock.error = .requestFail
    }
    
    func setUpLogicControllerOutput(with expectation: XCTestExpectation) {
        logicControllerOutputMock.expection = expectation
    }
    
    func checkIfFollowersWereFiltered() {
        checkIfFollowersWereLoad()
        let filtered = logicControllerOutputMock.followers.reduce(true) {
            $0 && $1.login.contains("octocat")
        }
        XCTAssertTrue(filtered)
    }
    
    func checkIfFollowersWereLoad() {
        XCTAssertFalse(logicControllerOutputMock.followers.isEmpty)
    }
    
    func selectFollowerAtFirstPosition() {
        sut.selectFollower(atIndex: .zero)
    }
    
    func checkIfSelectedFollowerIsTheExpected() {
        XCTAssertEqual(logicControllerOutputMock.login, "octocat")
    }
    
    func checkIfFollowersNotFound() {
        XCTAssertTrue(logicControllerOutputMock.followers.isEmpty)
    }
    
    func checkIfSearchWasCanceled() {
        XCTAssertNotEqual(logicControllerOutputMock.followers, filteredFollowers)
    }
    
    func checkIfErrorRequestFailedWasShown() {
        XCTAssertEqual(logicControllerOutputMock.error, .requestFail)
    }
}

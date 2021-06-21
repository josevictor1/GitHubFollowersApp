//
//  FollowersLogicControllerTestsAPI.swift
//  GetFollowersTests
//
//  Created by José Victor Pereira Costa on 21/02/21.
//  Copyright © 2021 José Victor Pereira Costa. All rights reserved.
//

import Commons
import XCTest
@testable import GetFollowers

final class FollowersLogicControllerTestsAPI {
    
    private let logicControllerOutputMock = FollowersLogicControllerOutputMock()
    private let serviceMock = FollowersServiceMock()
    private let userInformationMock = SelectedUserInformation(login: "test",
                                                              name: "test",
                                                              avatarURL: "test",
                                                              numberOfFollowers: 1)
    private let alternativeUserInformation = SelectedUserInformation(login: "test",
                                                                     name: "test",
                                                                     avatarURL: "test",
                                                                     numberOfFollowers: 0)
    private var filteredFollowers = [Follower]()
    private var sut: FollowersLogicController?
    
    private func makeFollowersLogicController(with userInformation: SelectedUserInformation) -> FollowersLogicController {
        let paginationController = PaginationController(numberOfItems: userInformation.numberOfFollowers)
        return FollowersLogicController(viewController: logicControllerOutputMock,
                                        userFollowers: userInformation,
                                        paginationController: paginationController,
                                        service: serviceMock)
    }
    
    // MARK: - SUT Setup
    
    func loadTestFollowers() {
        sut?.loadFollowers()
    }
    
    func loadNextFollowersPage() {
        sut?.loadNextPage()
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
    
    func setUpLogicControllerWithFollowers() {
        sut = makeFollowersLogicController(with: userInformationMock)
    }
    
    func setUpLogicControllerWithoutFollowers() {
        sut = makeFollowersLogicController(with: alternativeUserInformation)
        setUpEmptyReturnWhenLoadFollowers()
    }
    
    private func setUpEmptyReturnWhenLoadFollowers() {
        serviceMock.shouldReturnEmpty = true
    }
    
    func setUserToBeFavorited() {
        setUpLogicControllerWithFollowers()
    }
    
    // MARK: - Actions
    
    func searchForTestFollowers() {
        sut?.searchFollower(withLogin: "octocat")
    }
    
    func cancelSearch() {
        sut?.cancelSearch()
    }
    
    func deleteSearchFilter() {
        sut?.searchFollower(withLogin: "")
    }
    
    func selectFollowerAtFirstPosition() {
        sut?.selectFollower(atIndex: .zero)
    }

    // MARK: - Check
    
    func checkIfFollowersWereFiltered() {
        checkIfFollowersWereLoad()
        let filtered = logicControllerOutputMock.followers.allSatisfy {
            $0.login.contains("octocat")
        }
        XCTAssertTrue(filtered)
    }
    
    func checkIfFollowersWereLoad() {
        XCTAssertFalse(logicControllerOutputMock.followers.isEmpty)
    }
    
    func checkIfSelectedFollowerIsTheExpected() {
        XCTAssertEqual(logicControllerOutputMock.login, "octocat")
    }
    
    func checkIfFollowersNotFound() {
        XCTAssertTrue(logicControllerOutputMock.followers.isEmpty)
    }
    
    func checkIfFollowersAreNotFiltered() {
        XCTAssertNotEqual(logicControllerOutputMock.followers, filteredFollowers)
    }
    
    func checkIfErrorRequestFailedWasShown() {
        XCTAssertEqual(logicControllerOutputMock.error, .requestFail)
    }
    
    func checkIfSelectedUserWasFavorited() {
        
    }
}

//
//  FollowersViewControllerTests.swift
//  GetFollowersTests
//
//  Created by José Victor Pereira Costa on 21/02/21.
//  Copyright © 2021 José Victor Pereira Costa. All rights reserved.
//

import XCTest

final class FollowersViewControllerTests: XCTestCase {
    
    private let test = FollowersViewControllerTestsAPI()

    func testLoadFollowers() {
        test.loadViewController()

        test.checkIfFollowersWereLoaded()
    }

    func testLoadNextPage() {
        test.loadMockFollowers()

        test.scrollDown()

        test.checkIfNextPageWasLoaded()
    }

    func testSearchFollower() {
        test.setUpSearch()

        test.checkIfFollowerWasSearched()
    }

    func testSelectFollower() {
        test.tapFirstFollower()

        test.checkIfItemWasSelected()
    }

    func testCancelSearch() {
        test.tapCancel()

        test.checkIfSearchedWasCanceled()
    }

    func testPresentError() {
        test.setUpLoadFollowersWithError()

        test.checkIfPresenterWasCalledWithError()
    }

    func testEmptyState() {
        test.setUpFollowersNotFound()

        test.checkIfPresentFollowersNotFoundEmptyState()
    }
}

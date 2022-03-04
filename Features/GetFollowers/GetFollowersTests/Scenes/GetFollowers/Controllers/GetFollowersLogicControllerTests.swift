//
//  GetFollowersModelController.swift
//  GetFollowersTests
//
//  Created by José Victor Pereira Costa on 31/03/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import XCTest
@testable import GetFollowers

final class GetFollowersLogicControllerTests: XCTestCase {
    
    private let test = GetFollowersLogicControllerTestAPI()

    func testGetFollowersWithSuccess() {
        let expectation = XCTestExpectation(description: "Should succeded.")

        test.executeSuccessfulSearchForTestFollowers(with: expectation)

        wait(for: [expectation], timeout: 1)
        test.checkIfReceivedUserInformation()
    }

    func testGetFollowersWithInvalidUser() {
        let expectation = XCTestExpectation(description: "Should failed.")
        test.prepareProviderWithInvalidUser()

        test.executeFailedSearchForTestFollowers(with: expectation)

        wait(for: [expectation], timeout: 1)
        test.checkIfUsernameIsInvalid()
    }

    func testGetFollowersWithRequestFail() {
        let expectation = XCTestExpectation(description: "Should failed.")
        test.prepareProviderWithFailedRequest()

        test.executeFailedSearchForTestFollowers(with: expectation)

        wait(for: [expectation], timeout: 1)
        test.checkIfRequestFailed()
    }
}

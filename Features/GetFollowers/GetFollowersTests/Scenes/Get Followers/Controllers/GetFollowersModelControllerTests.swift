//
//  GetFollowersModelController.swift
//  GetFollowersTests
//
//  Created by José Victor Pereira Costa on 31/03/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import XCTest
@testable import GetFollowers

final class GetFollowersModelControllerTests: XCTestCase {

    // MARK: - Mocks

    private let followersProviderMock = FollowersServiceMock()

    private lazy var sut: GetFollowersLogicController = {
        GetFollowersLogicController(provider: followersProviderMock)
    }()

    // MARK: - Tests

    func testGetFollowersWithSuccess() {
        followersProviderMock.followers = []
        var receivedFollowers: [Follower]?
        let expectation = XCTestExpectation(description: "Should succeded.")

        sut.getFollowers(of: "test") { result in
            switch result {
            case .success(let followers):
                expectation.fulfill()
                receivedFollowers = followers
            case .failure:
                XCTFail("The getFollowers method should return with success")
            }
        }
        
        wait(for: [expectation], timeout: 1)
        XCTAssertNotNil(receivedFollowers, "The received followers on success should not be nil")
    }

    func testGetFollowersWithInvalidUser() {
        followersProviderMock.error = .invalidUsername
        var receivedError: GetFollowersError?
        let expectation = XCTestExpectation(description: "Should failured.")
        expectation.isInverted = true
        
        sut.getFollowers(of: "test") { result in
            switch result {
            case .success:
                expectation.fulfill()
                XCTFail("The getFollowers method should return with error")
            case .failure(let error):
                receivedError = error
            }
        }
        
        wait(for: [expectation], timeout: 1)
        XCTAssertEqual(receivedError, .invalidUsername, "The received error should be invalid usename")
    }

    func testGetFollowersWithRequestFail() {
        followersProviderMock.error = .requestFail
        var receivedError: GetFollowersError?
        let expectation = XCTestExpectation(description: "Should failured.")
        expectation.isInverted = true
        
        sut.getFollowers(of: "test") { result in
            switch result {
            case .success:
                expectation.fulfill()
                XCTFail("The getFollowers method should return with error")
            case .failure(let error):
                receivedError = error
            }
        }
        
        wait(for: [expectation], timeout: 1)
        XCTAssertEqual(receivedError, .requestFail, "The received error should be request fail")
    }
}

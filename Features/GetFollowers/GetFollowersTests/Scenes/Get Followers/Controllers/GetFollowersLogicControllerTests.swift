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
    private let followersProviderMock = GetFollowersServiceMock()
    private var receivedUserInformation: UserInformation?
    private var receivedError: GetFollowersError?
    private lazy var sut: GetFollowersLogicController = {
        GetFollowersLogicController(provider: followersProviderMock)
    }()

    func testGetFollowersWithSuccess() {
        let expectation = XCTestExpectation(description: "Should succeded.")
        sut.fetchFollowers(for: "test") { result in
            switch result {
            case .success(let followers):
                expectation.fulfill()
                self.receivedUserInformation = followers
            case .failure:
                XCTFail("The getFollowers method should return with success")
            }
        }
        
        wait(for: [expectation], timeout: 1)
        XCTAssertNotNil(receivedUserInformation, "The received followers on success should not be nil")
    }

    func testGetFollowersWithInvalidUser() {
        followersProviderMock.error = .invalidUsername
        let expectation = XCTestExpectation(description: "Should failured.")
        expectation.isInverted = true
        
        sut.fetchFollowers(for: "test") { [unowned self] result in
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
        let expectation = XCTestExpectation(description: "Should failured.")
        expectation.isInverted = true
        
        sut.fetchFollowers(for: "test") { [unowned self] result in
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

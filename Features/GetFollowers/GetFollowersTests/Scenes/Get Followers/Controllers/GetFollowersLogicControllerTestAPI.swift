//
//  GetFollowersLogicControllerTestsAPI.swift
//  GetFollowersTests
//
//  Created by José Victor Pereira Costa on 21/02/21.
//  Copyright © 2021 José Victor Pereira Costa. All rights reserved.
//
import XCTest
import Commons
@testable import GetFollowers

final class GetFollowersLogicControllerTestAPI {
    private let userInformationServiceMock = UserInformationServiceMock()
    private var receivedUserInformation: UserInformation?
    private var receivedError: GetFollowersError?
    private lazy var sut: GetFollowersLogicController = {
        let provider = GetFollowersProvider(userInformationService: userInformationServiceMock)
        return GetFollowersLogicController(provider: provider)
    }()

    func executeFailedSearchForTestFollowers(with expectation: XCTestExpectation) {
        sut.fetchUserInformation(for: "test") { [unowned self] result in
            switch result {
            case .success:
                XCTFail("The fetchUserInformation method should return with error")
            case .failure(let error):
                expectation.fulfill()
                self.receivedError = error
            }
        }
    }

    func prepareProviderWithInvalidUser() {
        userInformationServiceMock.error = .invalidUsername
    }

    func prepareProviderWithFailedRequest() {
        userInformationServiceMock.error = .requestFail
    }

    func executeSuccessfulSearchForTestFollowers(with expectation: XCTestExpectation) {
        sut.fetchUserInformation(for: "test") { result in
            switch result {
            case .success(let followers):
                expectation.fulfill()
                self.receivedUserInformation = followers
            case .failure:
                XCTFail("The fetchUserInformation method should return with success")
            }
        }
    }

    func checkIfReceivedUserInformation() {
        XCTAssertNotNil(receivedUserInformation, "The received followers on success should not be nil")
    }

    func checkIfRequestFailed() {
        XCTAssertEqual(receivedError, .requestFail, "The received error should be request fail")
    }

    func checkIfUsernameIsInvalid() {
        XCTAssertEqual(receivedError, .invalidUsername, "The received error should be invalid usename")
    }
}

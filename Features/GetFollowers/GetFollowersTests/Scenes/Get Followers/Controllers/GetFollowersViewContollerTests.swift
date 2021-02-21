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
    private let test = GetFollowersViewControllerTestAPI()
    
    func testGetFollowersFailWithRequestFailMessage() {
        let expectation = XCTestExpectation(description: "The onAlertPresented closure should be executed")
        test.prepareAlertPresenterMock(with: expectation)
        test.prepareLogicController(with: .requestFail)
        
        test.callGetFollowersButtonTappedMethod()
        
        wait(for: [expectation], timeout: 1)
        test.checkPresentedError(error: .requestFail)
    }
    
    func testGetFollowersFailWithIvalidUsernameMessage() {
        let expectation = XCTestExpectation(description: "The onAlertPresented closure should be executed")
        test.prepareAlertPresenterMock(with: expectation)
        test.prepareLogicController(with: .invalidUsername)
        
        test.callGetFollowersButtonTappedMethod()
        
        wait(for: [expectation], timeout: 1)
        test.checkPresentedError(error: .invalidUsername)
    }
    
    func testGetFollowersWithSuccess() {
        let expectation = XCTestExpectation(description: "The viewControllerDidGetFollowers should be called")
        test.prepareGetFollowersControllerDalegate(with: expectation)
        
        test.callGetFollowersButtonTappedMethod()
        
        wait(for: [expectation], timeout: 1)
        test.checkViewControllerFetchDataWithSuccess()
    }
    
    func testGetFollowerViewControllerNotifyKeyboardDidAppeard() {
        test.prepareViewController()
        
        test.setUpKeyboardAsTouched()
        
        test.checkViewDidScroll()
    }
}

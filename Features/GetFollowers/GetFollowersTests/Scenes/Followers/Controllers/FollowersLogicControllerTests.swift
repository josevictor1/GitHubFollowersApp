//
//  FollowersLogicControllerTests.swift
//  GetFollowersTests
//
//  Created by José Victor Pereira Costa on 21/02/21.
//  Copyright © 2021 José Victor Pereira Costa. All rights reserved.
//

import XCTest

final class FollowersLogicControllerTests: XCTestCase {
    private let test = FollowersLogicControllerTestsAPI()
    
    func testLoadFollowers() {
        let expectation = XCTestExpectation(description: "The output controller should be called when followers load.")
        test.setUpLogicControllerWithFollowers()
        test.setUpLogicControllerOutput(with: expectation)
        
        test.loadTestFollowers()
        
        wait(for: [expectation], timeout: 1)
        test.checkIfFollowersWereLoad()
    }
    
    func testLoadNextPage() {
        let expectation = XCTestExpectation(description: "The output controller should be called when followers load.")
        test.setUpLogicControllerWithFollowers()
        test.setUpLogicControllerOutput(with: expectation)
        
        test.loadNextFollowersPage()
        
        wait(for: [expectation], timeout: 1)
        test.checkIfFollowersWereLoad()
    }
    
    func testSearchFollowersByLogin() {
        let expectation = XCTestExpectation(description: "The output controller should be called when search followers.")
        test.setUpLogicControllerWithFollowers()
        test.loadTestFollowers()
        test.setUpLogicControllerOutput(with: expectation)
        
        test.searchForTestFollowers()
        
        wait(for: [expectation], timeout: 1)
        test.checkIfFollowersWereFiltered()
    }
    
    func testSelectFollower() {
        let expectation = XCTestExpectation(description: "The output controller should be caller when a follower is selected.")
        test.setUpLogicControllerWithFollowers()
        test.setUpLogicControllerOutput(with: expectation)
        test.loadTestFollowers()
        
        test.selectFollowerAtFirstPosition()
        
        wait(for: [expectation], timeout: 1)
        test.checkIfSelectedFollowerIsTheExpected()
    }
    
    func testCancelSearch() {
        let expectation = XCTestExpectation(description: "The output controller should be caller when search is canceled.")
        test.setUpLogicControllerWithFollowers()
        test.setUpSearchState(with: expectation)
        
        test.cancelSearch()
        
        wait(for: [expectation], timeout: 1)
        test.checkIfFollowersAreNotFiltered()
    }
    
    func testFollowersNotFound() {
        let expectation = XCTestExpectation(description: "The output controller should be called when followers load.")
        test.setUpLogicControllerOutput(with: expectation)
        test.setUpLogicControllerWithoutFollowers()
        
        test.loadTestFollowers()
        
        wait(for: [expectation], timeout: 1)
        test.checkIfFollowersNotFound()
    }
    
    func testLoadFollowersWithError() {
        let expectation = XCTestExpectation(description: "The output controller should be called when followers load with error.")
        test.setUpLogicControllerWithFollowers()
        test.setUpLoadFollowersWithError()
        test.setUpLogicControllerOutput(with: expectation)
        
        test.loadTestFollowers()
        
        wait(for: [expectation], timeout: 1)
        test.checkIfErrorRequestFailedWasShown()
    }
    
    func testSelectFollowerFilteredOnSearch() {
        let expectation = XCTestExpectation(description: "The output controller should be called when search followers.")
        test.setUpLogicControllerWithFollowers()
        test.loadTestFollowers()
        test.setUpLogicControllerOutput(with: expectation)
        
        test.searchForTestFollowers()
        test.selectFollowerAtFirstPosition()
        
        wait(for: [expectation], timeout: 1)
        test.checkIfSelectedFollowerIsTheExpected()
    }
    
    func testSearchFilterDisappearsAfterClean() {
        let expectation = XCTestExpectation(description: "The output controller should be called when search followers.")
        test.setUpLogicControllerWithFollowers()
        test.loadTestFollowers()
        test.setUpLogicControllerOutput(with: expectation)
        
        test.searchForTestFollowers()
        test.deleteSearchFilter()
        
        wait(for: [expectation], timeout: 1)
        test.checkIfFollowersAreNotFiltered()
    }
}

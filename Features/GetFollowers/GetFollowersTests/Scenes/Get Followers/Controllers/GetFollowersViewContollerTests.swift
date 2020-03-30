//
//  GetFollowersViewControllerTests.swift
//  GitHubTests
//
//  Created by José Victor Pereira Costa on 23/03/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import XCTest
@testable import GetFollowers

class GetFollowersViewControllerTests: XCTestCase {

    func testOnGetFollowersButtonTapped() {
        let sut: GetFollowersViewController = .makeGetFollowers()

        var getFollowersTapped = false
        let username = "test"
        var receivedUsername = String()

        sut.onGetFollowersButtonTapped = { userName in
            getFollowersTapped.toggle()
            receivedUsername = userName ?? ""
        }

        sut.getFollowersView.onGetFollowersButtonTapped?(username)

        XCTAssert(getFollowersTapped, "The get followers button should be tapped")
        XCTAssertEqual(username, receivedUsername, "The received user name should be equal to typed username")
    }
    
    func testGetFollowersFailWithRequestFailMessage() {
   
        let modelControllerMock = GetFollowersModelControllerMock()
        let alertPresenterMock = GetFollowersAlertPresenterMock()
        
        var presentedError: GetFollowersError?
        alertPresenterMock.onAlertPresented = { error in
            presentedError = error
        }
        
        let sut = makeSUT(modelController: modelControllerMock, presenter: alertPresenterMock)

        let username = "test"
        sut.onGetFollowersButtonTapped(username)

        XCTAssertEqual(presentedError, .requestFail, "The alert should be presented with request fail error")
    }
    
    func testGetFollowersFailWithIvalidUsernameMessage() {
        let modelControllerMock = GetFollowersModelControllerMock()
        let alertPresenterMock = GetFollowersAlertPresenterMock()
        modelControllerMock.error = .invalidUsername
        
        var presentedError: GetFollowersError?
        alertPresenterMock.onAlertPresented = { error in
            presentedError = error
        }
        
        let sut = makeSUT(modelController: modelControllerMock, presenter: alertPresenterMock)
        
        let username = "teste"
        sut.onGetFollowersButtonTapped(username)
        
        XCTAssertEqual(presentedError, .invalidUsername, "The alert should be presented with invalid username error")
    }
    
    func testGetFollowersSucess() {
        
        let delegateMock = GetFollowersViewControllerDelegateMock()
        let modelControllerMock = GetFollowersModelControllerMock()
        let sut = makeSUT(modelController: modelControllerMock)
        
        modelControllerMock.followers = []
        sut.delegate = delegateMock
        let username = "test"
        
        sut.onGetFollowersButtonTapped(username)
        
        XCTAssertTrue(delegateMock.didViewControllerGotFollowers, "The delegate shold be called")
    }
    
    
    func makeSUT(modelController: GetFollowersModel = GetFollowersModelControllerMock(),
                 presenter: GetFollowersAlertPresenterProtocol = GetFollowersAlertPresenterMock()) -> GetFollowersViewController {
        let viewController = GetFollowersViewController()
        viewController.modelController = modelController
        viewController.presenter = presenter
        return viewController
    }
    
}

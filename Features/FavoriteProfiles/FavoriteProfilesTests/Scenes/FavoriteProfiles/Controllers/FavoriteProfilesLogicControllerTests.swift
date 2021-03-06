//
//  FavoriteProfilesLogicControllerTests.swift
//  FavoriteProfilesLogicControllerTests
//
//  Created by José Victor Pereira Costa on 03/06/21.
//  Copyright © 2021 José Victor Pereira Costa. All rights reserved.
//

import XCTest
import Commons
@testable import FavoriteProfiles

final class FavoriteProfilesLogicControllerTests: XCTestCase {
    
    private let mocks = FavoriteProfilesMocks()
    
    private func makeSUT(viewController: FavoriteProfilesLogicControllerOutput,
                         provider: FavoriteProfilesProvider = FavoriteProfilesServiceMock()) -> FavoriteProfilesLogicController {
        let sut = FavoriteProfilesLogicController(provider: provider)
        sut.viewController = viewController
        return sut
    }
    
    func testLoadFavoriteProfiles() {
        let viewControllerMock = FavoriteProfilesTableViewControllerMock()
        let sut = makeSUT(viewController: viewControllerMock)
        
        sut.loadProfiles()

        XCTAssertTrue(viewControllerMock.favoriteProfilesUpdated)
    }
    
    func testHandleFaiureOnLoadFavoriteProfile() {
        let viewControllerMock = FavoriteProfilesTableViewControllerMock()
        let providerMock = FavoriteProfilesServiceMock()
        providerMock.error = NSError(domain: String(), code: NSNotFound, userInfo: nil)
        let sut = makeSUT(viewController: viewControllerMock, provider: providerMock)
        
        sut.loadProfiles()
    
        XCTAssertTrue(viewControllerMock.failedOnUpdateFavoriteProfiles)
    }
    
    func testAddFavoriteProfile() {
        let viewControllerMock = FavoriteProfilesTableViewControllerMock()
        let sut = makeSUT(viewController: viewControllerMock)
        
        sut.loadProfiles()
        sut.add(selectedUser: mocks.selectedUserMock)
        
        XCTAssertTrue(viewControllerMock.favoriteProfiles.contains(mocks.favoriteProfileMock))
    }
    
    func testDeleteFavoriteProfile() {
        let viewControllerMock = FavoriteProfilesTableViewControllerMock()
        viewControllerMock.favoriteProfiles = mocks.favoriteProfilesMock
        let providerMock = FavoriteProfilesServiceMock()
        providerMock.profiles = mocks.favoriteProfilesMock
        
        let sut = makeSUT(viewController: viewControllerMock,
                          provider:  providerMock)
        sut.loadProfiles()
        sut.deleteProfile(atIndex: .zero)
        
        XCTAssertNotEqual(viewControllerMock.favoriteProfiles.count, .zero)
        XCTAssertNotEqual(viewControllerMock.favoriteProfiles.count, mocks.numberOfFavoriteMockProfiles)
    }
    
    func testSearchFavoriteProfile() {
        let viewControllerMock = FavoriteProfilesTableViewControllerMock()
        let providerMock = FavoriteProfilesServiceMock()
        providerMock.profiles = mocks.favoriteProfilesMock
        
        let sut = makeSUT(viewController: viewControllerMock,
                          provider: providerMock)
        
        sut.loadProfiles()
        sut.searchProfile(byFilter: "test0")
        
        XCTAssertEqual(viewControllerMock.favoriteProfiles.first, mocks.favoriteProfilesMock.first)
    }
}

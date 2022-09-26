//
//  FollowersViewControllerTestsAPI.swift
//  GetFollowersTests
//
//  Created by José Victor Pereira Costa on 22/02/21.
//  Copyright © 2021 José Victor Pereira Costa. All rights reserved.
//

import XCTest
import Commons
@testable import GetFollowers

final class FollowersViewControllerTestsAPI {
    
    private let logicControllerMock = FollowersLogicControllerMock()
    private let coordinatorMock = FollowersCoordinatorMock()
    private let presenterMock = GetFollowersAlertPresenterMock()
    private let userInformationMock = SelectedUserInformation(login: "test",
                                                              name: "test",
                                                              avatarURL: "test",
                                                              numberOfFollowers: 1)
    
    private lazy var sut: FollowersCollectionViewController = {
        let viewController = FollowersCollectionViewController(logicController: logicControllerMock,
                                                               presenter: presenterMock,
                                                               coordinator: coordinatorMock)
        return viewController
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: CGRect(x: .zero, y: .zero, width: 100, height: 100))
        let bottomOffset = CGPoint(x: 0, y: 200)
        scrollView.setContentOffset(bottomOffset, animated: false)
        return scrollView
    }()
    
    // MARK: - SUT Setup
    
    func loadViewController() {
        sut.viewDidLoad()
    }
    
    func loadMockFollowers() {
        sut.didFetchFollowers((.zero...40).map { Follower(imageURL: "\($0)", login: "\($0)") })
    }
    
    func setUpLoadFollowersWithError() {
        sut.failedOnFetchFollowers(.requestFail)
    }
    
    func setUpFollowersNotFound() {
        sut.followersNotFound()
    }
    
    // MARK: - Actions
    
    func tapFirstFollower() {
        sut.collectionView(sut.collectionView,
                           didSelectItemAt: IndexPath(row: 0, section: 0))
    }
    
    func tapCancel() {
        sut.searchBarCancelButtonClicked(UISearchBar())
    }
    
    func setUpSearch() {
        sut.searchBar(UISearchBar(), textDidChange: "0")
    }
    
    func scrollDown() {
        sut.scrollViewDidScroll(scrollView)
    }
    
    // MARK: - Checks
    
    func checkIfItemWasSelected() {
        XCTAssertEqual(logicControllerMock.selectedIndex, .zero)
    }
    
    func checkIfNextPageWasLoaded() {
        XCTAssertTrue(logicControllerMock.wasNextPagedLoaded)
    }
    
    func checkIfFollowerWasSearched() {
        XCTAssertEqual(logicControllerMock.searchedLogin, "0")
    }
    
    func checkIfSearchedWasCanceled() {
        XCTAssertTrue(logicControllerMock.wasSearchCanceled)
    }
    
    func checkIfFollowersWereLoaded() {
        XCTAssertTrue(logicControllerMock.wereFollowersLoaded)
    }
    
    func checkIfPresenterWasCalledWithError() {
        XCTAssertEqual(presenterMock.presentedError, .requestFail)
    }
    
    func checkIfPresentFollowersNotFoundEmptyState() {
        let topView = sut.view.subviews.last ?? UIView()
        XCTAssertTrue(topView is FollowersEmptyBackgroundView)
    }
}

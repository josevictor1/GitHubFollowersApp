//
//  FollowersLogicController.swift
//  GetFollowers
//
//  Created by José Victor Pereira Costa on 19/07/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import Commons

typealias SearchFollowersCompletion = (Result<[Follower], GetFollowersError>) -> Void

protocol FollowersLogicControllerProtocol {
    var userInformation: SelectedUserInformation { get }
    func loadFollowers()
    func loadNextPage()
    func searchFollower(withLogin login: String)
    func selectFollower(atIndex index: Int)
    func cancelSearch()
}

protocol FollowersLogicControllerOutput: AnyObject {
    func showFollowersNotFound()
    func showFailureOnFetchFollowers(_ error: GetFollowersError)
    func showFollowers(_ followers: [Follower])
    func showUserInformation(for login: String)
}

final class FollowersLogicController: FollowersLogicControllerProtocol {
    
    private unowned let viewController: FollowersLogicControllerOutput
    private(set) var userInformation: SelectedUserInformation
    private let service: FollowersProvider
    private let paginationController: PaginationControllerProtocol
    private var followers = [Follower]()
    private var filteredFollowers = [Follower]()
    private var isLoadingData = false

    init(viewController: FollowersLogicControllerOutput,
         userFollowers: SelectedUserInformation,
         paginationController: PaginationControllerProtocol,
         service: FollowersProvider = FollowersService()) {
        self.viewController = viewController
        self.userInformation = userFollowers
        self.paginationController = paginationController
        self.service = service
    }

    func loadNextPage() {
        guard paginationController.areThereLeftPages,
              !isLoadingData else { return }
        loadFollowers()
        isLoadingData = true
    }

    func loadFollowers() {
        if paginationController.areThereLeftPages {
            fetchFollowers()
        } else {
            viewController.showFollowersNotFound()
        }
    }

    private func fetchFollowers() {
        let request = FollowersRequest(username: userInformation.login,
                                       pageNumber: paginationController.currentPage,
                                       resultsPerPage: paginationController.currentPageSize)
        fetchFollowers(with: request)
    }

    private func fetchFollowers(with request: FollowersRequest) {
        service.fetchFollowes(for: request) { [unowned self] result in
            switch result {
            case .success(let response):
                self.handleSuccess(with: response)
            case .failure(let error):
                self.viewController.showFailureOnFetchFollowers(error)
            }
            self.isLoadingData = false
        }
    }

    private func handleSuccess(with response: [FollowerResponse]) {
        let followers = convertIntoFollowerList(response)
        updateFollowers(with: followers)
    }

    private func convertIntoFollowerList(_ followerResponse: [FollowerResponse]) -> [Follower] {
        followerResponse.map { Follower(response: $0) }
    }

    private func updateFollowers(with response: [Follower]) {
        followers += response
        paginationController.turnPage()
        viewController.showFollowers(followers)
    }

    func searchFollower(withLogin login: String) {
        if login.isEmpty {
            showUnfilteredFollowers()
        } else {
            searchFollowerLocally(withLogin: login)
        }
    }

    func selectFollower(atIndex index: Int) {
        if filteredFollowers.isEmpty {
            viewController.showUserInformation(for: followers[index].login)
        } else {
            viewController.showUserInformation(for: filteredFollowers[index].login)
        }
    }

    private func cleanFilteredFollowers() {
        filteredFollowers.removeAll()
    }

    private func searchFollowerLocally(withLogin login: String) {
        filteredFollowers = filterPlayers(withLogin: login)
        viewController.showFollowers(filteredFollowers)
    }

    private func filterPlayers(withLogin login: String) -> [Follower] {
        followers.filter { $0.login.contains(login) }
    }

    func cancelSearch() {
        showUnfilteredFollowers()
    }

    private func showUnfilteredFollowers() {
        viewController.showFollowers(followers)
        cleanFilteredFollowers()
    }
}

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
    func loadFavoriteState()
    func loadNextPage()
    func addSelectedUsersToFavorite()
    func searchFollower(withLogin login: String)
    func selectFollower(atIndex index: Int)
    func cancelSearch()
}

protocol FollowersLogicControllerOutput: AnyObject {
    func failedAddUser()
    func didAddUser()
    func followersNotFound()
    func failedOnFetchFollowers(_ error: GetFollowersError)
    func didFetchFollowers(_ followers: [Follower])
    func showUserInformation(forLogin login: String)
    func didFetchSelectedUserOnFavorites()
    func selectedUserNotFound()
}

final class FollowersLogicController: FollowersLogicControllerProtocol {
    
    weak var viewController: FollowersLogicControllerOutput?
    private(set) var userInformation: SelectedUserInformation
    private let service: FollowersProvider
    private let paginationController: PaginationControllerProtocol
    private var followers = [Follower]()
    private var filteredFollowers = [Follower]()
    private var isLoadingData = false
    private var isSelectedUserFavorited = false

    init(userFollowers: SelectedUserInformation,
         paginationController: PaginationControllerProtocol,
         service: FollowersProvider = FollowersService()) {
        self.userInformation = userFollowers
        self.paginationController = paginationController
        self.service = service
    }

    func loadNextPage() {
        guard paginationController.areThereLeftPages,
              !isLoadingData else { return }
        fetchFollowers()
        isLoadingData = true
    }

    func loadFollowers() {
        if paginationController.areThereLeftPages {
            fetchFollowers()
        } else {
            viewController?.followersNotFound()
        }
    }

    private func fetchFollowers() {
        let request = FollowersRequest(username: userInformation.login,
                                       pageNumber: paginationController.currentPage,
                                       resultsPerPage: paginationController.currentPageSize)
        fetchFollowers(with: request)
    }

    private func fetchFollowers(with request: FollowersRequest) {
        service.fetchFollowers(for: request) { [weak self] result in
            switch result {
            case .success(let response):
                self?.handleSuccess(with: response)
            case .failure(let error):
                self?.viewController?.failedOnFetchFollowers(error)
            }
            self?.isLoadingData = false
        }
    }

    private func handleSuccess(with response: [FollowerResponse]) {
        let followers = convertIntoFollowerList(response)
        updateFollowers(with: followers)
    }

    private func convertIntoFollowerList(_ followerResponse: [FollowerResponse]) -> [Follower] {
        followerResponse.map(Follower.init)
    }

    private func updateFollowers(with response: [Follower]) {
        followers += response
        paginationController.turnPage()
        viewController?.didFetchFollowers(followers)
    }

    func searchFollower(withLogin login: String) {
        if login.isEmpty {
            showUnfilteredFollowers()
        } else {
            searchFollowerLocally(withLogin: login)
        }
    }

    func selectFollower(atIndex index: Int) {
        let login = filteredFollowers.isEmpty ? followers[index].login : filteredFollowers[index].login
        viewController?.showUserInformation(forLogin: login)
    }

    private func cleanFilteredFollowers() {
        filteredFollowers.removeAll()
    }

    private func searchFollowerLocally(withLogin login: String) {
        filteredFollowers = filterPlayers(withLogin: login)
        viewController?.didFetchFollowers(filteredFollowers)
    }

    private func filterPlayers(withLogin login: String) -> [Follower] {
        followers.filter { $0.login.contains(login) }
    }

    func cancelSearch() {
        showUnfilteredFollowers()
    }

    private func showUnfilteredFollowers() {
        viewController?.didFetchFollowers(followers)
        cleanFilteredFollowers()
    }
    
    func loadFavoriteState() {
        service.fetchFavorites { [weak self] result in
            switch result {
            case .success(let response):
                self?.checkLoginOn(favorites: response)
            case .failure:
                self?.viewController?.didFetchSelectedUserOnFavorites()
            }
        }
    }
    
    private func checkLoginOn(favorites: [String]) {
        isSelectedUserFavorited = favorites.contains(userInformation.login)
        if isSelectedUserFavorited {
            viewController?.didFetchSelectedUserOnFavorites()
        } else {
            viewController?.selectedUserNotFound()
        }
    }
    
    func addSelectedUsersToFavorite() {
        service.addSelectedUserToFavorites(userInformation) { result in
            switch result {
            case .success:
                viewController?.didAddUser()
            case .failure:
                viewController?.failedAddUser()
            }
        }
    }
}

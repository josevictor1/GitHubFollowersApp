//
//  FollowersLogicController.swift
//  GetFollowers
//
//  Created by José Victor Pereira Costa on 19/07/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import Foundation

typealias SearchFollowersCompletion = (Result<[Follower], GetFollowersError>) -> Void

protocol FollowersLogicControllerProtocol {
    var userLogin: String { get }
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
    private let userInformation: UserInformation
    private let service: FollowersProvider
    private unowned let viewController: FollowersLogicControllerOutput
    private let minimumNumberOfResultsPerPage = 20
    private var followers = [Follower]()
    private var filteredFollowers = [Follower]()
    private var currentPage: Int = 1
    private var isLoadingData = false
    private lazy var remainingResults = userInformation.numberOfFollowers
    var userLogin: String { userInformation.login }
    
    init(viewController: FollowersLogicControllerOutput,
         userFollowers: UserInformation,
         service: FollowersProvider = FollowersService()) {
        self.viewController = viewController
        self.userInformation = userFollowers
        self.service = service
    }
    
    func loadNextPage() {
        guard remainingResults > .zero, !isLoadingData else { return }
        loadFollowers()
        isLoadingData = true
    }
    
    func loadFollowers() {
        if userInformation.numberOfFollowers > .zero {
            fetchFollowers()
        } else {
            viewController.showFollowersNotFound()
        }
    }
    
    private func fetchFollowers() {
        let resultsPerPage = currentPage == .zero ? minimumNumberOfResultsPerPage : remainingResults
        let request = FollowersRequest(username: userLogin,
                                       pageNumber: currentPage,
                                       resultsPerPage: resultsPerPage)
        fetchFollowers(with: request)
    }
    
    private func fetchFollowers(with request: FollowersRequest) {
        fetchFollowers(with: request) { [unowned self] result in
            switch result {
            case .success(let reponse):
                self.updateFollowers(with: reponse)
            case .failure(let error):
                self.viewController.showFailureOnFetchFollowers(error)
            }
        }
    }
    
    private func updateFollowers(with response: [Follower]) {
        set(followers: response)
        updateRemainingPages()
        updateRemainingResults()
        viewController.showFollowers(followers)
    }
    
    private func set(followers: [Follower]) {
        self.followers += followers
        if followers.isEmpty {
            viewController.showFollowersNotFound()
        }
    }
    
    private func updateRemainingPages() {
        currentPage += 1
    }
    
    private func updateRemainingResults() {
        if remainingResults >= minimumNumberOfResultsPerPage {
            remainingResults -= minimumNumberOfResultsPerPage
        } else {
            remainingResults = .zero
        }
    }
    
    private func fetchFollowers(with request: FollowersRequest, completion: @escaping SearchFollowersCompletion) {
        service.fetchFollowes(for: request) { [unowned self] result in
            switch result {
            case .success(let response):
                self.handleSuccess(with: response, completion: completion)
            case .failure(let error):
                completion(.failure(error))
            }
            self.isLoadingData = false
        }
    }
    
    private func handleSuccess(with response: [FollowerResponse], completion: @escaping SearchFollowersCompletion) {
        let followers = convertIntoFollowerList(response)
        completion(.success(followers))
    }
    
    private func convertIntoFollowerList(_ followerResponse: [FollowerResponse]) -> [Follower] {
        followerResponse.map { Follower(response: $0) }
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
        guard !filteredFollowers.isEmpty else { return }
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

//
//  FollowersLogicController.swift
//  GetFollowers
//
//  Created by José Victor Pereira Costa on 19/07/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import Foundation

typealias SearchFollowersCompletion = (Result<[Follower], Error>) -> Void

protocol FollowersLogicControllerProtocol {
    var userLogin: String { get }
    func loadFollowers()
    func loadNextPage()
    func searchFollower(withLogin login: String)
}

protocol FollowersLogicControllerOutput: AnyObject {
    func showFollowerNotFound()
    func showFailureOnFetchFollowers()
    func showFollowers(_ followers: [Follower])
}

final class FollowersLogicController: FollowersLogicControllerProtocol {
    private let userInformation: UserInformation
    private let service: FollowersProvider
    private unowned let viewController: FollowersLogicControllerOutput
    private let minimumNumberOfResultsPerPage = 20
    private var followers = [Follower]()
    private var currentPage: Int = 1
    private var isLoadingData = false
    
    private lazy var remainingResults: Int = {
        userInformation.numberOfFollowers
    }()
    
    var userLogin: String {
        userInformation.login
    }
    
    init(viewController: FollowersLogicControllerOutput,
         userFollowers: UserInformation,
         service: FollowersProvider = FollowersService()) {
        self.viewController = viewController
        self.userInformation = userFollowers
        self.service = service
    }
    
    func searchFollower(withLogin login: String) {
        if login.isEmpty {
            viewController.showFollowers(followers)
        } else {
            searchFollowerLocally(withLogin: login)
        }
    }
    
    private func searchFollowerLocally(withLogin login: String) {
        let filteredFollowers = filterPlayers(withLogin: login)
        guard !filteredFollowers.isEmpty else {
            return viewController.showFollowerNotFound()
        }
        viewController.showFollowers(filteredFollowers)
    }
    
    private func filterPlayers(withLogin login: String) -> [Follower] {
        followers.filter { $0.login.contains(login) }
    }
    
    func loadNextPage() {
        guard remainingResults > .zero, !isLoadingData else { return }
        loadFollowers()
        isLoadingData = true
    }
    
    func loadFollowers() {
        let resultsPerPage = currentPage == .zero ? minimumNumberOfResultsPerPage : remainingResults
        let request = FollowersRequest(username: userLogin,
                                       pageNumber: currentPage,
                                       resultsPerPage: resultsPerPage)
        fetchFollowers(with: request)
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
    
    private func fetchFollowers(with request: FollowersRequest) {
        fetchFollowers(with: request) { [unowned self] result in
            switch result {
            case .success(let reponse):
                self.updateFollowers(with: reponse)
            case .failure:
                self.viewController.showFailureOnFetchFollowers()
            }
        }
    }
    
    private func updateFollowers(with response: [Follower]) {
        followers += response
        updateRemainingPages()
        updateRemainingResults()
        viewController.showFollowers(followers)
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
}

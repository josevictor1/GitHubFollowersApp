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
}

protocol FollowersLogicControllerOutput: AnyObject {
    func showFailureOnFetchFollowers()
    func showFollowers(_ followers: [Follower])
}

final class FollowersLogicController: FollowersLogicControllerProtocol {
    private let userInformation: UserInformation
    private let service: FollowersProvider
    private let resultsPerPage = 20
    private unowned let viewController: FollowersLogicControllerOutput
    private var followers = [Follower]()
    
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
    
    func loadFollowers() {
        searchFollowers() { [unowned self] result in
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
        viewController.showFollowers(followers)
    }
    
    private func searchFollowers(completion: @escaping SearchFollowersCompletion) {
        let followersRequest = FollowersRequest(username: userLogin,
                                                pageNumber: 0,
                                                resultsPerPage: resultsPerPage)
        service.searchFollowers(for: followersRequest) { [unowned self] result in
            switch result {
            case .success(let response):
                self.handleSuccess(with: response, completion: completion)
            case .failure(let error):
                completion(.failure(error))
            }
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

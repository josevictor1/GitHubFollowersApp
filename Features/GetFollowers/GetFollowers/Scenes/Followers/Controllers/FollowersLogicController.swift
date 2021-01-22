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
    var username: String { get }
    func search(for follower: String?, completion: @escaping SearchFollowersCompletion)
}

final class FollowersLogicController: FollowersLogicControllerProtocol {
    private let userInformation: UserInformation
    private let service: FollowersProvider
    private var followers = [Follower]()
    
    var username: String {
        userInformation.login
    }
    
    init(userFollowers: UserInformation, service: FollowersProvider = FollowersService()) {
        self.userInformation = userFollowers
        self.service = service
    }
    
    func search(for follower: String?, completion: @escaping SearchFollowersCompletion) {
        guard let follower = follower, !followers.isEmpty else {
            return completion(.success(followers))
        }
        search(for: follower, completion: completion)
    }
    
    private func search(for follower: String, completion: @escaping SearchFollowersCompletion) {
        service.searchFollowers(for: follower) { [unowned self] result in
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

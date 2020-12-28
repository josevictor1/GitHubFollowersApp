//
//  GetFollowersModelController.swift
//  GitHub
//
//  Created by José Victor Pereira Costa on 24/03/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import Foundation

typealias GetFollowersResponseCompletion = ((Result<[Follower], GetFollowersError>) -> Void)

protocol GetFollowersLogicControllerProtocol {
    func getFollowers(of user: String, completion: @escaping GetFollowersResponseCompletion)
}

final class GetFollowersLogicController: GetFollowersLogicControllerProtocol {

    private let provider: GetFollowersProvider

    init(provider: GetFollowersProvider = GetFollowersService()) {
        self.provider = provider
    }

    func getFollowers(of user: String, completion: @escaping GetFollowersResponseCompletion) {
        let request = FollowersRequest(username: user)

//        provider.requestFollowers(request) { [weak self] result in
//            DispatchQueue.main.async {
//                switch result {
//                case .success(let response):
//                    self?.handleSuccess(with: response, completion: completion)
//                case .failure(let error):
//                    completion(.failure(error))
//                }                
//            }
//        }
    }

    private func handleSuccess(with response: [FollowerResponse], completion: GetFollowersResponseCompletion) {
        completion(.success(response.map(Follower.init)))
    }
}

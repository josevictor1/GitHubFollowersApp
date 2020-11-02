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
    
    private let userFollowers: UserFollowers
    private let service: FollowersProvider
    
    var username: String {
        userFollowers.username
    }
    
    init(userFollowers: UserFollowers, service: FollowersProvider = FollowersService()) {
        self.userFollowers = userFollowers
        self.service = service
    }
    
    func search(for follower: String?, completion: @escaping SearchFollowersCompletion) {
        guard let follower = follower, !follower.isEmpty else {
            return completion(.success(userFollowers.followers))
        }
        
        let request = FollowersRequest(username: follower)
        
    }
}

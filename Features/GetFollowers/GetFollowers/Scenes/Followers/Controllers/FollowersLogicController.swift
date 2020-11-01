//
//  FollowersLogicController.swift
//  GetFollowers
//
//  Created by José Victor Pereira Costa on 19/07/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import Foundation

typealias SearchFollowersCompletion = (Result<[Follower], Error>) -> Void
typealias LoadFollowersCompletion = ([Follower]) -> Void

protocol FollowersLogicControllerProtocol {
    var username: String { get }
    func search(for follower: String?, completion: @escaping SearchFollowersCompletion)
}

class FollowersLogicController: FollowersLogicControllerProtocol {
    
    private let userFollowers: UserFollowers
    
    var username: String {
        userFollowers.username
    }
    
    init(userFollowers: UserFollowers) {
        self.userFollowers = userFollowers
    }
    
    func search(for follower: String?, completion: @escaping SearchFollowersCompletion) {
        guard let follower = follower, !follower.isEmpty else {
            return completion(.success(userFollowers.followers))
        }
        completion(.success([]))
    }
}

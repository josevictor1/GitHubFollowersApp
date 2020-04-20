//
//  GetFollowersService.swift
//  GetFollowers
//
//  Created by José Victor Pereira Costa on 31/03/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import Foundation
import Networking

typealias FollowersServiceCompletion = (Result<[FollowerResponse], NSError>) -> Void

protocol FollowersProvider {
    func requestFollowers(_ request: FollowersRequest, completion: @escaping FollowersServiceCompletion)
}

class FollowersService: FollowersProvider {
    
    private let networkingProvider: NetworkingProvider
    
    init(networkingProvider: NetworkingProvider = NetworkingProvider()) {
        self.networkingProvider = networkingProvider
    }
    
    func requestFollowers(_ request: FollowersRequest, completion: @escaping FollowersServiceCompletion) {
        
        let networkingRequest = GetFollowersNetworkingRequest(followerRequest: request)

        networkingProvider.perform(networkingRequest) { (result) in

        }
    }
    
    
}

//
//  GetFollowersService.swift
//  GetFollowers
//
//  Created by José Victor Pereira Costa on 31/03/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import Foundation
import Networking

typealias FollowersServiceCompletion = (Result<[FollowerResponse], NetworkingError>) -> Void

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

        networkingProvider.performRequestWithDecodable(networkingRequest) { (result: Result<[FollowerResponse], NetworkingError>) in
            switch result {
            case .success(let response):
                break
            case .failure(let error):
                completion(.failure())
            }
        }
    }
}

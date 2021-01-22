//
//  FollowersService.swift
//  GetFollowers
//
//  Created by José Victor Pereira Costa on 02/11/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import Networking

protocol FollowersProvider {
    func searchFollowers(for username: String, completion: @escaping (Result<[FollowerResponse], GetFollowersError>) -> Void )
}

final class FollowersService: FollowersProvider {
    
    private let networkingProvider: NetworkingProvider
    
    init(networkingProvider: NetworkingProvider = NetworkingProvider()) {
        self.networkingProvider = networkingProvider
    }
    
    func searchFollowers(for username: String, completion: @escaping (Result<[FollowerResponse], GetFollowersError>) -> Void) {
        let request = FollowersNetworkingRequest(username: username)
        networkingProvider.performRequestWithDecodable(request) { (result: Result<[FollowerResponse], NetworkingError>) in
            completion(result.mapError(GetFollowersError.init))
        }
    }
}

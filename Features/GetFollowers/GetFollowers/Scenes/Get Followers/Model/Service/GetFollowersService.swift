//
//  GetFollowersService.swift
//  GetFollowers
//
//  Created by José Victor Pereira Costa on 31/03/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import Foundation
import Networking

typealias FollowersServiceCompletion = (Result<[FollowerResponse], GetFollowersError>) -> Void

protocol GetFollowersProvider {
    func requestFollowers(_ request: FollowersRequest, completion: @escaping FollowersServiceCompletion)
}

final class GetFollowersService: GetFollowersProvider {

    private let networkingProvider: NetworkingProvider

    init(networkingProvider: NetworkingProvider = NetworkingProvider()) {
        self.networkingProvider = networkingProvider
    }

    func requestFollowers(_ request: FollowersRequest, completion: @escaping FollowersServiceCompletion) {
        let networkingRequest = GetFollowersNetworkingRequest(followerRequest: request)

        networkingProvider.performRequestWithDecodable(networkingRequest) { (result: Result<[FollowerResponse], NetworkingError>) in
            completion(result.mapError(GetFollowersError.init))
        }
    }
}

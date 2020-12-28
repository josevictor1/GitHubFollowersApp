//
//  GetFollowersService.swift
//  GetFollowers
//
//  Created by José Victor Pereira Costa on 31/03/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import Foundation
import Networking

typealias FollowersServiceCompletion = (Result<[UserResponse], GetFollowersError>) -> Void

protocol GetFollowersProvider {
    func requestUserInformation(for username: String, completion: @escaping FollowersServiceCompletion)
}

final class GetFollowersService: GetFollowersProvider {

    private let networkingProvider: NetworkingProvider

    init(networkingProvider: NetworkingProvider = NetworkingProvider()) {
        self.networkingProvider = networkingProvider
    }

    func requestUserInformation(for username: String, completion: @escaping FollowersServiceCompletion) {
        let networkingRequest = GetUserNetworkingRequest(username: username)

        networkingProvider.performRequestWithDecodable(networkingRequest) { (result: Result<[UserResponse], NetworkingError>) in
            completion(result.mapError(GetFollowersError.init))
        }
    }
}

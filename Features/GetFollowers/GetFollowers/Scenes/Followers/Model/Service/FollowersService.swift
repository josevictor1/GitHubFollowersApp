//
//  FollowersService.swift
//  GetFollowers
//
//  Created by José Victor Pereira Costa on 02/11/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import Networking

typealias FetchFollowersResult = Result<[FollowerResponse], NetworkingError>
typealias FetchFollowersRequestCompletion = (Result<[FollowerResponse], GetFollowersError>) -> Void

protocol FollowersProvider {
    func fetchFollowes(for request: FollowersRequest, completion: @escaping FetchFollowersRequestCompletion)
}

final class FollowersService: FollowersProvider {
    private let networkingProvider: NetworkingProvider
    private var dataTask: URLSessionDataTask?
    
    init(networkingProvider: NetworkingProvider = NetworkingProvider()) {
        self.networkingProvider = networkingProvider
    }
    
    func fetchFollowes(for request: FollowersRequest, completion: @escaping FetchFollowersRequestCompletion) {
        let request = FollowersNetworkingRequest(username: request.username,
                                                 pageNumber: request.pageNumber,
                                                 resultsPerPage: request.resultsPerPage)
        fetchFollowers(for: request, completion: completion)
    }
    
    private func fetchFollowers(for request: FollowersNetworkingRequest, completion: @escaping FetchFollowersRequestCompletion) {
        dataTask = networkingProvider.performRequestWithDecodable(request) { (result: FetchFollowersResult) in
            DispatchQueue.main.async { completion(result.mapError(GetFollowersError.init)) }
        }
    }
}

//
//  FollowersService.swift
//  GetFollowers
//
//  Created by José Victor Pereira Costa on 02/11/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import Commons
import Networking
import DataStore

typealias FetchFollowersResult = Result<[FollowerResponse], NetworkingError>
typealias FetchFollowersRequestCompletion = (Result<[FollowerResponse], GetFollowersError>) -> Void
typealias FetchFavoritesResult = Result<[String], Error>
typealias FetchFavoritesCompletion = (FetchFavoritesResult) -> Void
typealias AddSelectedUserCompletion = (Result<Void, Error>) -> Void

protocol FollowersProvider {
    func fetchFollowers(for request: FollowersRequest,
                        completion: @escaping FetchFollowersRequestCompletion)
    func fetchFavorites(completion: FetchFavoritesCompletion)
    func addSelectedUserToFavorites(_ selectedUserInformation: SelectedUserInformation,
                                    completion: AddSelectedUserCompletion)
}

final class FollowersService: FollowersProvider {
    
    private let networkingProvider: NetworkingProvider
    private let dataStore: DataStore

    init(networkingProvider: NetworkingProvider = NetworkingProvider(),
         dataStore: DataStore = .shared) {
        self.networkingProvider = networkingProvider
        self.dataStore = dataStore
        dataStore.set(storageType: .persistent)
    }

    func fetchFollowers(for request: FollowersRequest, completion: @escaping FetchFollowersRequestCompletion) {
        let request = FollowersNetworkingRequest(username: request.username,
                                                 pageNumber: request.pageNumber,
                                                 resultsPerPage: request.resultsPerPage)
        fetchFollowers(for: request, completion: completion)
    }

    private func fetchFollowers(for request: FollowersNetworkingRequest,
                                completion: @escaping FetchFollowersRequestCompletion) {
        networkingProvider.performRequestWithDecodable(request) { (result: FetchFollowersResult) in
            DispatchQueue.main.async { completion(result.mapError(GetFollowersError.init)) }
        }
    }
    
    func fetchFavorites(completion: FetchFavoritesCompletion) {
        do {
            let favorites: [Favorite] = try dataStore.fetch()
            let favoriteLogins = favorites.compactMap { $0.login }
            completion(.success(favoriteLogins))
        } catch {
            completion(.failure(error))
        }
    }
    
    func addSelectedUserToFavorites(_ selectedUserInformation: SelectedUserInformation,
                                    completion: AddSelectedUserCompletion) {
        let favoriteManagedData = makeFavoriteDataManager(for: selectedUserInformation)
        do {
            try dataStore.save(Favorite.self, withData: favoriteManagedData)
            completion(.success(Void()))
        } catch {
            completion(.failure(error))
        }
    }
    
    private func makeFavoriteDataManager(for selectedUserInformation: SelectedUserInformation) -> [String: Any] {
        ["avatarURL": selectedUserInformation.avatarURL,
                            "login": selectedUserInformation.login]
    }
}

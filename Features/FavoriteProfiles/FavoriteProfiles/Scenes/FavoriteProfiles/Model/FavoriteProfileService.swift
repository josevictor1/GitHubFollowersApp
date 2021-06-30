//
//  FavoriteProfileService.swift
//  FavoriteProfiles
//
//  Created by José Victor Pereira Costa on 03/06/21.
//  Copyright © 2021 José Victor Pereira Costa. All rights reserved.
//

import DataStore

typealias LoadFavoriteProfilesCompletion = (Result<[FavoriteProfile], Error>) -> Void
typealias DeleteFavoriteProfileCompletion = (Result<FavoriteProfile, Error>) -> Void
typealias SaveProfileCompletion = (Result<Void, Error>) -> Void

protocol FavoriteProfilesProvider {
    func saveProfile(_ favoriteProfile: FavoriteProfile, completion: SaveProfileCompletion)
    func loadProfiles(completion: LoadFavoriteProfilesCompletion)
    func delete(_ profile: FavoriteProfile, completion: DeleteFavoriteProfileCompletion)
}

final class FavoriteProfilesService: FavoriteProfilesProvider {

    private let dataStore: DataStore
    private var favorites = [Favorite]()
    
    init(dataStore: DataStore = .shared) {
        self.dataStore = dataStore
        dataStore.set(storageType: .persistent)
    }
    
    func saveProfile(_ favoriteProfile: FavoriteProfile, completion: SaveProfileCompletion) {
        do {
            try dataStore.save(Favorite.self, withData: favoriteProfile)
            completion(.success(Void()))
        } catch {
            completion(.failure(error))
        }
    }
    
    func loadProfiles(completion: LoadFavoriteProfilesCompletion) {
        do {
            let favorites: [Favorite] = try dataStore.fetch()
            self.favorites = favorites
            let favoriteProfiles = favorites.compactMap(FavoriteProfile.init)
            completion(.success(favoriteProfiles))
        } catch {
            completion(.failure(error))
        }
    }
    
    func delete(_ profile: FavoriteProfile, completion: DeleteFavoriteProfileCompletion) {
        if let deletedProfile = deleteFavoriteProfile(profile),
           deletedProfile.isDeleted {
            completion(.success(profile))
        } else {
            completion(.failure(FavoriteProfilesServiceError.deleteFailed))
        }
    }
    
    private func deleteFavoriteProfile(_ profile: FavoriteProfile) -> Favorite? {
        guard let index = findManagedObjecFavoriteIndex(for: profile) else { return nil }
        let selectedProfile = favorites[index]
        return dataStore.delete(selectedProfile)
    }
    
    private func findManagedObjecFavoriteIndex(for profile: FavoriteProfile) -> Int? {
        favorites.firstIndex { favorite in
            favorite.login == profile.login
        }
    }
}

enum FavoriteProfilesServiceError: Error {
    case deleteFailed
}

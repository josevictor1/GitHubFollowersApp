//
//  FavoriteProfilesServiceMock.swift
//  FavoriteProfilesTests
//
//  Created by José Victor Pereira Costa on 03/06/21.
//  Copyright © 2021 José Victor Pereira Costa. All rights reserved.
//

import Foundation
@testable import FavoriteProfiles

final class FavoriteProfilesServiceMock: FavoriteProfilesProvider {
    
    var profiles = (0...5).map {
        FavoriteProfile(login: "\($0)",
                        name: "\($0)",
                        avatarURL: "\($0)")
        
    }
    
    var error: Error?

    func saveProfile(_ favoriteProfile: FavoriteProfile, completion: SaveProfileCompletion) {
        
    }
    
    func loadProfiles(completion: LoadFavoriteProfilesCompletion) {
        if let error = error {
            completion(.failure(error))
        } else {
            completion(.success(profiles))
        }
    }
    
    func delete(_ profile: FavoriteProfile, completion: DeleteFavoriteProfileCompletion) {
        
    }
}

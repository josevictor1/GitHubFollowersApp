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
   
    var profiles = [FavoriteProfile]()
    var error: Error?
    
    func loadProfiles(completion: FavoriteProfilesProviderCompletion) {
        if let error = error {
            completion(.failure(error))
        } else {
            completion(.success(profiles))
        }
    }
    
    func delete(_ profile: FavoriteProfile, completion: DeleteFavoriteProfileCompletion) {
        
    }
}

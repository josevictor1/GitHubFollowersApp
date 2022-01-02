//
//  FavoriteProfilesTableViewControllerMock.swift
//  FavoriteProfilesTests
//
//  Created by José Victor Pereira Costa on 03/06/21.
//  Copyright © 2021 José Victor Pereira Costa. All rights reserved.
//

@testable import FavoriteProfiles

final class FavoriteProfilesTableViewControllerMock: FavoriteProfilesLogicControllerOutput {
    
    var favoriteProfiles = [FavoriteProfile]()
    var favoriteProfilesUpdated = false
    var failedOnUpdateFavoriteProfiles = false
    
    func didUpdateFavoriteProfiles(_ favoriteProfiles: [FavoriteProfile]) {
        self.favoriteProfiles = favoriteProfiles
        favoriteProfilesUpdated = true
    }
    
    func didFailOnUpdateFavoriteProfiles() {
        failedOnUpdateFavoriteProfiles = true
    }
}

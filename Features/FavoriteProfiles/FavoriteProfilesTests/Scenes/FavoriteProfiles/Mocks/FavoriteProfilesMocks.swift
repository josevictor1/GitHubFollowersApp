//
//  FavoriteProfilesMock.swift
//  FavoriteProfilesTests
//
//  Created by José Victor Pereira Costa on 03/06/21.
//  Copyright © 2021 José Victor Pereira Costa. All rights reserved.
//

import Commons
import DataStore
@testable import FavoriteProfiles

struct FavoriteProfilesMocks {
    
    let numberOfFavoriteMockProfiles = 6
    
    var favoriteProfilesMock: [FavoriteProfile] {
        (.zero..<numberOfFavoriteMockProfiles).map {
            let mockValue = "test\($0)"
            return FavoriteProfile(login: mockValue,
                                   avatarURL: mockValue)
        }
    }
    
    var selectedUserMock: SelectedUserInformation {
        SelectedUserInformation(login: "0",
                                name: "0",
                                avatarURL: "0",
                                numberOfFollowers: 0)
    }
    
    var favoriteProfileMock: FavoriteProfile {
        FavoriteProfile(selectedUser: selectedUserMock)
    }
}

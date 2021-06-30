//
//  FavoriteProfile+Favorite.swift
//  FavoriteProfiles
//
//  Created by José Victor Pereira Costa on 03/06/21.
//  Copyright © 2021 José Victor Pereira Costa. All rights reserved.
//

import DataStore

extension FavoriteProfile {
    
    init?(favorite: Favorite) {
        guard let login = favorite.login,
              let avatarURL = favorite.avatarURL else { return nil }
        self.init(login: login,
                  avatarURL: avatarURL)
    }
}

//
//  FavoriteProfile.swift
//  FavoriteProfiles
//
//  Created by José Victor Pereira Costa on 03/06/21.
//  Copyright © 2021 José Victor Pereira Costa. All rights reserved.
//

import Foundation

struct FavoriteProfile {
    let uuid = UUID()
    let login: String
    let avatarURL: String
}

extension FavoriteProfile: Equatable { }

extension FavoriteProfile: Hashable { }

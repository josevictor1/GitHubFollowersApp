//
//  FavoriteManagedData.swift
//  DataStore
//
//  Created by José Victor Pereira Costa on 19/07/21.
//  Copyright © 2021 José Victor Pereira Costa. All rights reserved.
//

import Foundation

public struct FavoriteManagedData: ManagedData {
    let avatarURL: String
    let login: String
    let name: String
    
    public init(avatarURL: String, login: String, name: String) {
        self.avatarURL = avatarURL
        self.login = login
        self.name = name
    }
}

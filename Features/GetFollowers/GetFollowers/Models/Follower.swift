//
//  Follower.swift
//  GitHub
//
//  Created by José Victor Pereira Costa on 24/03/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import Foundation

struct Follower {
    let imageURL: String
    let login: String
    let identifier = UUID()
}

extension Follower {
    
    init(response: FollowerResponse) {
        self.login = response.login
        self.imageURL = response.avatarURL
    }
    
    func contains(_ filter: String?) -> Bool {
        guard let filterText = filter else { return true }
        if filterText.isEmpty { return true }
        let lowercasedFilter = filterText.lowercased()
        return login.lowercased().contains(lowercasedFilter)
    }
}

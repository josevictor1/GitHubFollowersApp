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

    init(response: FollowerResponse) {
        self.login = response.login
        self.imageURL = response.avatarURL
    }
}

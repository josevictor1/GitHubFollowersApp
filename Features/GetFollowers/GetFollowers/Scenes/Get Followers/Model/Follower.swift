//
//  Follower.swift
//  GitHub
//
//  Created by José Victor Pereira Costa on 24/03/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import Foundation

struct Follower {
    let photo: String
    let login: String
    
    init(response: FollowerAPIResponse) {
        self.login = response.login
        self.photo = response.avatarURL
    }
}

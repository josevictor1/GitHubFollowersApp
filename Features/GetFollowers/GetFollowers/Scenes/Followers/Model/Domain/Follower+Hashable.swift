//
//  Follower+Hashable.swift
//  GetFollowers
//
//  Created by José Victor Pereira Costa on 27/10/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import Foundation

extension Follower: Hashable {

    static func == (lhs: Follower, rhs: Follower) -> Bool {
        return lhs.identifier == rhs.identifier
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
}

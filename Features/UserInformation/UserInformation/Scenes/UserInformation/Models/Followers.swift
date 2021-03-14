//
//  Followers.swift
//  UserInformation
//
//  Created by José Victor Pereira Costa on 28/02/21.
//

import Foundation

struct Followers {
    let following: Int
    let followers: Int
}

extension Followers: Equatable { }

extension Followers: Hashable { }

//
//  Followers.swift
//  UserInformation
//
//  Created by José Victor Pereira Costa on 28/02/21.
//  Copyright © 2021 José Victor Pereira Costa. All rights reserved.
//

import Foundation

struct Followers {
    let following: String
    let followers: String
}

extension Followers: Equatable { }

extension Followers: Hashable { }

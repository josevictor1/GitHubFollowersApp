//
//  Repos.swift
//  UserInformation
//
//  Created by José Victor Pereira Costa on 28/02/21.
//

import Foundation

struct Repos {
    let repos: Int
    let gists: Int
}

extension Repos: Equatable { }

extension Repos: Hashable { }

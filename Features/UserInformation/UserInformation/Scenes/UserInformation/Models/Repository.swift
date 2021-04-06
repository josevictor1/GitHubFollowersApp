//
//  Repositeries.swift
//  UserInformation
//
//  Created by José Victor Pereira Costa on 28/02/21.
//  Copyright © 2021 José Victor Pereira Costa. All rights reserved.
//

import Foundation

struct Repository {
    let repos: String
    let gists: String
}

extension Repository: Equatable { }

extension Repository: Hashable { }

//
//  Test.swift
//  DataStoreTests
//
//  Created by José Victor Pereira Costa on 11/04/21.
//  Copyright © 2021 José Victor Pereira Costa. All rights reserved.
//

import CoreData
@testable import DataStore

struct FavoriteMock: ManagedData {
    let avatarURL: String
    let login: String
    let name: String
}

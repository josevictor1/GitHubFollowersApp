//
//  GetFollowersError.swift
//  GitHub
//
//  Created by José Victor Pereira Costa on 24/03/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import Foundation

enum GetFollowersError: Error {
    case invalidUsername
    case requestFail
    case timeout
}

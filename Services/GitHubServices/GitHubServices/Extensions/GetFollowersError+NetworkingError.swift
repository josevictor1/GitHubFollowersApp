//
//  GetFollowersError+NetworkingError.swift
//  GitHubServices
//
//  Created by José Victor Pereira Costa on 31/03/21.
//  Copyright © 2021 José Victor Pereira Costa. All rights reserved.
//

import Commons
import Networking

public extension GetFollowersError {
    
    init(_ error: NetworkingError) {
        switch error {
        case .server:
            self = .requestFail
        case .client:
            self = .invalidUsername
        default:
            self = .invalidResponse
        }
    }
}

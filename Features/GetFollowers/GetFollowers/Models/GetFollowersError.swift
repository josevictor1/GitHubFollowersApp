//
//  GetFollowersError.swift
//  GitHub
//
//  Created by José Victor Pereira Costa on 24/03/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import Foundation
import Commons
import Networking

enum GetFollowersError: Error {
    case invalidUsername
    case invalidResponse
    case requestFail

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

    var message: ErrorMessage {
        switch self {
        case .invalidUsername:
            return .invalidUsername
        case .requestFail:
            return .requestFail
        case .invalidResponse:
            return .invalidResponse
        }
    }
}

//
//  GetFollowersError.swift
//  GitHub
//
//  Created by José Victor Pereira Costa on 24/03/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import Foundation
import Networking

public enum GetFollowersError: Error {
    case invalidUsername
    case invalidResponse
    case requestFail
    case invalidData
    case persistenceFail
    case userAlreadyRegistered
    
    public var message: ErrorMessage {
        switch self {
        case .invalidUsername:
            return .invalidUsername
        case .requestFail:
            return .requestFail
        case .invalidResponse:
            return .invalidResponse
        case .invalidData:
            return .invalidData
        case .persistenceFail:
            return .persistenceFail
        case .userAlreadyRegistered:
            return .userAlreadyRegistered
        }
    }
}

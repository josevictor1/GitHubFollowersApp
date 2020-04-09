//
//  NetworkingError+Equatable.swift
//  NetworkingTests
//
//  Created by José Victor Pereira Costa on 09/04/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import Foundation
@testable import Networking

extension NetworkingError: Equatable {
    public static func == (lhs: NetworkingError, rhs: NetworkingError) -> Bool {
        switch (lhs, rhs) {
        case (.invalidURL, .invalidURL):
            return true
        case (.encodingError(let lhsError), .encodingError(let rhsError)):
            return lhsError.localizedDescription == rhsError.localizedDescription
        default:
            return false
        }
    }
}

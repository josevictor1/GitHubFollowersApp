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
        case (.parsing, .parsing):
            return true
        case (.unknown, .unknown):
            return true
        case (.encoding(let lhsError), .encoding(let rhsError)):
            return lhsError.localizedDescription == rhsError.localizedDescription
        case (.client(_ , let lhsResponse), .client(_ , let rhsResponse)):
            return lhsResponse == rhsResponse
        case (.redirection(_ , let lhsResponse), .redirection( _, let rhsResponse)):
            return lhsResponse == rhsResponse
        case (.server(_, let lhsResponse), . server(_, let rhsResponse)):
            return lhsResponse == rhsResponse
        default:
            return false
        }
    }
}

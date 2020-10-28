//
//  Endpoint.swift
//  Networking
//
//  Created by José Victor Pereira Costa on 01/04/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import Foundation

/// Structure that defines the components of the request's endpoint address.
///
/// This structure is based on three elements of URI(Uniform Resource Identifier).
public struct Endpoint {

    /// Attribute that idetify a resource within the scope
    /// of the URI's scheme and naming authority (if any).
    let path: String

    /// Attribute that idicates which protocol should be used, i.e `http`.
    let scheme: URIScheme

    /// Attribute that identify the service `host`.
    let host: String

    /// Attribute that defines request query strings
    let queryStrings: [String: String]?

    var queryItem: [URLQueryItem] {
        queryStrings?.map({ URLQueryItem(name: $0.key, value: $0.value) }) ?? []
    }
}

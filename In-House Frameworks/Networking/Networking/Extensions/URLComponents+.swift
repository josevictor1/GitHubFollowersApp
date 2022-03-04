//
//  URLComponents+.swift
//  Networking
//
//  Created by José Victor Pereira Costa on 06/04/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import Foundation

extension URLComponents {

    init(endpoint: Endpoint) {
        self.init()
        scheme = endpoint.scheme.rawValue
        host = endpoint.host
        path = endpoint.path
        queryItems = endpoint.queryItem
    }
}

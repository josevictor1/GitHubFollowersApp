//
//  URLComponents+.swift
//  Networking
//
//  Created by José Victor Pereira Costa on 05/04/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import Foundation

extension URLComponents {
    
    /// Create a URL  with the passed request.
    /// - Parameter request: The request conaining `baseURL` and `path`.
    init?(request: Request) {
        self.init()
        
        queryItems = request.queryString?.map({ .init(name: $0.key, value: ($0.value as! String)) })
        
    }
    
}

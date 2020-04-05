//
//  RequestBuilder.swift
//  Networking
//
//  Created by José Victor Pereira Costa on 04/04/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import Foundation

class RequestBuilder {
    
    let encoder: JSONEncoder
    
    init(encoder: JSONEncoder = JSONEncoder()) {
        self.encoder = encoder
    }
    
    func buildURL(from request: Request) throws -> URL {
        guard var url = URL(string: request.baseURL) else {
            throw NetworkingError.invalidURL
        }
        url.appendPathComponent(request.path)
        return url
    }
    

}

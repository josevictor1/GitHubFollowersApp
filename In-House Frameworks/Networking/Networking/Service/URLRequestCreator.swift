//
//  RequestBuilder.swift
//  Networking
//
//  Created by José Victor Pereira Costa on 04/04/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import Foundation

class URLRequestCreator {
    
    let encoder: JSONEncoder
    
    init(encoder: JSONEncoder = JSONEncoder()) {
        self.encoder = encoder
    }
    
    
    func endpoint(from request: Request) -> Endpoint {
        Endpoint(path: request.path,
                 scheme: request.scheme,
                 host: request.host,
                 queryStrings: request.queryString)
    }
    
    func createURLRequest(from request: Request) throws -> URLRequest {
        let components = URLComponents(endpoint: endpoint(from: request))
        guard let url = components.url else { throw NetworkingError.invalidURL }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpBody = request.body?.encode()
        urlRequest.allHTTPHeaderFields = request.header
        return urlRequest
    }
    
    

}

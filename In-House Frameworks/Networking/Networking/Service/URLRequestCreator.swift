//
//  RequestBuilder.swift
//  Networking
//
//  Created by José Victor Pereira Costa on 04/04/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import Foundation

protocol URLRequestProvider {
    func createURLRequest(from request: Request) throws -> URLRequest
}

class URLRequestCreator: URLRequestProvider {
    
    private let encoder: JSONEncoder
    
    init(encoder: JSONEncoder = JSONEncoder()) {
        self.encoder = encoder
    }
    
    func encode(_ encodable: Encodable?) throws -> Data? {
        guard let encodable = encodable else { return nil }
        do {
            let encodable = AnyEncodable(encodable)
            return try encoder.encode(encodable)
        } catch {
            throw NetworkingError.encoding(error)
        }
    }
    
    func createURLRequest(from request: Request) throws -> URLRequest {
        
        let endpoint = Endpoint(path: request.path,
                                scheme: request.scheme,
                                host: request.host,
                                queryStrings: request.queryString)
        
        let components = URLComponents(endpoint: endpoint)
        
        guard let url = components.url else { throw NetworkingError.invalidURL }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpBody = try encode(request.body)
        urlRequest.allHTTPHeaderFields = request.header
        
        return urlRequest
    }

}

//
//  File.swift
//  Networking
//
//  Created by José Victor Pereira Costa on 31/03/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import Foundation

/// Closure to be executed when a request has completed.
public typealias ResponseCompletion = (_ result: Result<NetworkingResponse, NetworkingError>) -> Void

/// Networking interface that provides.
public class NetworkingProvider {
    
    private let service: NetworkingServiceProtocol = NetworkingService()
    
    /// Creates an object of the type `NetworkigProvider`.
    public init() { }
    
    /// Performs a networking request executing a completion call back at the end of this.
    /// - Parameters:
    ///   - request: The request data.
    ///   - completion: The call back completion .
    public func performRequest(_ request: Request, completion: @escaping ResponseCompletion) {
        service.send(request, completion: completion)
    }
    
    /// Performs a networking request executing a copletion call back at the end of this.
    /// The copletion has a generic `Decodable` parameter.
    /// - Parameters:
    ///   - request: The request data.
    ///   - completion: The call back completion with a `Decodable` parameter.
    public func performRequestWithDecodable<D: Decodable>(_ request: Request, completion: @escaping (Result<D, NetworkingError>) -> Void) {
        
        service.send(request) { result in
            switch result {
            case .success(let response):
                do {
                    let result = try response.map(D.self)
                    completion(.success(result))
                } catch {
                    completion(.failure(.decoding(error)))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}

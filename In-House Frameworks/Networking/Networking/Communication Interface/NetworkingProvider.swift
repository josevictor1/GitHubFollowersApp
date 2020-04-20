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

public class NetworkingProvider {
    
    private let service: NetworkingServiceProtocol = NetworkingService()
    
    public init() { }
    
    public func perform(_ request: Request, completion: @escaping ResponseCompletion) {
        service.send(request, completion: completion)
    }
    
}

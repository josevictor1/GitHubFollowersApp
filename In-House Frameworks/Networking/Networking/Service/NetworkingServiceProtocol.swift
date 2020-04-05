//
//  NetworkingServiceProtocol.swift
//  Networking
//
//  Created by José Victor Pereira Costa on 02/04/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import Foundation

protocol NetworkingServiceProtocol {
    func send(_ request: Request, completion: @escaping ResponseCompletion)
}

class NetworkingService: NetworkingServiceProtocol {
    
    let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func send(_ request: Request, completion: @escaping ResponseCompletion) {
        

    }
    
    
}

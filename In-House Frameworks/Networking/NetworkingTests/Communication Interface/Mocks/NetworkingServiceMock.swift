//
//  NetworkProvider.swift
//  NetworkingTests
//
//  Created by José Victor Pereira Costa on 03/04/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import Foundation
@testable import Networking

class NetworkingServiceMock: NetworkingServiceProtocol {
    
    func send(_ request: Request, completion: @escaping ResponseCompletion) {
        
    }
}

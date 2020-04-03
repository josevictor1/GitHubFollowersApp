//
//  RequestMock.swift
//  NetworkingTests
//
//  Created by José Victor Pereira Costa on 02/04/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import Foundation
@testable import Networking

class RequestMock: Request {
    
    var method: HTTPMethod {
        .get
    }
    
    var endpoint: Endpoint {
        Endpoint(path: "/test",
                 scheme: "http",
                 host: "test.com")
    }
    
    var body: Encodable?
    
    var header: Header {
        Header()
    }
    
}

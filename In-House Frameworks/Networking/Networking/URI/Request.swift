//
//  Request.swift
//  Networking
//
//  Created by José Victor Pereira Costa on 02/04/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import Foundation

public typealias Header = [String: String]

/// A type that conatins all necessary information for an HTTP request.
public protocol Request {
    
    /// Attribute that defines the request http method.
    var method: HTTPMethod { get }
    
    /// Attribute that define the request endpoint address.
    var endpoint: Endpoint { get }
    
    /// Attribute containg the request data to be sent.
    var body: Encodable? { get set }
    
    /// Attribute that define the necessary headers.
    var header: Header { get }
    
}

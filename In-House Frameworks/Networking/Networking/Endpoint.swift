//
//  Endpoint.swift
//  Networking
//
//  Created by José Victor Pereira Costa on 01/04/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import Foundation

public typealias Header = [String: String]

public protocol Endpoint {
    
    var header: Header? { get set }
    
    var method: HTTPMethod { get set }
    
    var path: String { get set }
    
    var scheme: String { get set }
    
    var host: String { get set }
    
}

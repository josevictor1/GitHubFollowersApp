//
//  HTTPMethod.swift
//  Networking
//
//  Created by José Victor Pereira Costa on 01/04/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import Foundation

/// Request method to indicate the desired action to be perform fo a give resource.
public enum HTTPMethod {
    case get
    case post
    case put
    case patch
    case delete
    case head
    case options
    case trace
}

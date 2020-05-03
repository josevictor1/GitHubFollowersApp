//
//  NetworkingError.swift
//  Networking
//
//  Created by José Victor Pereira Costa on 02/04/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import Foundation

public enum NetworkingError: Error {
    case invalidURL
    case unknown
    case parsing
    case encoding(Error)
    case decoding(Error)
    case redirection(Error, NetworkingResponse?)
    case server(Error, NetworkingResponse?)
    case client(Error, NetworkingResponse?)
}

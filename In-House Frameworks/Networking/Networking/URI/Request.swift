//
//  Request.swift
//  Networking
//
//  Created by José Victor Pereira Costa on 02/04/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import Foundation

public typealias Header = [String: String]
public typealias QueryString = [String: String]

/// A type that conatins all necessary information for an HTTP request.
public protocol Request {

    /// The attribute that defines the request http method.
    var method: HTTPMethod { get }

    var scheme: URIScheme { get }

    var host: String { get }

    /// The attribute that defines the URL path.
    var path: String { get }

    /// The attribute containg the request data to be sent.
    var body: Encodable? { get set }

    /// The attribute that defines the request.
    var queryString: QueryString? { get }

    /// The attribute that define the necessary headers.
    var header: Header? { get }
}

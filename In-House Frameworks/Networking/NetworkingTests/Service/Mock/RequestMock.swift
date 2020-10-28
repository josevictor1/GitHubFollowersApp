//
//  RequestMock.swift
//  NetworkingTests
//
//  Created by José Victor Pereira Costa on 02/04/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import Foundation
@testable import Networking

struct RequestMock: Request {

    var urlPath = "/users/josevictor1/followers"

    var urlHost = "https://api.github.com"

    var method: HTTPMethod { .get }

    var scheme: URIScheme { .http }

    var path: String { urlPath }

    var host: String { urlHost }

    var body: Encodable?

    var queryString: QueryString?

    var header: Header?

}

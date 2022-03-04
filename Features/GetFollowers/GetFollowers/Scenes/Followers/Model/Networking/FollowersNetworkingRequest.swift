//
//  FollowersNetworkingRequest.swift
//  GetFollowers
//
//  Created by José Victor Pereira Costa on 02/11/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import Networking

struct FollowersNetworkingRequest: Request {
    let username: String
    let pageNumber: Int
    let resultsPerPage: Int

    var method: HTTPMethod { .get }

    var scheme: URIScheme { .https }

    var host: String { "api.github.com" }

    var path: String { "/users/\(username)/followers"}

    var body: Encodable?

    var queryString: QueryString? {
        [
            "page": "\(pageNumber)",
            "per_page": "\(resultsPerPage)"
        ]
    }

    var header: Header?

    init(username: String,
         pageNumber: Int,
         resultsPerPage: Int) {
        self.username = username
        self.pageNumber = pageNumber
        self.resultsPerPage = resultsPerPage
    }
}

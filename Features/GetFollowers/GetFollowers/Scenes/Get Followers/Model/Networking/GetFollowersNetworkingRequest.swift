//
//  GetFollowersNetworkingRequest.swift
//  GetFollowers
//
//  Created by José Victor Pereira Costa on 19/04/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import Foundation
import Networking

struct GetFollowersNetworkingRequest: Request {

    let followerRequest: FollowersRequest

    var method: HTTPMethod { .get }

    var scheme: URIScheme { .https }

    var host: String { "api.github.com" }

    var path: String { "/users/\(followerRequest.login)/followers" }

    var body: Encodable?

    var queryString: QueryString?

    var header: Header?

    init(followerRequest: FollowersRequest) {
        self.followerRequest = followerRequest
    }
}

//
//  FollowersNetworkingRequest.swift
//  GetFollowers
//
//  Created by José Victor Pereira Costa on 02/11/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import Foundation
import Networking

struct FollowersNetworkingRequest: Request {
    
    let username: String
    
    var method: HTTPMethod { .get }
    
    var scheme: URIScheme { .https }
    
    var host: String { "api.github.com" }
    
    var path: String { "/user/following/\(username)"}
    
    var body: Encodable?
    
    var queryString: QueryString?
    
    var header: Header?
    
    init(username: String) {
        self.username = username
    }
}

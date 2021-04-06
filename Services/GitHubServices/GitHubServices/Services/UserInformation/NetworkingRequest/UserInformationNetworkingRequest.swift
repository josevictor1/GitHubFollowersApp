//
//  GetUserNetworkingRequest.swift
//  GetFollowers
//
//  Created by José Victor Pereira Costa on 10/11/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import Networking

struct UserInformationNetworkingRequest: Request {
    
    let username: String
    
    var method: HTTPMethod { .get }
    
    var scheme: URIScheme { .https }
    
    var host: String { "api.github.com" }
    
    var path: String { "/users/\(username)" }
    
    var body: Encodable?
    
    var queryString: QueryString?
    
    var header: Header?
}

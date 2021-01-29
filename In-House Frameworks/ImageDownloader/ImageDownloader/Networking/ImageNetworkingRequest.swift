//
//  ImageNetworkingRequest.swift
//  ImageDownloader
//
//  Created by José Victor Pereira Costa on 27/01/21.
//

import Networking

struct ImageNetworkingRequest: Request {
    var method: HTTPMethod { .get }
    
    var scheme: URIScheme
    
    var host: String
    
    var path: String
    
    var body: Encodable?
    
    var queryString: QueryString?
    
    var header: Header?
}

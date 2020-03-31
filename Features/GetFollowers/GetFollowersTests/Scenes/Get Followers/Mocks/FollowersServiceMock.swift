//
//  FollowersServiceMock.swift
//  GetFollowersTests
//
//  Created by José Victor Pereira Costa on 31/03/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import Foundation
@testable import GetFollowers

class FollowersServiceMock: FollowersProvider {
    
    var followers: [FollowerAPIResponse]?
    var error: NSError?
    
    func requestFollowers(_ request: FollowersAPIRequest, completion: @escaping ((Result<[FollowerAPIResponse], NSError>) -> Void)) {
        if let followers = followers {
            completion(.success(followers))
        } else if let error = error {
            completion(.failure(error))
        }
    }
}

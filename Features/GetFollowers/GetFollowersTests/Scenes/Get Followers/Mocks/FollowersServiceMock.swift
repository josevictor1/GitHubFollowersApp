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
    
    var followers: [FollowerResponse]?
    var error: NSError?
    
    func requestFollowers(_ request: FollowersRequest, completion: @escaping ((Result<[FollowerResponse], NSError>) -> Void)) {
        if let followers = followers {
            completion(.success(followers))
        } else if let error = error {
            completion(.failure(error))
        }
    }
}

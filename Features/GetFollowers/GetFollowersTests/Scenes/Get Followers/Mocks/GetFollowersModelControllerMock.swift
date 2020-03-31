//
//  File.swift
//  GetFollowersTests
//
//  Created by José Victor Pereira Costa on 30/03/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import Foundation
@testable import GetFollowers

class GetFollowersModelControllerMock: GetFollowersModel {
    
    var error: GetFollowersError = .requestFail
    var followers: [Follower]?
    
    func getFollowers(of username: String, completion: @escaping ((Result<[Follower], GetFollowersError>) -> Void)) {
        guard let followers = followers else { return completion(.failure(error)) }
        completion(.success(followers))
    }
    
}

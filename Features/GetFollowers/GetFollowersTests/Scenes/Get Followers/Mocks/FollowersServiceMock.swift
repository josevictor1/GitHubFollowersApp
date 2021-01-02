//
//  FollowersServiceMock.swift
//  GetFollowersTests
//
//  Created by José Victor Pereira Costa on 31/03/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import Foundation
@testable import GetFollowers

final class FollowersServiceMock: GetFollowersProvider {

    var followers: [UserResponse]?
    var error: GetFollowersError?

    func requestUserInformation(for username: String, completion: @escaping FollowersServiceCompletion) {
        if let followers = followers {
            completion(.success(followers))
        } else if let error = error {
            completion(.failure(error))
        }
    }
}

//
//  GetFollowersModelController.swift
//  GitHub
//
//  Created by José Victor Pereira Costa on 24/03/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import Foundation

protocol GetFollowersModel {
    func getFollowers(with username: String, completion: @escaping ((Result<[Follower], GetFollowersError>) -> Void))
}

class GetFollowersModelController: GetFollowersModel {
    
    func getFollowers(with username: String, completion: @escaping ((Result<[Follower], GetFollowersError>) -> Void)) {
        
    }

}

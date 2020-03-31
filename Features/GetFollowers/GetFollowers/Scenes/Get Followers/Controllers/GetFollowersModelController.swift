//
//  GetFollowersModelController.swift
//  GitHub
//
//  Created by José Victor Pereira Costa on 24/03/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import Foundation

typealias GetFollowersResponseCompletion = ((Result<[Follower], GetFollowersError>) -> Void)

protocol GetFollowersModel {
    func getFollowers(of user: String, completion: @escaping GetFollowersResponseCompletion)
}

class GetFollowersModelController: GetFollowersModel {
    
    let provider: FollowersProvider
    
    init(provider: FollowersProvider){
        self.provider = provider
    }
    
    func getFollowers(of user: String, completion: @escaping GetFollowersResponseCompletion) {
        
        let request = FollowersAPIRequest(login: user)
        
        provider.requestFollowers(request) { [unowned self] result in
            switch result {
            case .success(let response):
                self.handleSuccess(with: response, completion)
            case .failure(let error):
                self.handleFailure(with: error, completion)
            }
        }
    }
    
    func handleSuccess(with response: [FollowerAPIResponse], _ completion: GetFollowersResponseCompletion) {
        completion(.success(response.map(Follower.init)))
    }
    
    func handleFailure(with error: NSError, _ completion: GetFollowersResponseCompletion) {
        completion(.failure(GetFollowersError(error)))
    }

}

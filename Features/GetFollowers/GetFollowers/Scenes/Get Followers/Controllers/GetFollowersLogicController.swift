//
//  GetFollowersModelController.swift
//  GitHub
//
//  Created by José Victor Pereira Costa on 24/03/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import Foundation

protocol GetFollowersLogicControllerProtocol {
    func fetchUserInformation(for user: String, completion: @escaping GetFollowersResponseCompletion)
}

final class GetFollowersLogicController: GetFollowersLogicControllerProtocol {
    
    private let provider: GetFollowersServiceProvider
    
    init(provider: GetFollowersServiceProvider = GetFollowersProvider()) {
        self.provider = provider
    }
    
    func fetchUserInformation(for user: String, completion: @escaping GetFollowersResponseCompletion) {
        provider.fetchUserInformation(for: user) { result in
            DispatchQueue.main.async { completion(result) }
        }
    }
}

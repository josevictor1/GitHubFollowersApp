//
//  UserInformationService.swift
//  GetFollowers
//
//  Created by José Victor Pereira Costa on 22/03/21.
//  Copyright © 2021 José Victor Pereira Costa. All rights reserved.
//

import Commons
import GitHubServices
import Networking

typealias GetFollowersResponseCompletion = (Result<SelectedUserInformation, GetFollowersError>) -> Void

protocol GetFollowersServiceProvider {
    func fetchUserInformation(for user: String, completion: @escaping GetFollowersResponseCompletion)
}

final class GetFollowersProvider: GetFollowersServiceProvider {
    
    private let userInformationService: UserInformationService
    
    init(userInformationService: UserInformationService = UserInformationNetworkingService()) {
        self.userInformationService = userInformationService
    }
    
    func fetchUserInformation(for user: String, completion: @escaping GetFollowersResponseCompletion) {
        userInformationService.requestUserInformation(for: user) { [weak self] result in
            switch result {
            case .success(let response):
                self?.handleSuccess(with: response, completion: completion)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func handleSuccess(with response: UserInformationNetworkingResponse,
                               completion: GetFollowersResponseCompletion) {
        guard let userInformation = SelectedUserInformation(userNetworkingResponse: response) else {
            return completion(.failure(.invalidUsername))
        }
        completion(.success(userInformation))
    }
}

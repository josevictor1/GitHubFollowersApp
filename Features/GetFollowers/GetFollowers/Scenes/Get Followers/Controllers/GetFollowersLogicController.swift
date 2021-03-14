//
//  GetFollowersModelController.swift
//  GitHub
//
//  Created by José Victor Pereira Costa on 24/03/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import Foundation

typealias GetFollowersResponseCompletion = ((Result<UserInformation, GetFollowersError>) -> Void)

protocol GetFollowersLogicControllerProtocol {
    func fetchUserInformation(for user: String, completion: @escaping GetFollowersResponseCompletion)
}

final class GetFollowersLogicController: GetFollowersLogicControllerProtocol {
    private let provider: GetFollowersProvider

    init(provider: GetFollowersProvider = GetFollowersService()) {
        self.provider = provider
    }

    func fetchUserInformation(for user: String, completion: @escaping GetFollowersResponseCompletion) {
        provider.requestUserInformation(for: user) { [weak self] result in
            switch result {
            case .success(let response):
                self?.handleSuccess(with: response, completion: completion)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    private func handleSuccess(with response: UserNetworkingResponse, completion: GetFollowersResponseCompletion) {
        guard let userInformation = UserInformation(userNetworkingResponse: response) else {
            return completion(.failure(.invalidUsername))
        }
        completion(.success(userInformation))
    }
}

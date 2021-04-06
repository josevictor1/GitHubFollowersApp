//
//  UserInformationProvider.swift
//  UserInformation
//
//  Created by José Victor Pereira Costa on 31/03/21.
//  Copyright © 2021 José Victor Pereira Costa. All rights reserved.
//

import GitHubServices
import Commons

typealias UserInformationCompletion = (Result<UserInformationResponse, GetFollowersError>) -> Void

protocol UserInformationProviderProtocol {
    func fetchUserInformation(for login: String, completion: @escaping UserInformationCompletion)
}

final class UserInformationProvider: UserInformationProviderProtocol {
    
    private let service: UserInformationService
    
    init(service: UserInformationService = UserInformationNetworkingService()) {
        self.service = service
    }
    
    func fetchUserInformation(for login: String, completion: @escaping UserInformationCompletion) {
        service.requestUserInformation(for: login) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self?.handleSuccess(with: response, completion: completion)
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    private func handleSuccess(with response: UserInformationNetworkingResponse,
                               completion: UserInformationCompletion) {
        let response = UserInformationResponse(networkingResponse: response)
        completion(.success(response))
    }
}

//
//  UserInformationService.swift
//  UserInformation
//
//  Created by José Victor Pereira Costa on 17/03/21.
//

import Commons
import Networking

public typealias UserInformationServiceCompletion = (Result<UserInformationNetworkingResponse, GetFollowersError>) -> Void
public typealias UserInformationNetworkingResult = Result<UserInformationNetworkingResponse, NetworkingError>

public protocol UserInformationService {
    func requestUserInformation(for username: String, completion: @escaping UserInformationServiceCompletion)
}

public final class UserInformationNetworkingService: UserInformationService {
    
    private let networkingProvider: NetworkingProvider
    
    public init(networkingProvider: NetworkingProvider = NetworkingProvider()) {
        self.networkingProvider = networkingProvider
    }
    
    public func requestUserInformation(for username: String, completion: @escaping UserInformationServiceCompletion) {
        let networkingRequest = UserInformationNetworkingRequest(username: username)
        networkingProvider.performRequestWithDecodable(networkingRequest) { (result: UserInformationNetworkingResult) in
            completion(result.mapError(GetFollowersError.init))
        }
    }
}

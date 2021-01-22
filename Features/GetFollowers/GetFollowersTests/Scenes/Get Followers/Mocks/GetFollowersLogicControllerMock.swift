//
//  File.swift
//  GetFollowersTests
//
//  Created by José Victor Pereira Costa on 30/03/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import Foundation
import Commons
@testable import GetFollowers

final class GetFollowersLogicControllerMock: GetFollowersLogicControllerProtocol {
    var error: GetFollowersError?
    private let fileReader: FileReader = {
        let bundle = Bundle(for: GetFollowersLogicControllerMock.self)
        let fileReader = FileReader(bundle: bundle)
        return fileReader
    }()

    func fetchFollowers(for user: String, completion: @escaping GetFollowersResponseCompletion) {
        if let error = error {
            completion(.failure(error))
        } else {
            loadUserInformation(completion: completion)
        }
    }
    
    private func loadUserInformation(completion: @escaping GetFollowersResponseCompletion) {
        do {
            guard let userInformation = try readLoadInformationFromJSON() else {
                return completion(.failure(.invalidResponse))
            }
            completion(.success(userInformation))
        } catch {
            completion(.failure(.invalidResponse))
        }
    }
    
    private func readLoadInformationFromJSON() throws -> UserInformation? {
        let userInformationResponse = try loadUserInformationFromJSON()
        return UserInformation(userNetworkingResponse: userInformationResponse)
    }
    
    private func loadUserInformationFromJSON() throws -> UserNetworkingResponse {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let fileData = try fileReader.readDataForFile(withName: "UserInformation", type: .JSON)
        return try decoder.decode(UserNetworkingResponse.self, from: fileData)
    }
}

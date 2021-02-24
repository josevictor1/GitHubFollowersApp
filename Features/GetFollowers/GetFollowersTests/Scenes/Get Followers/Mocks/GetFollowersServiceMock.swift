//
//  FollowersServiceMock.swift
//  GetFollowersTests
//
//  Created by José Victor Pereira Costa on 31/03/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import Commons
@testable import GetFollowers

final class GetFollowersServiceMock: GetFollowersProvider {
    var error: GetFollowersError?
    private let fileReader: FileReader = {
        let bundle = Bundle(for: GetFollowersServiceMock.self)
        let fileReader = FileReader(bundle: bundle)
        return fileReader
    }()

    func requestUserInformation(for username: String, completion: @escaping FollowersServiceCompletion) {
        if let error = error {
            completion(.failure(error))
        } else {
            loadUserInformation(completion: completion)
        }
    }

    private func loadUserInformation(completion: @escaping FollowersServiceCompletion) {
        do {
            let userInformation = try loadUserInformationFromJSON()
            completion(.success(userInformation))
        } catch {
            completion(.failure(.invalidResponse))
        }
    }

    private func loadUserInformationFromJSON() throws -> UserNetworkingResponse {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let fileData = try fileReader.readDataForFile(withName: "UserInformation", type: .JSON)
        return try decoder.decode(UserNetworkingResponse.self, from: fileData)
    }
}

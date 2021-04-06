//
//  FollowersServiceMock.swift
//  GetFollowersTests
//
//  Created by José Victor Pereira Costa on 31/03/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import Commons
import GitHubServices
import Networking

@testable import GetFollowers

final class UserInformationServiceMock: UserInformationService {
    var error: NetworkingError?
    private let fileReader: FileReader = {
        let bundle = Bundle(for: UserInformationServiceMock.self)
        let fileReader = FileReader(bundle: bundle)
        return fileReader
    }()

    func requestUserInformation(for username: String, completion: @escaping UserInformationServiceCompletion) {
        if let error = error {
            completion(.failure(error))
        } else {
            loadUserInformation(completion: completion)
        }
    }

    private func loadUserInformation(completion: @escaping UserInformationServiceCompletion) {
        do {
            let userInformation = try loadUserInformationFromJSON()
            completion(.success(userInformation))
        } catch {
            let error = NSError()
            completion(.failure(.client(error, nil)))
        }
    }

    private func loadUserInformationFromJSON() throws -> UserInformationNetworkingResponse {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let fileData = try fileReader.readDataForFile(withName: "UserInformation", type: .JSON)
        return try decoder.decode(UserInformationNetworkingResponse.self, from: fileData)
    }
}

//
//  FollowersProviderMock.swift
//  GetFollowersTests
//
//  Created by José Victor Pereira Costa on 21/02/21.
//  Copyright © 2021 José Victor Pereira Costa. All rights reserved.
//

import Commons
@testable import GetFollowers

final class FollowersServiceMock: FollowersProvider {
    var error: GetFollowersError?
    var shouldReturnEmpty = false
    
    func resetTestVariables() {
        error = nil
        shouldReturnEmpty = false
    }
    
    private let fileReader: FileReader = {
        let bundle = Bundle(for: FollowersServiceMock.self)
        let fileReader = FileReader(bundle: bundle)
        return fileReader
    }()
    
    func fetchFollowes(for request: FollowersRequest, completion: @escaping FetchFollowersRequestCompletion) {
        if let error = error {
            completion(.failure(error))
        } else if shouldReturnEmpty {
            completion(.success([]))
        } else {
            loadFollowers(completion: completion)
        }
    }
    
    private func loadFollowers(completion: @escaping FetchFollowersRequestCompletion) {
        do {
            let userInformation = try loadFollowersFromJSON()
            completion(.success(userInformation))
        } catch {
            completion(.failure(.invalidResponse))
        }
    }
    
    private func loadFollowersFromJSON() throws -> [FollowerResponse] {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let fileData = try fileReader.readDataForFile(withName: "Followers", type: .JSON)
        return try decoder.decode([FollowerResponse].self, from: fileData)
    }
}

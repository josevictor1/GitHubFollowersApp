//
//  NetworkingResponse.swift
//  Networking
//
//  Created by José Victor Pereira Costa on 02/04/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import Foundation

public struct NetworkingResponse: Equatable {

    /// The status code of the response.
    public let statusCode: Int

    /// The response data.
    public let data: Data

    /// The original URLRequest for the response.
    public let request: URLRequest?

    /// The HTTPURLResponse object.
    public let response: HTTPURLResponse?

    public init(data: Data, request: URLRequest? = nil, response: HTTPURLResponse) {
        self.statusCode = response.statusCode
        self.data = data
        self.request = request
        self.response = response
    }

    /// A text description of the `Response`.
    public var description: String {
        return "Status Code: \(statusCode), Data Length: \(data.count)"
    }
}

extension NetworkingResponse {

    func map<D: Decodable>(_ type: D.Type, decoder: JSONDecoder = JSONDecoder()) throws -> D {
        do {
            return try decoder.decode(D.self, from: data)
        } catch {
            return try decodeAsISO8601(D.self, data: data, decoder: decoder)
        }
    }

    private func decodeAsISO8601<D: Decodable>(_ type: D.Type, data: Data, decoder: JSONDecoder) throws -> D {
        decoder.dateDecodingStrategy = .iso8601
        return try decoder.decode(D.self, from: data)
    }
}

//
//  NetworkingServiceProtocol.swift
//  Networking
//
//  Created by José Victor Pereira Costa on 02/04/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import Foundation

protocol NetworkingServiceProtocol {
    func send(_ request: Request, completion: @escaping ResponseCompletion) -> URLSessionDataTask?
    func sendRequest(with url: String, completion: @escaping ResponseCompletion) -> URLSessionDataTask?
}

final class NetworkingService: NetworkingServiceProtocol {
    private let session: URLSession
    private let requestProvider: URLRequestProvider

    init(requestProvider: URLRequestProvider = URLRequestCreator(), session: URLSession = .shared) {
        self.session = session
        self.requestProvider = requestProvider
    }

    func sendRequest(with url: String, completion: @escaping ResponseCompletion) -> URLSessionDataTask? {
        var dataTask: URLSessionDataTask?
        do {
            let request = try requestProvider.createURLRequest(fromString: url)
            dataTask = executeTask(for: request, completion: completion)
        } catch {
            handleNetworkingError(error, completion: completion)
        }
        return dataTask
    }

    func send(_ request: Request, completion: @escaping ResponseCompletion) -> URLSessionDataTask? {
        var dataTask: URLSessionDataTask?
        do {
            let request = try requestProvider.createURLRequest(from: request)
            dataTask = executeTask(for: request, completion: completion)
        } catch {
            handleNetworkingError(error, completion: completion)
        }
        return dataTask
    }

    private func executeTask(for request: URLRequest, completion: @escaping ResponseCompletion) -> URLSessionDataTask {
        let dataTask = session.dataTask(with: request) { [weak self] data, response, error in
            guard let self = self else { return completion(.failure(.unknown)) }
            let httpResponse = response as? HTTPURLResponse
            let result = self.convertResponseToResult(data, request, httpResponse, error)
            completion(result)
        }
        dataTask.resume()
        return dataTask
    }

    private func handleNetworkingError(_ error: Error, completion: @escaping ResponseCompletion) {
        guard let networkingError = error as? NetworkingError else {
            return completion(.failure(.unknown))
        }
        completion(.failure(networkingError))
    }

    private func convertResponseToResult(_ data: Data?,
                                         _ request: URLRequest,
                                         _ response: HTTPURLResponse?,
                                         _ error: Error?) -> Result<NetworkingResponse, NetworkingError> {
        switch (response, data, error) {
        case let (.some(response), data, .none):
            let response = NetworkingResponse(data: data ?? Data(), request: request, response: response)
            return .success(response)
        case let (.some(response), _, .some(error)):
            let response = NetworkingResponse(data: data ?? Data(), request: request, response: response)
            let error = convertErrorToNetworkingError(error, with: response)
            return .failure(error)
        default:
            return .failure(.unknown)
        }
    }

    private func convertErrorToNetworkingError(_ error: Error, with response: NetworkingResponse) -> NetworkingError {
        switch response.statusCode {
        case (300...399):
            return .redirection(error, response)
        case (400...499):
            return .client(error, response)
        case (500...599):
            return .server(error, response)
        default:
            return .unknown
        }
    }
}

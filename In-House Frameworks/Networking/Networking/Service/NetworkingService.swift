//
//  NetworkingServiceProtocol.swift
//  Networking
//
//  Created by José Victor Pereira Costa on 02/04/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import Foundation

protocol NetworkingServiceProtocol {
    func send(_ request: Request, completion: @escaping ResponseCompletion)
}

class NetworkingService: NetworkingServiceProtocol {
    
    let session: URLSession
    let requestProvider: URLRequestProvider
    
    init(requestProvider: URLRequestProvider = URLRequestCreator(), session: URLSession = .shared) {
        self.session = session
        self.requestProvider = requestProvider
    }
    
    func send(_ request: Request, completion: @escaping ResponseCompletion) {
        do {
            let request = try requestProvider.createURLRequest(from: request)
            
            session.dataTask(with: request) { [weak self] data, response, error in
                guard let self = self else { return completion(.failure(.unknown)) }
                let httpResponse = response as? HTTPURLResponse
                let result = self.convertResponseToResult(data, request, httpResponse, error)
                completion(result)
            }.resume()
        } catch {
            
            guard let networkingError = error as? NetworkingError else {
                return completion(.failure(.unknown))
            }
            completion(.failure(networkingError))
        }
    }
    
    func convertResponseToResult(_ data: Data?, _ request: URLRequest, _ response: HTTPURLResponse?, _ error: Error?) -> Result<NetworkingResponse, NetworkingError> {
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
    
    func convertErrorToNetworkingError(_ error: Error, with response: NetworkingResponse) -> NetworkingError {
        
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

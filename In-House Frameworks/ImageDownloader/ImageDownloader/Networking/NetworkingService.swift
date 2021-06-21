//
//  NetworkingService.swift
//  ImageDownloader
//
//  Created by José Victor Pereira Costa on 27/01/21.
//

import UIKit
import Networking

typealias DownloadImageCompletion = (Result<Data, Error>) -> Void

protocol NetworkingServiceProtocol {
    func downloadImage(fromURL url: String, completion: @escaping DownloadImageCompletion) -> URLSessionDataTask?
}

final class NetworkingService: NetworkingServiceProtocol {
    
    private let networkingProvider = NetworkingProvider()

    func downloadImage(fromURL url: String, completion: @escaping DownloadImageCompletion) -> URLSessionDataTask? {
        return networkingProvider.requestData(fromURL: url) { result in
            switch result {
            case .success(let response):
                completion(.success(response.data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

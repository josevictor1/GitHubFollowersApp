//
//  ImageDownloader.swift
//  ImageDownloader
//
//  Created by José Victor Pereira Costa on 27/01/21.
//

import UIKit
import Networking
import Core

public typealias RequestImageCompletion = (Result<UIImage, Error>) -> Void

public final class ImageDownloader {
    private let networkingService: NetworkingServiceProtocol
    private let cache = Cache<String, UIImage>()

    init(networkingService: NetworkingServiceProtocol = NetworkingService()) {
        self.networkingService = networkingService
    }

    @discardableResult
    func loadImage(fromURL url: String, completion: @escaping RequestImageCompletion) -> URLSessionDataTask? {
        if let image = loadCachedImage(forURL: url) {
            completion(.success(image))
        } else {
            return downloadImage(fromURL: url, completion: completion)
        }
        return nil
    }

    private func loadCachedImage(forURL url: String) -> UIImage? {
        cache.data(forKey: url)
    }

    private func downloadImage(fromURL url: String,
                               completion: @escaping RequestImageCompletion) -> URLSessionDataTask? {
        return networkingService.downloadImage(fromURL: url) { [weak self] result in
            switch result {
            case .success(let response):
                self?.handleSuccess(forURL: url, with: response, completion: completion)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    private func handleSuccess(forURL url: String, with response: Data, completion: @escaping RequestImageCompletion) {
        guard let image = UIImage(data: response) else { return }
        cache.saveData(image, forKey: url)
        completion(.success(image))
    }
}

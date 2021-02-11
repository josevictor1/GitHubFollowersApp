//
//  NetworkingServiceTests.swift
//  ImageDownloaderTests
//
//  Created by José Victor Pereira Costa on 30/01/21.
//

import Foundation
import UIKit
@testable import ImageDownloader

final class NetworkingServiceMock: NetworkingServiceProtocol {
    var error: Error?
    
    func downloadImage(fromURL url: String, completion: @escaping DownloadImageCompletion) -> URLSessionDataTask? {
        if let error = error {
            completion(.failure(error))
        } else {
            let data = UIImage.blackImage.pngData()
            completion(.success(data ?? Data()))
        }
        
        return nil
    }
}

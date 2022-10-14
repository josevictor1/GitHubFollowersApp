//
//  ImageLoader.swift
//  ImageDownloader
//
//  Created by José Victor Pereira Costa on 10/02/21.
//

import UIKit

final class ImageLoader {
    
    private let imageDownloader: ImageDownloader
    private var imageViewMapping = [UIImageView: URLSessionDataTask]()

    init(imageDownloader: ImageDownloader = ImageDownloader()) {
        self.imageDownloader = imageDownloader
    }

    func loadImage(forURL url: String,
                   imageView: UIImageView,
                   completion: @escaping RequestImageCompletion) {
        cancelRequest(for: imageView)
        let dataTask = imageDownloader.loadImage(fromURL: url, completion: completion)
        imageViewMapping[imageView] = dataTask
    }

    func cancelRequest(for imageView: UIImageView) {
        guard let dataRequest = imageViewMapping[imageView] else { return }
        imageViewMapping[imageView] = nil
        dataRequest.cancel()
    }
}

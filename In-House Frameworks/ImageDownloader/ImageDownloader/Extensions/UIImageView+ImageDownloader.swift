//
//  UIImage+ImageDownloader.swift
//  ImageDownloader
//
//  Created by José Victor Pereira Costa on 27/01/21.
//

import UIKit

public extension UIImageView {
    
    func loadImage(forULR url: String, placeHolder: UIImage) {
        image = placeHolder
        loadImage(forURL: url)
    }
    
    private func loadImage(forURL url: String) {
        let imageDownloader = ImageDownloader()
        
        imageDownloader.requestImage(fromURL: url) { result in
            switch result {
            case .success(let image):
                self.image = image
            case .failure:
                break
            }
        }
    }
}

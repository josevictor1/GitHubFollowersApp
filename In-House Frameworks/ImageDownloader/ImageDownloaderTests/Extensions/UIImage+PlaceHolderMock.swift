//
//  UIImage+PlaceHolderMock.swift
//  ImageDownloaderTests
//
//  Created by José Victor Pereira Costa on 27/01/21.
//

import UIKit

extension UIImage {

    static var blackImage: UIImage {
        instantiateImage(withName: "Black")
    }

    static var whiteImage: UIImage {
        instantiateImage(withName: "White")
    }

    private static func instantiateImage(withName name: String) -> UIImage {
        let bundle = Bundle(for: UIImageViewExtensionTests.self)
        let placeHolderImage = UIImage(named: name,
                                       in: bundle,
                                       compatibleWith: .none)
        return placeHolderImage ?? UIImage()
    }
}

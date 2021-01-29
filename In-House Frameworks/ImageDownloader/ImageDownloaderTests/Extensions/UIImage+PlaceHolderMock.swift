//
//  UIImage+PlaceHolderMock.swift
//  ImageDownloaderTests
//
//  Created by José Victor Pereira Costa on 27/01/21.
//

import UIKit

extension UIImage {
    
    static var placeHolderMockImage: UIImage {
        let bundle = Bundle(for: UIImageViewExtensionTests.self)
        let placeHolderImage = UIImage(named: "Black",
                                       in: bundle,
                                       compatibleWith: .none)
        return placeHolderImage ?? UIImage()
    }
}

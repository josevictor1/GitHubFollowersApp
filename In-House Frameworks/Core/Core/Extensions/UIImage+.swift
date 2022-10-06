//
//  UIImage+.swift
//  Core
//
//  Created by José Victor Pereira Costa on 30/05/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import UIKit

public extension UIImage {

    convenience init?(named: String, in bundle: Bundle) {
        self.init(named: named, in: bundle, with: .none)
    }
    
    func resized(to targetSize: CGSize) -> UIImage {
        let effectiveRatio = effectiveRatio(for: targetSize)
        let newSize = CGSize(width: size.width * effectiveRatio,
                             height: size.height * effectiveRatio)
        let rect = CGRect(origin: .zero, size: newSize)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, .zero)
        draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    private func effectiveRatio(for targetSize: CGSize) -> CGFloat {
        let widthRatio = targetSize.width / size.width
        let heightRatio = targetSize.height / size.height
        return max(widthRatio, heightRatio)
    }
}

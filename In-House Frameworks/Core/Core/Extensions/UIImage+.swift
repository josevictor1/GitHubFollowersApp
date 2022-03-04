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
}

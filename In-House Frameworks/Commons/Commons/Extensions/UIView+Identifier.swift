//
//  UIView+Identifier.swift
//  Commons
//
//  Created by José Victor Pereira Costa on 27/10/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import UIKit

public extension UIView {

    static var identifier: String {
        String(describing: Self.self)
    }
}

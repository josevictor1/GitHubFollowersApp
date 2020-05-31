//
//  UIView+Bundle.swift
//  Commons
//
//  Created by José Victor Pereira Costa on 30/05/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import UIKit

public extension UIView {
    
    var bundle: Bundle {
        Bundle(for: Self.self)
    }
}

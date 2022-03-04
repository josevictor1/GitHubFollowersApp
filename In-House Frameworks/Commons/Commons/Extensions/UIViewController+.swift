//
//  UIViewController+.swift
//  Commons
//
//  Created by José Victor Pereira Costa on 10/03/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import Core
import UIKit

public extension UIViewController {

    /// Embed a view controller as a child on the view.
    /// - Parameter child: The `UIViewController` to be added.
    func install(_ child: UIViewController) {
        view.embed(child.view)
        didMove(toParent: self)
    }
}

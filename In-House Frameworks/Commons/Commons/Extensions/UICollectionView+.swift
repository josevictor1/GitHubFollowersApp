//
//  UICollectionView+.swift
//  Commons
//
//  Created by José Victor Pereira Costa on 31/10/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import UIKit

public extension UICollectionView {
    
    final func registerCell<T: UICollectionViewCell>(_ cellClass: T.Type) {
        let identifier = String(describing: cellClass.self)
        register(cellClass.self, forCellWithReuseIdentifier: identifier)
    }
}

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
        register(cellClass.self, forCellWithReuseIdentifier: cellClass.identifier)
    }
    
    final func registerSupplementaryView<T: UICollectionReusableView>(_ viewClass: T.Type, kind: String) {
        register(viewClass.self, forSupplementaryViewOfKind: kind, withReuseIdentifier: viewClass.identifier)
    }
    
    final func dequeueReusableSupplementaryView<T: UICollectionReusableView>(ofKind kind: String,
                                                                             withViewClass viewClass: T.Type,
                                                                             for indexPath: IndexPath) -> T? {
        dequeueReusableSupplementaryView(ofKind: kind,
                                         withReuseIdentifier: viewClass.identifier,
                                         for: indexPath) as? T
    }
    
    final func dequeueReusableCell<T: UICollectionViewCell>(withClass cellClass: T.Type, for indexPath: IndexPath) -> T? {
        dequeueReusableCell(withReuseIdentifier: cellClass.identifier,
                            for: indexPath) as? T
    }
}

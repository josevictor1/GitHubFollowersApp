//
//  UICollectionView+CollectionViewLayoutProvider.swift
//  UIComponents
//
//  Created by José Victor Pereira Costa on 16/02/21.
//  Copyright © 2021 José Victor Pereira Costa. All rights reserved.
//

import UIKit

public extension UICollectionViewLayout {
    
    static func defaultCollectionViewLayout() -> UICollectionViewLayout {
        let provider = CollectionViewLayoutBuilder()
        return provider
            .set(numberOfItems: 3)
            .set(interItemSpacing: 10)
            .set(interGroupSpacing: 10)
            .setItemSize(withHeight: 100, andWidth: 120)
            .setGroupSize(withHeight: 120, andFractionalWidth: 1)
            .setOrientation(.horizontal)
            .setContentInsets(top: 10,
                              leading: 10,
                              bottom: 10,
                              trailing: 10)
            .layout!
    }
}

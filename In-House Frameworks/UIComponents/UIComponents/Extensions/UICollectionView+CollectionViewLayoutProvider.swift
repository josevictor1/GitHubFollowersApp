//
//  UICollectionView+CollectionViewLayoutProvider.swift
//  UIComponents
//
//  Created by José Victor Pereira Costa on 16/02/21.
//  Copyright © 2021 José Victor Pereira Costa. All rights reserved.
//

import UIKit

public extension UICollectionViewLayout {

    static var threeColumnLayout: UICollectionViewLayout {
        let provider = CollectionViewLayoutBuilder()
        return provider
            .set(numberOfItems: 3)
            .set(interItemSpacing: 10)
            .set(interGroupSpacing: 10)
            .setItemSize(withHeight: .estimated(100),
                         andWidth: .estimated(120))
            .setGroupSize(withHeight: .estimated(120),
                          andWidth: .fractionalWidth(1))
            .setOrientation(.horizontal)
            .setContentInsets(top: 10,
                              leading: 10,
                              bottom: 10,
                              trailing: 10)
            .layout!
    }

    static var verticalLayout: UICollectionViewLayout {
        let provider = CollectionViewLayoutBuilder()
        return provider
            .set(numberOfItems: 1)
            .set(interItemSpacing: 10)
            .set(interGroupSpacing: 10)
            .setItemSize(withHeight: .fractionalHeight(1),
                         andWidth: .fractionalWidth(1))
            .setGroupSize(withHeight: .fractionalWidth(1),
                          andWidth: .fractionalWidth(1))
            .setHeaderSize(withHeight: .fractionalHeight(1),
                           andWidth: .fractionalWidth(1))
            .setFooterSize(withHeight: .fractionalHeight(1),
                           andWidth: .fractionalHeight(1))
            .setOrientation(.vertical)
            .setContentInsets(top: .zero,
                              leading: 14,
                              bottom: .zero,
                              trailing: 14)
            .layout!
    }
}

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
            .setItemSize(withWidth: .absolute(90),
                         andHeight: .estimated(90))
            .setGroupSize(withWidth: .fractionalWidth(1),
                          andHeight: .estimated(90))
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
            .setItemSize(withWidth: .fractionalWidth(1),
                         andHeight: .fractionalHeight(1))
            .setGroupSize(withWidth: .fractionalWidth(1),
                          andHeight: .estimated(161))
            .setHeaderSize(withHeight: .estimated(110),
                           andWidth: .fractionalWidth(1))
            .setFooterSize(withHeight: .estimated(17),
                           andWidth: .fractionalWidth(1))
            .setOrientation(.vertical)
            .setContentInsets(top: 14,
                              leading: 14,
                              bottom: 14,
                              trailing: 14)
            .layout!
    }
}

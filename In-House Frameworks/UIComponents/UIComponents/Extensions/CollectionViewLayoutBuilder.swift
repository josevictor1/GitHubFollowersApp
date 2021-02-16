//
//  CollectionViewLayoutProvider.swift
//  UIComponents
//
//  Created by José Victor Pereira Costa on 16/02/21.
//  Copyright © 2021 José Victor Pereira Costa. All rights reserved.
//

import UIKit

public enum LayoutGroupOrientation {
    case horizontal
    case vertical
}

final class CollectionViewLayoutBuilder {
    private var numberOfItems: Int = .zero
    private var interItemSpacing: CGFloat = .zero
    private var interGroupSpacing: CGFloat = .zero
    private var itemLayout: NSCollectionLayoutItem?
    private var contentInsets: NSDirectionalEdgeInsets = .zero
    private var groupSize: NSCollectionLayoutSize?
    private var groupLayout: NSCollectionLayoutGroup?
    
    func set(numberOfItems: Int) -> Self {
        self.numberOfItems = numberOfItems
        return self
    }
    
    func set(interItemSpacing: CGFloat) -> Self {
        self.interItemSpacing = interItemSpacing
        return self
    }
    
    func set(interGroupSpacing: CGFloat) -> Self {
        self.interGroupSpacing = interGroupSpacing
        return self
    }
    
    func setItemSize(withHeight height: CGFloat, andWidth width: CGFloat) -> Self {
        let layoutSize = NSCollectionLayoutSize(widthDimension: .estimated(height),
                                                heightDimension: .estimated(width))
        itemLayout = NSCollectionLayoutItem(layoutSize: layoutSize)
        return self
    }
    
    func setGroupSize(withHeight height: CGFloat, andFractionalWidth fractionalWidth: CGFloat) -> Self {
        groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(fractionalWidth),
                                           heightDimension: .estimated(height))
        return self
    }
    
    func setContentInsets(top: CGFloat, leading: CGFloat, bottom: CGFloat, trailing: CGFloat) -> Self {
        contentInsets = NSDirectionalEdgeInsets(top: top, leading: leading, bottom: bottom, trailing: trailing)
        return self
    }
    
    func setOrientation(_ orientation: LayoutGroupOrientation) -> Self {
        guard let itemLayout = itemLayout,
              let groupSize = groupSize else { return self }
        switch orientation {
        case .horizontal:
            groupLayout = .horizontal(layoutSize: groupSize,
                                      subitem: itemLayout,
                                      count: numberOfItems)
        case .vertical:
            groupLayout = .vertical(layoutSize: groupSize,
                                    subitem: itemLayout,
                                    count: numberOfItems)
        }
        return self
    }
    
    var layout: UICollectionViewCompositionalLayout? {
        UICollectionViewCompositionalLayout { _, _ in
            guard let group = self.groupLayout else { return nil }
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = self.interGroupSpacing
            section.contentInsets = self.contentInsets
            return section
        }
    }
}

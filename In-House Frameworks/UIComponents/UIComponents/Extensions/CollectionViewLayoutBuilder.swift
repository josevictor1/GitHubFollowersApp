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
    private var headerSize: NSCollectionLayoutSize?
    private var footerSize: NSCollectionLayoutSize?

    var layout: UICollectionViewCompositionalLayout? {
        UICollectionViewCompositionalLayout { _, _ in
            guard let group = self.groupLayout else { return nil }
            let section = NSCollectionLayoutSection(group: group)
            self.configureSupplementaryItems(on: section)
            section.interGroupSpacing = self.interGroupSpacing
            section.contentInsets = self.contentInsets
            return section
        }
    }

    private func configureSupplementaryItems(on section: NSCollectionLayoutSection) {
        guard let headerSize = self.headerSize, let footerSize = self.footerSize else { return }

        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        let sectionFooter = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: footerSize,
            elementKind: UICollectionView.elementKindSectionFooter,
            alignment: .bottom
        )
        section.boundarySupplementaryItems = [sectionHeader, sectionFooter]
    }

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

    func setItemSize(withHeight height: NSCollectionLayoutDimension,
                     andWidth width: NSCollectionLayoutDimension) -> Self {
        let layoutSize = NSCollectionLayoutSize(widthDimension: width,
                                                heightDimension: height)
        itemLayout = NSCollectionLayoutItem(layoutSize: layoutSize)
        return self
    }

    func setGroupSize(withHeight height: NSCollectionLayoutDimension,
                      andWidth width: NSCollectionLayoutDimension) -> Self {
        groupSize = NSCollectionLayoutSize(widthDimension: width,
                                           heightDimension: height)
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
        case .horizontal where numberOfItems == .zero:
            groupLayout = .horizontal(layoutSize: groupSize,
                                      subitems: [itemLayout])
        case .vertical where numberOfItems == .zero:
            groupLayout = .vertical(layoutSize: groupSize,
                                    subitems: [itemLayout])
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

    func setHeaderSize(withHeight height: NSCollectionLayoutDimension,
                       andWidth width: NSCollectionLayoutDimension) -> Self {
        headerSize = NSCollectionLayoutSize(widthDimension: width,
                                            heightDimension: height)
        return self
    }

    func setFooterSize(withHeight height: NSCollectionLayoutDimension,
                       andWidth width: NSCollectionLayoutDimension) -> Self {
        footerSize = NSCollectionLayoutSize(widthDimension: width,
                                            heightDimension: height)
        return self
    }
}

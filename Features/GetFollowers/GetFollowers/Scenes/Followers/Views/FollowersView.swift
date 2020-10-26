//
//  FolloswersView.swift
//  GetFollowers
//
//  Created by José Victor Pereira Costa on 24/05/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import UIKit

class FollowersView: UIView {
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.isTranslucent = false
        searchBar.barStyle = .black
        return searchBar
    }()
    
    private lazy var layout: UICollectionViewLayout = {
        UICollectionViewCompositionalLayout { (_, _) -> NSCollectionLayoutSection in
            let insets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
            let columns = 2
            let spacing = CGFloat(10)
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .absolute(100))
            
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .absolute(100))
            
            let group: NSCollectionLayoutGroup = .horizontal(layoutSize: groupSize,
                                                             subitem: item,
                                                             count: columns)
            group.interItemSpacing = .fixed(spacing)
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = spacing
            section.contentInsets = insets
            return section
        }
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return collectionView
    }()
    
    init(collectionViewDelegate: UICollectionViewDelegate,
         searchBarDelegate: UISearchBarDelegate) {
        super.init(frame: .zero)
        setUpConstraints()
        collectionView.delegate = collectionViewDelegate
        searchBar.delegate = searchBarDelegate
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpConstraints()
    }
    
    private func setUpConstraints() {
        setUpSearchBarConstraints()
        setUpCollectionViewConstraints()
    }
    
    private func setUpSearchBarConstraints() {
        let constraints = [
            searchBar.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor)
        ]
        place(searchBar, with: constraints)
    }
    
    private func setUpCollectionViewConstraints() {
        let constraints = [
            collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor)
        ]
        place(collectionView, with: constraints)
    }
}

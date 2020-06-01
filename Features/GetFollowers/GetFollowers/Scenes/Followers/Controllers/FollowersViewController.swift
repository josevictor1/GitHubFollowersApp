//
//  FollowersViewController.swift
//  GetFollowers
//
//  Created by José Victor Pereira Costa on 24/05/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import UIKit

class FollowersViewController: UICollectionViewController {
    
    var userFollowers: UserFollowers?
    private var searchController: UISearchController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLayout()
    }
    
    private func setUpLayout() {
        title = userFollowers?.username ?? String()
        view.backgroundColor = .systemBackground
        collectionView.backgroundColor = .systemBackground
        setupNavigationController()
    }
    
    private func setupNavigationController() {
        let searchController = UISearchController(searchResultsController: self)
        searchController.searchBar.autocapitalizationType = .none
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }
}

extension FollowersViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
}


extension FollowersViewController {
    
    static func makeFollowers(userFollowers: UserFollowers) -> FollowersViewController {
        let viewController = FollowersViewController(collectionViewLayout: UICollectionViewFlowLayout())
        viewController.userFollowers = userFollowers
        return viewController
    }
}

//
//  FollowersViewController.swift
//  GetFollowers
//
//  Created by José Victor Pereira Costa on 24/05/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import UIKit

class FollowersViewController: UICollectionViewController {
    
    // MARK: - Propeties
    
    var userFollowers: UserFollowers?
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.autocapitalizationType = .none
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        return searchController
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    // MARK: - Setup
    
    private func setUp() {
        setUpLayout()
        setUpNavigationController()
    }
    
    private func setUpLayout() {
        setUpTitle()
        setUpBackgroundColor()
        setUpCollectionViewBackgroundColor()
    }
    
    private func setUpTitle() {
        title = userFollowers?.username ?? String()
    }
    
    private func setUpBackgroundColor() {
        view.backgroundColor = .systemBackground
    }
    
    private func setUpCollectionViewBackgroundColor() {
        collectionView.backgroundColor = .systemBackground
    }
    
    private func setUpNavigationController() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
        definesPresentationContext = true
    }
}

extension FollowersViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        performQuery(with: searchText)
    }
    
    private func performQuery(with filter: String?) {
        
    }
}


extension FollowersViewController {
    
    static func makeFollowers(with userFollowers: UserFollowers) -> FollowersViewController {
        let viewController = FollowersViewController(collectionViewLayout: UICollectionViewFlowLayout())
        viewController.userFollowers = userFollowers
        return viewController
    }
}

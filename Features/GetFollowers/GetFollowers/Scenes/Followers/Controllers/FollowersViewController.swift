//
//  FollowersViewController.swift
//  GetFollowers
//
//  Created by José Victor Pereira Costa on 24/05/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import UIKit
import Commons

typealias FollowersCollectionViewDataSource = UICollectionViewDiffableDataSource<Section, Follower>
typealias FollowersCollectionViewCellProvider = FollowersCollectionViewDataSource.CellProvider

class FollowersViewController: UICollectionViewController {

    private var modelController: FollowersModelControllerProtocol?
    private var configurator: FollowersCollectionViewConfiguratorProtocol?

    private lazy var dataSource: FollowersCollectionViewDataSource = {
        FollowersCollectionViewDataSource(collectionView: collectionView,
                                          cellProvider: cellProvider)
    }()

    private lazy var cellProvider: FollowersCollectionViewCellProvider = { [unowned self] collectionView, indexPath, item in
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCollectionViewCell.identifier,
                                                      for: indexPath)

        return cell
    }

    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.autocapitalizationType = .none
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        return searchController
    }()

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
        title = modelController?.username ?? String()
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
        guard let followers = modelController?.search(forFollower: filter) else { return }
        reloadDataSource(with: followers)
    }

    private func reloadDataSource(with followers: [Follower]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        dataSource.apply(snapshot)
    }
}

extension FollowersViewController {

    static func makeFollowers(with userFollowers: UserFollowers) -> FollowersViewController {
        let viewController = FollowersViewController(collectionViewLayout: UICollectionViewFlowLayout())
        viewController.modelController = FollowersModelController(userFollowers: userFollowers)
        viewController.configurator = FollowersCollectionViewConfigurator()
        return viewController
    }
}

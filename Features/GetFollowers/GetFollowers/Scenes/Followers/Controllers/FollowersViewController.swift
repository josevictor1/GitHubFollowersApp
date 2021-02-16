//
//  FollowersViewController.swift
//  GetFollowers
//
//  Created by José Victor Pereira Costa on 24/05/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import UIKit
import UIComponents
import Commons

typealias FollowersCollectionViewDataSource = UICollectionViewDiffableDataSource<Section, Follower>
typealias FollowersCollectionViewCellProvider = FollowersCollectionViewDataSource.CellProvider

final class FollowersViewController: UICollectionViewController {
    private var logicController: FollowersLogicControllerProtocol?
    private var configurator: FollowersCollectionViewConfiguratorProtocol?
    
    private lazy var dataSource: FollowersCollectionViewDataSource = {
        FollowersCollectionViewDataSource(collectionView: collectionView,
                                          cellProvider: cellProvider)
    }()
    
    private lazy var cellProvider: FollowersCollectionViewCellProvider = { [unowned self] collectionView, indexPath, item in
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCollectionViewCell.identifier,
                                                      for: indexPath)
        self.configurator?.configure(cell, with: item)
        return cell
    }
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.autocapitalizationType = .none
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        return searchController
    }()
    
    private let alert: CustomAlertController = {
        let alert = Alert(title: "", description: "", buttonTitle: "")
        let customAlert = CustomAlertController(alert: alert)
        return customAlert
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        loadData()
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
        setUpCollectionView()
    }
    
    private func setUpCollectionViewDataSource() {
        collectionView.prefetchDataSource = self
    }
    
    private func setUpTitle() {
        title = logicController?.userLogin ?? String()
    }
    
    private func setUpBackgroundColor() {
        view.backgroundColor = .systemBackground
    }
    
    private func setUpCollectionView() {
        setUpCollectionViewLayout()
        setUpCollectionViewBackgroundColor()
        registerCell()
    }
    
    private func setUpCollectionViewBackgroundColor() {
        collectionView.backgroundColor = .systemBackground
    }
    
    private func setUpNavigationController() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
        definesPresentationContext = true
    }
    
    private func registerCell() {
        collectionView.registerCell(FollowerCollectionViewCell.self)
    }
    
    private func loadData() {
        startLoading()
        logicController?.loadFollowers()
    }
    
    private func setUpCollectionViewLayout() {
        collectionView = UICollectionView(frame: view.frame,
                                          collectionViewLayout: .defaultCollectionViewLayout())
    }
}

extension FollowersViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        performQuery(with: searchText)
    }
    
    private func performQuery(with filter: String) {
        logicController?.searchFollower(withLogin: filter)
    }
}

extension FollowersViewController: FollowersLogicControllerOutput {
    
    func showFollowerNotFound() { }
    
    func showFailureOnFetchFollowers() {
        stopLoading()
    }
    
    func showFollowers(_ followers: [Follower]) {
        stopLoading()
        reloadDataSource(with: followers)
    }
    
    private func reloadDataSource(with followers: [Follower]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        dataSource.apply(snapshot)
    }
}

extension FollowersViewController: UICollectionViewDataSourcePrefetching {
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        
    }
}

extension FollowersViewController {
    
    static func makeFollowers(with userFollowers: UserInformation) -> FollowersViewController {
        let viewController = FollowersViewController(collectionViewLayout: UICollectionViewFlowLayout())
        viewController.logicController = FollowersLogicController(viewController: viewController,
                                                                  userFollowers: userFollowers)
        viewController.configurator = FollowersCollectionViewConfigurator()
        return viewController
    }
}

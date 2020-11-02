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

class FollowersViewController: UICollectionViewController {
    
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
        loadData()
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
        setUpCollectionViewLayout()
        setUpCollectionViewBackgroundColor()
        registerCell()
    }
    
    private func setUpTitle() {
        title = logicController?.username ?? String()
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
    
    private func registerCell() {
        collectionView.registerCell(FollowerCollectionViewCell.self)
    }
    
    private func loadData() {
        performQuery(with: .none)
    }
    
    func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex,
                                                            layoutEnvironment in
            let columns = 3
            let spacing = CGFloat(10)
            let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(90),
                                                  heightDimension: .estimated(119))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .estimated(119))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: columns)
            group.interItemSpacing = .fixed(spacing)
            
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = spacing
            section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
            
            return section
        }
        return layout
    }
    
    private func setUpCollectionViewLayout() {
        collectionView = UICollectionView(frame: view.frame,
                                          collectionViewLayout: createLayout())
    }
}

extension FollowersViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        performQuery(with: searchText)
    }
    
    private func performQuery(with filter: String?) {
        logicController?.search(for: filter) { [weak self] result in
            switch result {
            case .success(let followers):
                self?.reloadDataSource(with: followers)
            case .failure:
                break
            }
        }
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
        viewController.logicController = FollowersLogicController(userFollowers: userFollowers)
        viewController.configurator = FollowersCollectionViewConfigurator()
        return viewController
    }
}

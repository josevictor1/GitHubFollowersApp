//
//  FavoriteProfilesTableViewController.swift
//  FavoriteProfiles
//
//  Created by José Victor Pereira Costa on 01/06/21.
//  Copyright © 2021 José Victor Pereira Costa. All rights reserved.
//

import UIKit
import Commons

typealias FavoriteProfilesDataSource = UITableViewDiffableDataSource<FavoriteProfilesSection, FavoriteProfile>
typealias FavoriteProfilesDataSourceSnapshot = NSDiffableDataSourceSnapshot<FavoriteProfilesSection, FavoriteProfile>
typealias FavoriteProfilesCellProvider = FavoriteProfilesDataSource.CellProvider

final class FavoriteProfilesTableViewController: UITableViewController {
    
    private lazy var dataSource: FavoriteProfilesCustomDataSource = {
        let dataSource = FavoriteProfilesCustomDataSource(tableView: tableView,
                                                          cellProvider: cellProvider)
        dataSource.delegate = self
        return dataSource
    }()
    
    private let logicController: FavoriteProfilesLogicControllerProtocol
    
    init(logicController: FavoriteProfilesLogicControllerProtocol) {
        self.logicController = logicController
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var cellProvider: FavoriteProfilesCellProvider = { tableView, indexPath, item in
        let cell = tableView.dequeueReusableCell(withClass: ProfileTableViewCell.self, for: indexPath)
        cell?.configure(with: item)
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        registerCells()
    }
    
    private func setUp() {
        setUpNavigationBarTitle()
    }
    
    private func setUpNavigationBarTitle() {
        title = "Favorite"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func registerCells() {
        tableView.registerCell(ProfileTableViewCell.self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        logicController.loadProfiles()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        logicController.syncProfiles()
    }
}

extension FavoriteProfilesTableViewController: FavoriteProfilesLogicControllerOutput {
    
    func didUpdateFavoriteProfiles(_ favoriteUserProfiles: [FavoriteProfile]) {
        reloadDataSource(with: favoriteUserProfiles)
    }
    
    private func reloadDataSource(with profiles: [FavoriteProfile]) {
        
        var snapshot = FavoriteProfilesDataSourceSnapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(profiles)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    func didFailOnUpdateFavoriteProfiles() {
        
    }
}

extension FavoriteProfilesTableViewController: FavoriteProfilesCustomDataSourceDelegate {
    
    func tableViewDeletedCell(atIndexPath indexPath: IndexPath) {
        logicController.deleteProfile(atIndex: indexPath.row)
    }
}

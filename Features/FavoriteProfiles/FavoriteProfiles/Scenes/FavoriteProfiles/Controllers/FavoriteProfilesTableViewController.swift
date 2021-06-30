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
    
    private lazy var dataSource = FavoriteProfilesDataSource(tableView: tableView,
                                                             cellProvider: cellProvider)
    var logicController: FavoriteProfilesLogicControllerProtocol?
    
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
        setUpTableView()
    }
    
    private func setUpNavigationBarTitle() {
        title = "Favorite"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    private func setUpTableView() {
        tableView.estimatedRowHeight = 80
    }
    
    private func registerCells() {
        tableView.registerCell(ProfileTableViewCell.self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        logicController?.loadProfiles()
        reloadDataSource(with: [])
    }
}

extension FavoriteProfilesTableViewController: FavoriteProfilesLogicControllerOutput {
    
    func didUpdateFavoriteProfiles(_ favoriteUserProfiles: [FavoriteProfile]) {
        reloadDataSource(with: favoriteUserProfiles)
    }
    
    private func reloadDataSource(with profiles: [FavoriteProfile]) {
        let profiles = [FavoriteProfile(login: "josevictor1", avatarURL: "josevictor1"),
                        FavoriteProfile(login: "josevictor1", avatarURL: "josevictor1")]
        var snapshot = FavoriteProfilesDataSourceSnapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(profiles)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    func didFailOnUpdateFavoriteProfiles() {
        
    }
    
    func didFailOnAddFavoriteProfile() {
        
    }
}

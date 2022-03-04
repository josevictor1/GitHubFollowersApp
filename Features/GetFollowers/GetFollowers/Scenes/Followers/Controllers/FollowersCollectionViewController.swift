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

typealias FollowersDataSource = UICollectionViewDiffableDataSource<FollowersSections, Follower>
typealias FollowersDataSourceSnapshot = NSDiffableDataSourceSnapshot<FollowersSections, Follower>
typealias FollowersCollectionViewCellProvider = FollowersDataSource.CellProvider

final class FollowersCollectionViewController: UICollectionViewController {
    
    private let logicController: FollowersLogicControllerProtocol
    private let configurator: FollowersCollectionViewConfiguratorProtocol
    private let errorPresenter: GetFollowersErrorAlertPresenterProtocol
    private let coordinator: FollowersCoordinator
    
    private lazy var dataSource: FollowersDataSource = {
        FollowersDataSource(collectionView: collectionView,
                            cellProvider: cellProvider)
    }()
    
    private lazy var cellProvider: FollowersCollectionViewCellProvider = { [unowned self] collectionView, indexPath, item in
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCollectionViewCell.identifier,
                                                      for: indexPath)
        self.configurator.configure(cell, with: item)
        return cell
    }
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.autocapitalizationType = .none
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        return searchController
    }()
    
    private lazy var favoriteBarButtonItem: UIBarButtonItem = {
        let favoriteBarButtonItem = UIBarButtonItem()
        favoriteBarButtonItem.target = self
        favoriteBarButtonItem.action = #selector(favoriteButtonTapped)
        favoriteBarButtonItem.image = ImageAssets.favoriteIcon.image
        return favoriteBarButtonItem
    }()
    
    init(logicController: FollowersLogicControllerProtocol,
         configurator: FollowersCollectionViewConfiguratorProtocol,
         presenter: GetFollowersErrorAlertPresenterProtocol,
         coordinator: FollowersCoordinator) {
        self.logicController = logicController
        self.configurator = configurator
        self.errorPresenter = presenter
        self.coordinator = coordinator
        super.init(collectionViewLayout: .threeColumnLayout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        setUpFavoriteNavigationBarButton()
        setUpBackgroundColor()
        setUpCollectionView()
        setUpFavoriteButtonState()
    }
    
    private func setUpTitle() {
        title = logicController.userInformation.login
    }
    
    private func setUpFavoriteNavigationBarButton() {
        navigationItem.rightBarButtonItem = favoriteBarButtonItem
    }
    
    private func setUpBackgroundColor() {
        view.backgroundColor = .systemBackground
    }
    
    private func setUpCollectionView() {
        setUpCollectionViewLayout()
        setUpCollectionViewBackgroundColor()
        registerCell()
    }
    
    private func setUpFavoriteButtonState() {
        logicController.loadFavoriteState()
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
    
    private func setUpCollectionViewLayout() {
        collectionView.setContentOffset(.zero, animated: true)
    }
    
    private func loadData() {
        startLoading()
        logicController.loadFollowers()
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let numberOfItemsPerSection = 3
        let followerIndex = indexPath.row + (indexPath.section * numberOfItemsPerSection)
        logicController.selectFollower(atIndex: followerIndex)
    }
    
    @objc private func favoriteButtonTapped() {
        logicController.addSelectedUsersToFavorite()
    }
}

extension FollowersCollectionViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        logicController.searchFollower(withLogin: searchText)
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard didScrollViewReachedTheBottom(scrollView) else { return }
        logicController.loadNextPage()
    }
    
    private func didScrollViewReachedTheBottom(_ scrollView: UIScrollView) -> Bool {
        let currentPoint = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let scrollViewHeight = scrollView.frame.size.height
        return currentPoint > scrollViewHeight - contentHeight
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        logicController.cancelSearch()
    }
}

extension FollowersCollectionViewController: FollowersLogicControllerOutput {
    
    func failedOnFetchFollowers(_ error: GetFollowersError) {
        stopLoading()
        errorPresenter.present(error)
    }
    
    func followersNotFound() {
        let emptyState = FollowersEmptyBackgroundView()
        view.embed(emptyState)
    }
    
    func didFetchFollowers(_ followers: [Follower]) {
        stopLoading()
        reloadDataSource(with: followers)
    }
    
    private func reloadDataSource(with followers: [Follower]) {
        var snapshot = FollowersDataSourceSnapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        dataSource.apply(snapshot)
    }
    
    func showUserInformation(forLogin login: String) {
        coordinator.showInformation(for: login)
    }
    
    func failedAddUserToFavorites() {
        errorPresenter.present(.persistenceFail)
    }
    
    func didAddUser() {
        favoriteBarButtonItem.image = ImageAssets.favoriteFilledIcon.image
        let customAlert = CustomAlertController(alert: .userAddedToFavorites) { [weak self] in
            self?.dismiss(animated: true)
        }
        present(customAlert, animated: true)
    }
    
    func didFetchSelectedUserOnFavorites() {
        favoriteBarButtonItem.image = ImageAssets.favoriteFilledIcon.image
    }
    
    func selectedUserNotFound() {
        favoriteBarButtonItem.image = ImageAssets.favoriteIcon.image
    }
}

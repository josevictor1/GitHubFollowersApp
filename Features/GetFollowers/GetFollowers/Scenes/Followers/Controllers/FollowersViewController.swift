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

typealias FollowersCollectionViewDataSource = UICollectionViewDiffableDataSource<FollowersSections, Follower>
typealias FollowersCollectionViewCellProvider = FollowersCollectionViewDataSource.CellProvider

final class FollowersViewController: UICollectionViewController {
    var logicController: FollowersLogicControllerProtocol?
    var configurator: FollowersCollectionViewConfiguratorProtocol?
    var presenter: GetFollowersAlertPresenterProtocol?
    var coordinator: FollowersCoordinator?

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
                                          collectionViewLayout: .threeColumnLayout)
        collectionView.setContentOffset(.zero, animated: true)
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let numberOfItemsPerSection = 3
        let followerIndex = indexPath.row + (indexPath.section * numberOfItemsPerSection)
        logicController?.selectFollower(atIndex: followerIndex)
    }
}

extension FollowersViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        logicController?.searchFollower(withLogin: searchText)
    }

    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentPoint = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let scrollViewHeight = scrollView.frame.size.height
        guard currentPoint > scrollViewHeight - contentHeight else { return }
        logicController?.loadNextPage()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        logicController?.cancelSearch()
    }
}

extension FollowersViewController: FollowersLogicControllerOutput {

    func showFailureOnFetchFollowers(_ error: GetFollowersError) {
        stopLoading()
        presenter?.present(error)
    }

    func showFollowersNotFound() {
        let emptyState = FollowersEmptyBackgroundView()
        view.embed(emptyState)
    }

    func showFollowers(_ followers: [Follower]) {
        stopLoading()
        reloadDataSource(with: followers)
    }

    func showUserInformation(for login: String) {
        coordinator?.showInformation(for: login)
    }

    private func reloadDataSource(with followers: [Follower]) {
        var snapshot = NSDiffableDataSourceSnapshot<FollowersSections, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        dataSource.apply(snapshot)
    }
}

extension FollowersViewController {

    static func makeFollowers(with userFollowers: UserInformation,
                              coordinator: FollowersCoordinator) -> FollowersViewController {
        let viewController = FollowersViewController(collectionViewLayout: UICollectionViewFlowLayout())
        let presenter = GetFollowersAlertPresenter()
        let paginationController = PaginationController(numberOfItems: userFollowers.numberOfFollowers)
        viewController.logicController = FollowersLogicController(viewController: viewController,
                                                                  userFollowers: userFollowers,
                                                                  paginationController: paginationController)
        viewController.configurator = FollowersCollectionViewConfigurator()
        viewController.coordinator = coordinator
        presenter.configureAlert(to: viewController)
        viewController.presenter = presenter
        return viewController
    }
}

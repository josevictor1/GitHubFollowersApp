//
//  UserInformationCollectionViewController.swift
//  UserInformation
//
//  Created by José Victor Pereira Costa on 24/02/21.
//  Copyright © 2021 José Victor Pereira Costa. All rights reserved.
//

import UIComponents
import Commons
import UIKit

typealias UserInformationDataSource = UICollectionViewDiffableDataSource<UserInformationSections, UserInformation>
typealias UserInformationDataSourceSnapshot = NSDiffableDataSourceSnapshot<UserInformationSections, UserInformation>

final class UserInformationCollectionViewController: UICollectionViewController {
    var coordinator: UserInformationCoordinatorProtocol?
    var logicController: UserInformationLogicControllerProtocol?
    var presenter: GetFollowersAlertPresenterProtocol?
    var cellProvider: UserInformationCellProviderProtocol?
    
    private lazy var dataSource: UserInformationDataSource = {
        let dataSource = UserInformationDataSource(collectionView: collectionView) { [unowned self] collectionView, index, item in
            return self.cellProvider?.createCell(for: collectionView,
                                                 at: index,
                                                 withItem: item)
        }
        return dataSource
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    private func setUp() {
        setUpNavigationController()
        setUpBackgroundColor()
        setUpCollectionView()
    }
    
    private func setUpNavigationController() {
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    private func setUpBackgroundColor() {
        view.backgroundColor = .systemBackground
    }
    
    private func setUpCollectionView() {
        setUpCollectionViewLayout()
        registerCollectionViewCells()
        registerSupplementaryViews()
        setUpCollectionViewDataSource()
    }
    
    private func setUpCollectionViewLayout() {
        collectionView = UICollectionView(frame: view.frame,
                                          collectionViewLayout: .verticalLayout)
        collectionView.backgroundColor = .clear
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.alwaysBounceVertical = false
    }
    
    private func registerCollectionViewCells() {
        cellProvider?.registerCells(for: collectionView)
    }
    
    private func registerSupplementaryViews() {
        cellProvider?.registerSupplementaryViews(for: collectionView)
    }
    
    private func setUpCollectionViewDataSource() {
        collectionView.dataSource = dataSource
        setUpSupplementaryViewProvider()
    }
    
    private func setUpSupplementaryViewProvider() {
        dataSource.supplementaryViewProvider = { [unowned self] collectionView, kind, indexPath in
            let profileInformation = self.logicController?.profileInformation
            return self.cellProvider?.createSupplementaryView(for: collectionView,
                                                              withKind: kind,
                                                              atIndexPath: indexPath,
                                                              profileInformation: profileInformation)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadData()
    }
    
    private func loadData() {
        startLoading()
        logicController?.loadUserInformation()
    }
}

extension UserInformationCollectionViewController: UserInformationLogicOutput {
    
    func didFetchUserInformationWithoutUpdates() {
        stopLoading()
    }
    
    func didFetchUserInformation(_ userInformation: [UserInformation]) {
        stopLoading()
        reloadDataSource(with: userInformation)
    }
    
    private func reloadDataSource(with userInformation: [UserInformation]) {
        var snapshot = UserInformationDataSourceSnapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(userInformation)
        dataSource.apply(snapshot)
    }
    
    func didFetchUserInformationWithError(_ error: GetFollowersError) {
        presenter?.present(error)
    }
}

extension UserInformationCollectionViewController: UserInformationConfiguratorDelegate {
    
    func didTapNavigationIcon(_ companyCollectionView: PersonalInformationView) {
        guard let emailAddress = logicController?.email else { return }
        coordinator?.navigateToEmail(withAddress: emailAddress)
    }
    
    func didTapWebsiteButton(_ companyView: PersonalInfromationComposedView) {
        guard let blogURL = logicController?.blogURL else { return }
        coordinator?.navigateToPage(withURL: blogURL)
    }
    
    func didTapGitHubProfileButton(_ repositoryView: RepositoryView) {
        guard let profileURL = logicController?.githubProfileURL else { return }
        coordinator?.navigateToPage(withURL: profileURL)
    }
    
    func didTapGetFollowersButton(_ repositoryView: RepositoryView) {
        guard let login = logicController?.login else { return }
        coordinator?.navigateToFollowers(withLogin: login)
    }
}

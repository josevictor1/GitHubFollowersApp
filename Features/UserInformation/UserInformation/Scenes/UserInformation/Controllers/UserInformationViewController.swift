//
//  UserInformationCollectionViewController.swift
//  UserInformation
//
//  Created by José Victor Pereira Costa on 24/02/21.
//

import UIComponents
import UIKit

typealias UserInformationDataSource = UICollectionViewDiffableDataSource<UserInformationSections, UserInformation>
typealias ProfileSupplementaryView = ContainerReusableView<ProfileView>
typealias AccountCreationYearSupplementaryView = ContainerReusableView<AccountCreationYearView>

final class UserInformationViewController: UICollectionViewController {
    
    private lazy var dataSource = UserInformationDataSource(collectionView: collectionView) { collectionView,  indexPath, item in
        UICollectionViewCell()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    private func setUp() {
        setUpBackgroundColor()
        setUpCollectionView()
    }
    
    private func setUpBackgroundColor() {
        view.backgroundColor = .systemBackground
    }
    
    private func setUpCollectionView() {
        setUpCollectionViewLayout()
        registerCollectionViewCells()
        setUpCollectionViewDataSource()
    }
    
    private func setUpCollectionViewLayout() {
        collectionView = UICollectionView(frame: view.frame,
                                          collectionViewLayout: .verticalLayout)
        collectionView.backgroundColor = .clear
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    private func registerCollectionViewCells() {
        collectionView.registerSupplementaryView(ProfileSupplementaryView.self,
                                                 kind: UICollectionView.elementKindSectionHeader)
        collectionView.registerSupplementaryView(AccountCreationYearSupplementaryView.self,
                                                 kind: UICollectionView.elementKindSectionFooter)
    }
    
    private func setUpCollectionViewDataSource() {
        collectionView.dataSource = dataSource
        
        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            switch kind {
            case UICollectionView.elementKindSectionHeader:
                return collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                       withViewClass: ProfileSupplementaryView.self,
                                                                       for: indexPath)
            case UICollectionView.elementKindSectionFooter:
                return collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                       withViewClass: AccountCreationYearSupplementaryView.self,
                                                                       for: indexPath)
            default:
                return nil
            }
        }
        reloadDataSource(with: [.company(Company(company: "test"))])
    }
    
    private func reloadDataSource(with userInformation: [UserInformation]) {
        var snapshot = NSDiffableDataSourceSnapshot<UserInformationSections, UserInformation>()
        snapshot.appendSections([.main])
        snapshot.appendItems(userInformation)
        dataSource.apply(snapshot)
    }
}

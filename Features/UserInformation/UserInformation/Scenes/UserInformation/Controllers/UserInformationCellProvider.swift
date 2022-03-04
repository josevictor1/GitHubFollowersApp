//
//  UserInformationCellProvider.swift
//  UserInformation
//
//  Created by José Victor Pereira Costa on 06/04/21.
//  Copyright © 2021 José Victor Pereira Costa. All rights reserved.
//

import UIComponents
import UIKit

typealias ProfileSupplementaryView = ContainerReusableView<ProfileView>
typealias AccountCreationYearSupplementaryView = ContainerReusableView<AccountCreationYearView>
typealias PersonalInfromationComposedView = ContainerButtonComposedView<PersonalInformationView>
typealias PersonalInformationCollectionViewCell = RoundedContainerCollectionViewCell<PersonalInfromationComposedView>
typealias RepositoryView = ContainerButtonComposedView<RepositoryInformationView>
typealias RepositoryInformationCollectionViewCell = RoundedContainerCollectionViewCell<RepositoryView>

protocol UserInformationCellProviderProtocol {
    func registerCells(for collectionView: UICollectionView)
    func registerSupplementaryViews(for collectionView: UICollectionView)
    func createCell(for collectionView: UICollectionView,
                    at indexPath: IndexPath,
                    withItem item: UserInformation) -> UICollectionViewCell?
    func createSupplementaryView(for collectionView: UICollectionView,
                                 withKind kind: String,
                                 atIndexPath indexPath: IndexPath,
                                 profileInformation: ProfileInformation?) -> UICollectionReusableView?
}

final class UserInformationCellProvider: UserInformationCellProviderProtocol {
    
    private let configurator: UserInformationConfigurator
    
    init(configurator: UserInformationConfigurator) {
        self.configurator = configurator
    }
    
    func registerCells(for collectionView: UICollectionView) {
        collectionView.registerCell(PersonalInformationCollectionViewCell.self)
        collectionView.registerCell(RepositoryInformationCollectionViewCell.self)
    }
    
    func registerSupplementaryViews(for collectionView: UICollectionView) {
        collectionView.registerSupplementaryView(ProfileSupplementaryView.self,
                                                 kind: UICollectionView.elementKindSectionHeader)
        collectionView.registerSupplementaryView(AccountCreationYearSupplementaryView.self,
                                                 kind: UICollectionView.elementKindSectionFooter)
    }
    
    func createCell(for collectionView: UICollectionView,
                    at indexPath: IndexPath,
                    withItem item: UserInformation) -> UICollectionViewCell? {
        switch item {
        case .personalInformation:
            return dequeuConfiguredPersonalInformationCollectionViewCell(collectionView, at: indexPath, with: item)
        case .repository:
            return dequeueRepositoryInformationCollectionViewCell(collectionView, at: indexPath, with: item)
        case .followers:
            return dequeueFollowersInformationCollectionViewCell(collectionView, at: indexPath, with: item)
        }
    }
    
    private func dequeuConfiguredPersonalInformationCollectionViewCell(_ collectionView: UICollectionView,
                                                                       at indexPath: IndexPath,
                                                                       with item: UserInformation) -> UICollectionViewCell? {
        guard let cell = collectionView.dequeueReusableCell(withClass: PersonalInformationCollectionViewCell.self,
                                                            for: indexPath) else { return nil }
        configurator.configureCompanyCell(cell, with: item)
        return cell
    }
    
    private func dequeueRepositoryInformationCollectionViewCell(_ collectionView: UICollectionView,
                                                                at indexPath: IndexPath,
                                                                with item: UserInformation) -> UICollectionViewCell? {
        guard let cell = collectionView.dequeueReusableCell(withClass: RepositoryInformationCollectionViewCell.self,
                                                            for: indexPath) else { return nil }
        configurator.configureReporistoryCell(cell, with: item)
        return cell
    }
    
    private func dequeueFollowersInformationCollectionViewCell(_ collectionView: UICollectionView,
                                                               at indexPath: IndexPath,
                                                               with item: UserInformation) -> UICollectionViewCell? {
        guard let cell = collectionView.dequeueReusableCell(withClass: RepositoryInformationCollectionViewCell.self,
                                                            for: indexPath) else { return nil }
        configurator.configureFollowersCell(cell, with: item)
        return cell
    }
    
    func createSupplementaryView(for collectionView: UICollectionView,
                                 withKind kind: String,
                                 atIndexPath indexPath: IndexPath,
                                 profileInformation: ProfileInformation?) -> UICollectionReusableView? {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            return dequeueConfiguredHeader(collectionView, withKind: kind, andIndexPath: indexPath, profileInformation: profileInformation)
        case UICollectionView.elementKindSectionFooter:
            return dequeueConfiguredFooter(collectionView, withKind: kind, andIndexPath: indexPath, profileInformation: profileInformation)
        default:
            return nil
        }
    }
    
    private func dequeueConfiguredHeader(_ collectionView: UICollectionView,
                                         withKind kind: String,
                                         andIndexPath indexPath: IndexPath,
                                         profileInformation: ProfileInformation?) -> ProfileSupplementaryView? {
        guard let profileInformation = profileInformation else { return nil }
        guard let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                         withViewClass: ProfileSupplementaryView.self,
                                                                         for: indexPath) else { return nil }
        configurator.configureProfileSupplementaryView(cell, with: profileInformation)
        return cell
    }
    
    private func dequeueConfiguredFooter(_ collectionView: UICollectionView,
                                         withKind kind: String,
                                         andIndexPath indexPath: IndexPath,
                                         profileInformation: ProfileInformation?) -> AccountCreationYearSupplementaryView? {
        guard let profileInformation = profileInformation else { return nil }
        guard let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                         withViewClass: AccountCreationYearSupplementaryView.self,
                                                                         for: indexPath) else { return nil }
        configurator.configureAccountCreationYearSupplementaryView(cell, with: profileInformation)
        return cell
    }
}

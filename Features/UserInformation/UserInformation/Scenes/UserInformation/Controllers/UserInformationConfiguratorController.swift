//
//  UserInformationConfiguratorController.swift
//  UserInformation
//
//  Created by José Victor Pereira Costa on 28/03/21.
//  Copyright © 2021 José Victor Pereira Costa. All rights reserved.
//

import UIComponents
import Commons
import UIKit

protocol UserInformationConfigurator: AnyObject {
    func configureCompanyCell(_ cell: PersonalInformationCollectionViewCell, with userInformation: UserInformation)
    func configureReporistoryCell(_ cell: RepositoryInformationCollectionViewCell, with userInformation: UserInformation)
    func configureFollowersCell(_ cell: RepositoryInformationCollectionViewCell, with userInformation: UserInformation)
    func configureProfileSupplementaryView(_ view: ProfileSupplementaryView, with profileInformation: ProfileInformation)
    func configureAccountCreationYearSupplementaryView(_ view: AccountCreationYearSupplementaryView,
                                                       with profileInformation: ProfileInformation)
}

protocol UserInformationConfiguratorDelegate: AnyObject {
    func didTapNavigationIcon(_ companyCollectionView: PersonalInformationView)
    func didTapWebsiteButton(_ companyView: PersonalInfromationComposedView)
    func didTapGitHubProfileButton(_ repositoryView: RepositoryView)
    func didTapGetFollowersButton(_ repositoryView: RepositoryView)
}

private typealias Information = (icon: ImageAssets, title: Localizable, text: String)
private typealias RepositoryInformation = (leftSideInformation: Information, rightSideInformation: Information)

final class UserInformationConfiguratorController: UserInformationConfigurator {
    
    private unowned let delegate: UserInformationConfiguratorDelegate
    
    init(delegate: UserInformationConfiguratorDelegate) {
        self.delegate = delegate
    }
    
    func configureCompanyCell(_ cell: PersonalInformationCollectionViewCell, with userInformation: UserInformation) {
        guard case let .personalInformation(personalInformation) = userInformation else { return }
        configureCompanyView(at: cell.containerView, isEnabled: !personalInformation.blog.isEmpty)
        configureCompanyInformation(at: cell.containerView.containerView, with: personalInformation)
    }
    
    private func configureCompanyView(at companyView: PersonalInfromationComposedView, isEnabled: Bool) {
        companyView.roundedButton.isEnabled = isEnabled
        companyView.roundedButton.alpha = isEnabled ? 1 : 0.5
        configureButton(companyView.roundedButton,
                        withLicalizableTitle: .website,
                        andBackgroundColor: .systemRed)
        companyView.onButtonTapped = { [unowned self] in
            self.delegate.didTapWebsiteButton(companyView)
        }
    }
    
    private func configureCompanyInformation(at companyInformationView: PersonalInformationView,
                                             with personalInformation: PersonalInformation) {
        companyInformationView.companyName = personalInformation.name
        companyInformationView.isNavigationButtonHidden = personalInformation.email.isEmpty
        companyInformationView.onNavigationButtonTapped = { [unowned self] in
            self.delegate.didTapNavigationIcon(companyInformationView)
        }
    }
    
    func configureReporistoryCell(_ cell: RepositoryInformationCollectionViewCell,
                                  with userInformation: UserInformation) {
        configureRepositoryViewForRepositoriesGists(cell.containerView)
        guard case let .repository(repository) = userInformation else { return }
        let leftSideInformation = Information(icon: .folderIcon, title: .publicRepos, text: repository.repos)
        let rightSideInformation = Information(icon: .gistsIcon, title: .publicGists, text: repository.gists)
        let repositoryInformation = RepositoryInformation(leftSideInformation: leftSideInformation,
                                                          rightSideInformation: rightSideInformation)
        configureRepositoryInformationView(at: cell.containerView.containerView, with: repositoryInformation)
    }
    
    private func configureRepositoryViewForRepositoriesGists(_ repositoryView: RepositoryView) {
        configureButton(repositoryView.roundedButton,
                        withLicalizableTitle: .githubProfile,
                        andBackgroundColor: .systemPurple)
        repositoryView.onButtonTapped = { [unowned self] in
            self.delegate.didTapGitHubProfileButton(repositoryView)
        }
    }
    
    func configureFollowersCell(_ cell: RepositoryInformationCollectionViewCell,
                                with userInformation: UserInformation) {
        configureRepositoryViewForFollowers(cell.containerView)
        guard case let .followers(followers) = userInformation else { return }
        let leftSideInformation = Information(icon: .companyIcon, title: .following, text: followers.following)
        let rightSideInformation = Information(icon: .followersIcon, title: .followers, text: followers.followers)
        let repositoryInformation = RepositoryInformation(leftSideInformation: leftSideInformation,
                                                          rightSideInformation: rightSideInformation)
        configureRepositoryInformationView(at: cell.containerView.containerView, with: repositoryInformation)
    }
    
    private func configureRepositoryViewForFollowers(_ repositoryView: RepositoryView) {
        configureButton(repositoryView.roundedButton,
                        withLicalizableTitle: .getFollowers,
                        andBackgroundColor: .systemGreen)
        repositoryView.onButtonTapped = { [unowned self] in
            self.delegate.didTapGetFollowersButton(repositoryView)
        }
    }
    
    private func configureButton(_ button: UIButton,
                                 withLicalizableTitle localizableTitle: Localizable,
                                 andBackgroundColor backgroundColor: UIColor) {
        button.setTitle(localizableTitle.localized, for: .normal)
        button.backgroundColor = backgroundColor
    }
    
    private func configureRepositoryInformationView(at repositoryInformationView: RepositoryInformationView,
                                                    with repositoryInformation: RepositoryInformation) {
        configureInformationView(repositoryInformationView.leftInformationView,
                                 with: repositoryInformation.leftSideInformation)
        configureInformationView(repositoryInformationView.rightInformationView,
                                 with: repositoryInformation.rightSideInformation)
    }
    
    private func configureInformationView(_ informationView: InformationView, with information: Information) {
        informationView.iconImageView.image = information.icon.image
        informationView.titleLabel.text = information.title.localized
        informationView.informationLabel.text = information.text
    }
    
    func configureProfileSupplementaryView(_ view: ProfileSupplementaryView, with profileInformation: ProfileInformation) {
        view.containerView.configure(with: profileInformation)
    }
    
    func configureAccountCreationYearSupplementaryView(_ view: AccountCreationYearSupplementaryView,
                                                       with profileInformation: ProfileInformation) {
        let formattedYear = makeFormattedYear(with: profileInformation)
        let githubCreation = String(format: Localizable.githubCreation.localized, formattedYear)
        view.containerView.year = githubCreation
    }
    
    private func makeFormattedYear(with profileInformation: ProfileInformation) -> String {
        let date = profileInformation.creationDate
        let formatter = DateFormatter()
        formatter.dateFormat = .mothYearDatePattern
        return formatter.string(from: date)
    }
}

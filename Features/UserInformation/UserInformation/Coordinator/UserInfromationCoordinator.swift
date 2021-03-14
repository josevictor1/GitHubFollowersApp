//
//  UserInfromationCoordinator.swift
//  UserInformation
//
//  Created by José Victor Pereira Costa on 24/02/21.
//

import Core
import UIKit

public final class UserInformationCoordinator: NavigationCoordinator {
    public var parent: Coordinator?
    public var children: [Coordinator] = []
    public var navigationController: UINavigationController?

    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    public func start() {
        setUpNavigationControllerLayout()
    }

    private func setUpNavigationControllerLayout() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .chateauGreen
    }

    public func navigateToUserInformation(withLogin login: String) {
        let viewController = UserInformationViewController(collectionViewLayout: UICollectionViewFlowLayout())
        navigationController?.setViewControllers([viewController], animated: false)
    }
}

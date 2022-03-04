//
//  MainCoordinator.swift
//  GitHub
//
//  Created by José Victor Pereira Costa on 28/02/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import UIKit
import Commons
import Core
import GetFollowers
import FavoriteProfiles
import UserInformation

final class MainCoordinator: Coordinator {
    
    var parent: Coordinator?
    var children: [Coordinator] = []
    private let tabBarController: UITabBarController
    
    private var getFollowersNavigationController: UINavigationController {
        let coordinator: GetFollowersCoordinator = .instantiate()
        coordinator.navigationController?.tabBarItem = .tabBarItem(for: .getFollowers)
        coordinator.delegate = self
        addChildCoordinator(coordinator)
        return coordinator.navigationController!
    }
    
    private var favoriteProfillesNavigationController: UINavigationController {
        let coordinator: FavoriteProfilesCoordinator = .instantiate()
        coordinator.navigationController?.tabBarItem = .tabBarItem(for: .favoriteProfiles)
        addChildCoordinator(coordinator)
        return coordinator.navigationController!
    }
    
    private var tabBarChildViewControllers: [UIViewController] {
        [
            getFollowersNavigationController,
            favoriteProfillesNavigationController
        ]
    }
    
    init(window: UIWindow, tabBarController: UITabBarController = UITabBarController()) {
        self.tabBarController = tabBarController
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }
    
    func start() {
        tabBarController.viewControllers = tabBarChildViewControllers
        tabBarController.tabBar.tintColor = .chateauGreen
    }
    
    func navigateToUserInformation(withLogin login: String) {
        let coordinator: UserInformationCoordinator = .instantiate()
        coordinator.delegate = self
        addChildCoordinator(coordinator)
        coordinator.navigateToUserInformation(withLogin: login)
        guard let navigationController = coordinator.navigationController else { return }
        tabBarController.present(navigationController, animated: true)
    }
    
    func navigateToFavorites(with selectedUser: SelectedUserInformation) {
        guard let coordinator: FavoriteProfilesCoordinator = childCoordinator() else { return }
        coordinator.navigateToFavoriteProfiles(with: selectedUser)
    }
    
    func navigateToFollowers(with selectedUserInformation: SelectedUserInformation) {
        guard let coordinator: GetFollowersCoordinator = childCoordinator() else { return }
        coordinator.reloadFollowers(with: selectedUserInformation)
    }
    
    private func childCoordinator<T: Coordinator>() -> T? {
        let coordinator = children.first(where: { $0 is T })
        return coordinator as? T
    }
    
    private func addChildCoordinator(_ coordinator: Coordinator) {
        children.append(coordinator)
        coordinator.parent = self
        coordinator.start()
    }
}

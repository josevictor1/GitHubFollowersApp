//
//  MainCoordinator.swift
//  GitHub
//
//  Created by José Victor Pereira Costa on 28/02/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import UIKit
import Core
import UserInformation
import GetFollowers

final class MainCoordinator: Coordinator {
    var parent: Coordinator?
    var children: [Coordinator] = []
    private let tabBarController: UITabBarController

    private var getFollowersNavigationController: UINavigationController {
        let coordinator: GetFollowersCoordinator = .instantiate()
        coordinator.navigationController?.tabBarItem = tabBarItem()
        coordinator.delegate = self
        addChildCoordinator(coordinator)
        return coordinator.navigationController!
    }

    init(window: UIWindow, tabBarController: UITabBarController = UITabBarController()) {
        self.tabBarController = tabBarController
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }

    func start() {
        tabBarController.viewControllers = [getFollowersNavigationController]
        tabBarController.tabBar.tintColor = .chateauGreen
    }

    private func tabBarItem() -> UITabBarItem {
        UITabBarItem(title: "Search",
                     image: UIImage(named: "magnifyingglass"),
                     tag: .zero)
    }

    func navigateToUserInformation(withLogin login: String) {
        let coordinator: UserInformationCoordinator = .instantiate()
        addChildCoordinator(coordinator)
        coordinator.navigateToUserInformation(withLogin: login)
        guard let navigationController = coordinator.navigationController else { return }
        tabBarController.present(navigationController, animated: true)
    }

    private func addChildCoordinator(_ coordinator: Coordinator) {
        coordinator.children.append(coordinator)
        coordinator.parent = self
        coordinator.start()
    }
}

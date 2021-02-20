//
//  MainCoordinator.swift
//  GitHub
//
//  Created by José Victor Pereira Costa on 28/02/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import UIKit
import Core
import GetFollowers

final class MainCoordinator: Coordinator {
    var parent: Coordinator?
    var children: [Coordinator] = []
    private let tabBarController: UITabBarController

    init(window: UIWindow, tabBarController: UITabBarController = UITabBarController()) {
        self.tabBarController = tabBarController
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }

    func start() {
        tabBarController.viewControllers = [setUpSearchFollowersTab()]
        tabBarController.tabBar.tintColor = .chateauGreen
    }

    private func tabBarItem() -> UITabBarItem {
        UITabBarItem(title: "Search",
                     image: UIImage(named: "magnifyingglass"),
                     tag: .zero)
    }

    private func setUpSearchFollowersTab() -> UIViewController {
        let coordinator: GetFollowersCoordinator = .instantiate()
        coordinator.navigationController?.tabBarItem = tabBarItem()
        children.append(coordinator)
        coordinator.start()
        return coordinator.navigationController!
    }
}

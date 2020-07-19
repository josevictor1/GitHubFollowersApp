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

class MainCoordinator: Coordinator {

    // MARK: - Properties

    var parent: Coordinator?
    var children: [Coordinator] = []
    private var tabBarController: UITabBarController?

    // MARK: - Initializers

    /// Create a `MainCoordinator` object  with and set the `rootViewController`.
    /// - Parameters:
    ///   - window: The host `UIWindow` that holds a `UITabBarController` as  `rootViewController`
    init(window: UIWindow) {
        tabBarController = UITabBarController()
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }

    func start() {
        tabBarController?.viewControllers = [setUpSearchFollowersTab()]
        tabBarController?.tabBar.tintColor = .chateauGreen
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

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
    ///   - window: The host `UIWindow` that holds `navigationController` as  `rootViewController`
    init(window: UIWindow) {
        tabBarController = UITabBarController()
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }

    func start() {
        tabBarController?.viewControllers = [setUpSearchFollowersTab()]
        tabBarController?.tabBar.tintColor = UIColor(red: 45/255, green: 186/255, blue: 78/255, alpha: 1)
    }
    
    private func setUpSearchFollowersTab() -> UIViewController {
        let coordinator: GetFollowersCoordinator = .instantiate()
        children.append(coordinator)
        coordinator.navigationController?.tabBarItem = UITabBarItem(title: "Search", image: UIImage(named: "magnifyingglass"), tag: 0)
        coordinator.start()
        return coordinator.navigationController!
    }

}

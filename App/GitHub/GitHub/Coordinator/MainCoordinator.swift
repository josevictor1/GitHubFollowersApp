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
    /// The passed navigation controller is setted as `rootViewController` on the passed window.
    /// - Parameters:
    ///   - window: The host `UIWindow` that holds `navigationController` as  `rootViewController`
    init(window: UIWindow) {
        tabBarController = UITabBarController()
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }

    func start() {
        tabBarController?.viewControllers = [setUpSearchFollowersTab()]
    }
    
    private func setUpSearchFollowersTab() -> UIViewController {
        let coordinator: GetFollowersCoordinator = .instantiate()
        children.append(coordinator)
        coordinator.start()
        return coordinator.navigationController!
    }

}

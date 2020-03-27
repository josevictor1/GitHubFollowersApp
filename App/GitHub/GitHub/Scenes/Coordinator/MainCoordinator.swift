//
//  MainCoordinator.swift
//  GitHub
//
//  Created by José Victor Pereira Costa on 28/02/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import UIKit
import Core

class MainCoordinator: Coordinator {
    
    // MARK: - Properties
    
    var parent: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController?

    // MARK: - Initializers
    
    /// Create a `MainCoordinator` object  with the given `navigationController`.
    /// The passed navigation controller is setted as `rootViewController` on the passed window.
    /// - Parameters:
    ///   - navigationController: The `UINavigationController` responsible to embed the coordinator's flow
    ///   - window: The host `UIWindow` that holds `navigationController` as  `rootViewController`
    init(navigationController: UINavigationController, window: UIWindow) {
        self.navigationController = navigationController
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Life Cycle
    
    func start() {
        navigateToGetFollowers()
    }
    
    // MARK: - Navigation
    
    private func navigateToGetFollowers() {
        let viewController: GetFollowersViewController = .makeGetFollowers()
        navigationController?.pushViewController(viewController, animated: false)
    }

}

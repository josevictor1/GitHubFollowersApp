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
    
    /// Create a __MainCoordinator__ object  with the given `navigationControlle`r.
    /// The passed navigation controller is setted as `rootViewController` on the passed window
    /// - Parameters:
    ///   - navigationController: The __UINavigationController__ responsible to embed the coordinator's flow
    ///   - window: The host __UIWindow__ that holds `navigationController` as  `rootViewController`
    init(navigationController: UINavigationController, window: UIWindow) {
        self.navigationController = navigationController
        window.rootViewController = GetFollowersViewController()
        window.makeKeyAndVisible()
    }
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Flow life cycle
    
    func start() {
        goToLogin()
    }
    
    // MARK: - Navigation
    
    private func goToLogin() {
        let viewController = GetFollowersViewController()
        viewController.view.backgroundColor = .white
        navigationController?.pushViewController(viewController, animated: false)
    }

}

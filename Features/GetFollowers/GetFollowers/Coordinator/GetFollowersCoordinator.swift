//
//  GetFollowersCoordinator.swift
//  SearchFollowers
//
//  Created by José Victor Pereira Costa on 27/03/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import Foundation
import Commons
import Core
import UIKit

public class GetFollowersCoordinator: NavigationCoordinator {
    
    // MARK: - Properties
    
    public var parent: Coordinator?
    public var children: [Coordinator] = []
    public var navigationController: UINavigationController?
    
    // MARK: - Intitializer
    
    public required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Life Cycle
    
    public func start() {
        navigationController?.setNavigationBarHidden(true, animated: false)
        navigateToGetFollowers()
    }
    
    // MARK: - Navigation
    
    private func navigateToGetFollowers() {
        let viewController: GetFollowersViewController = .makeGetFollowers()
        navigationController?.pushViewController(viewController, animated: false)
    }
    
}

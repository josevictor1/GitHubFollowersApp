//
//  FavoriteProfilesCoordinator.swift
//  FavoriteProfiles
//
//  Created by José Victor Pereira Costa on 01/06/21.
//

import UIKit
import Commons
import Core

public final class FavoriteProfilesCoordinator: NavigationCoordinator {

    public var parent: Coordinator?
    public var children = [Coordinator]()
    public var navigationController: UINavigationController?
    
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    public func start() {
        let favoriteProfilesViewController = FavoriteProfilesTableViewController()
        navigationController?.pushViewController(favoriteProfilesViewController, animated: true)
    }
    
    public func navigateToFavoriteProfiles(with selectedUserInformation: SelectedUserInformation) {
        
    }
}

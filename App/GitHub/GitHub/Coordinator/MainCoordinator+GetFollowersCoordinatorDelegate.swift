//
//  MainCoordinator+.swift
//  GitHub
//
//  Created by José Victor Pereira Costa on 24/02/21.
//  Copyright © 2021 José Victor Pereira Costa. All rights reserved.
//

import Commons
import GetFollowers

extension MainCoordinator: GetFollowersCoordinatorDelegate {
    
    func getFollowersDidOpenUserInformation(withLogin login: String) {
        navigateToUserInformation(withLogin: login)
    }
    
    func getFollowersFavoritedSelectedUser(_ selectedUser: SelectedUserInformation) {
        navigateToFavorites(with: selectedUser)
    }
}

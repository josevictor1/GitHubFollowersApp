//
//  FetFollowersCoordinator+FollowersDelegate.swift
//  GetFollowers
//
//  Created by José Victor Pereira Costa on 21/02/21.
//  Copyright © 2021 José Victor Pereira Costa. All rights reserved.
//

import Commons

protocol FollowersCoordinator {
    func showInformation(for login: String)
    func showFavorites(with selectedUser: SelectedUserInformation)
}

extension GetFollowersCoordinator: FollowersCoordinator {

    func showInformation(for login: String) {
        navigateToUserInformation(with: login)
    }
    
    func showFavorites(with selectedUser: SelectedUserInformation) {
        navigateToFavorites(with: selectedUser)
    }
}

//
//  GetFollowersCoordintaor+SearchCoordinator.swift
//  GetFollowers
//
//  Created by José Victor Pereira Costa on 23/05/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import Commons

extension GetFollowersCoordinator: SearchCoordinator {

    func showUserInformation(_ userFollowers: SelectedUserInformation) {
        navigateToFollowers(with: userFollowers)
    }
}

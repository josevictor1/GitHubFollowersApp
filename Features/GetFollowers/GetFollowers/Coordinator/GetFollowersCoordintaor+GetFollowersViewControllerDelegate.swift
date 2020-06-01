//
//  GetFollowersCoordintaor+GetFollowersViewControllerDelegate.swift
//  GetFollowers
//
//  Created by José Victor Pereira Costa on 23/05/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import Foundation

extension GetFollowersCoordinator: GetFollowersViewControllerDelegate {

    func viewControllerDidGetFollowers(_ userFollowers: UserFollowers) {
        navigateToFollowers(with: userFollowers)
    }
}

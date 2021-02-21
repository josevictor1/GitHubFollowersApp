//
//  FetFollowersCoordinator+FollowersDelegate.swift
//  GetFollowers
//
//  Created by José Victor Pereira Costa on 21/02/21.
//  Copyright © 2021 José Victor Pereira Costa. All rights reserved.
//

import Foundation

extension GetFollowersCoordinator: FollowersCoordinator {
    
    func showInformation(for follower: Follower) {
        navigateToUserInformation(with: follower)
    }
}

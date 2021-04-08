//
//  MainCoordinator+UserInformationDelegate.swift
//  GitHub
//
//  Created by José Victor Pereira Costa on 06/04/21.
//  Copyright © 2021 José Victor Pereira Costa. All rights reserved.
//

import Core
import UserInformation
import GetFollowers

extension MainCoordinator: UserInformationCoordintorDelegate {
    
    func navigateToFollowers(withLogin login: String) {
        let coordinator = children.first(where: { $0 is GetFollowersCoordinator })
        guard let getFollowersCoordinator = coordinator as? GetFollowersCoordinator else { return }
        getFollowersCoordinator.reloadFollowers(withLogin: login)
    }
}

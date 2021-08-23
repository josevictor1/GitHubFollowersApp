//
//  MainCoordinator+UserInformationDelegate.swift
//  GitHub
//
//  Created by José Victor Pereira Costa on 06/04/21.
//  Copyright © 2021 José Victor Pereira Costa. All rights reserved.
//

import Core
import Commons
import UserInformation
import GetFollowers

extension MainCoordinator: UserInformationCoordinatorDelegate {
    
    func userInformationDidSelectUser(_ selectedUserInformation: SelectedUserInformation) {
        navigateToFollowers(with: selectedUserInformation)
    }
}

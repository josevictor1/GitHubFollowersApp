//
//  FollowersBuilderMock.swift
//  GetFollowers
//
//  Created by José Victor Pereira Costa on 12/07/21.
//  Copyright © 2021 José Victor Pereira Costa. All rights reserved.
//

import Commons
import UIComponents

struct FollowersBuilderMock: FollowersBuilderProtocol {
    
    func followers(selectedUserInformation: SelectedUserInformation,
                   coordinator: FollowersCoordinator) -> FollowersCollectionViewController {
        let presenter = GetFollowersErrorAlertPresenter()
        let paginationController = PaginationController(numberOfItems: selectedUserInformation.numberOfFollowers)
        let logicController = FollowersLogicController(userFollowers: selectedUserInformation,
                                                       paginationController: paginationController)
        let viewController = FollowersCollectionViewController(logicController: logicController,
                                                               presenter: presenter,
                                                               coordinator: coordinator)
        presenter.configureAlert(to: viewController)
        return viewController
    }
}

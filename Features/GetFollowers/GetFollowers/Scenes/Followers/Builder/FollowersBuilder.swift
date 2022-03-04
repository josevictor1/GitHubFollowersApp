//
//  FollowersBuilder.swift
//  GetFollowers
//
//  Created by José Victor Pereira Costa on 11/07/21.
//  Copyright © 2021 José Victor Pereira Costa. All rights reserved.
//

import Commons
import UIComponents

protocol FollowersBuilderProtocol {
    func followers(selectedUserInformation: SelectedUserInformation,
                   coordinator: FollowersCoordinator) -> FollowersCollectionViewController
}

struct FollowersBuilder: FollowersBuilderProtocol {
    
    func followers(selectedUserInformation: SelectedUserInformation,
                   coordinator: FollowersCoordinator) -> FollowersCollectionViewController {
        let presenter = GetFollowersErrorAlertPresenter()
        let configurator = FollowersCollectionViewConfigurator()
        let paginationController = PaginationController(numberOfItems: selectedUserInformation.numberOfFollowers)
        let logicController = FollowersLogicController(userFollowers: selectedUserInformation,
                                                       paginationController: paginationController)
        let viewController = FollowersCollectionViewController(logicController: logicController,
                                                               configurator: configurator,
                                                               presenter: presenter,
                                                               coordinator: coordinator)
        logicController.viewController = viewController
        presenter.configureAlert(to: viewController)
        return viewController
    }
}

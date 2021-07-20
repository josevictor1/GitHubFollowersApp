//
//  GetFollowersBuilder.swift
//  GetFollowers
//
//  Created by José Victor Pereira Costa on 30/06/21.
//  Copyright © 2021 José Victor Pereira Costa. All rights reserved.
//

import UIComponents
import Commons

protocol GetFollowersBuilderProtocol {
    func makeGetFollowersViewController(delegate: SearchCoordinator) -> GetFollowersViewController
}

struct GetFollowersBuilder: GetFollowersBuilderProtocol {
    
    func makeGetFollowersViewController(delegate: SearchCoordinator) -> GetFollowersViewController {
        let view = GetFollowersView()
        let presenter = GetFollowersErrorAlertPresenter()
        let logicController = GetFollowersLogicController()
        let viewController = GetFollowersViewController(view: view,
                                                        logicController: logicController,
                                                        presenter: presenter,
                                                        delegate: delegate,
                                                        keyboardObserver: KeyboardObserver())
        view.delegate = viewController
        presenter.configureAlert(to: viewController)
        return viewController
    }
}

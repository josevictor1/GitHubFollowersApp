//
//  UserInfromationFactory.swift
//  UserInformation
//
//  Created by José Victor Pereira Costa on 31/03/21.
//  Copyright © 2021 José Victor Pereira Costa. All rights reserved.
//

import UIComponents
import UIKit

protocol UserInformationFactoryProtocol {
    static func makeUserInformation(with login: String,
                                    coordinator: UserInformationCoordinatorProtocol) -> UserInformationCollectionViewController
}

struct UserInformationFactory: UserInformationFactoryProtocol {
    
    static func makeUserInformation(with login: String,
                                    coordinator: UserInformationCoordinatorProtocol) -> UserInformationCollectionViewController {
        let viewController = UserInformationCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
        viewController.coordinator = coordinator
        let configurator = UserInformationConfiguratorController(delegate: viewController)
        let collectionViewCellProvider = UserInformationCellProvider(configurator: configurator)
        viewController.cellProvider = collectionViewCellProvider
        let logicController = UserInformationLogicController(login: login,
                                                             viewController: viewController)
        viewController.logicController = logicController
        let presenter = GetFollowersErrorAlertPresenter()
        presenter.configureAlert(to: viewController)
        viewController.presenter = presenter
        return viewController
    }
}

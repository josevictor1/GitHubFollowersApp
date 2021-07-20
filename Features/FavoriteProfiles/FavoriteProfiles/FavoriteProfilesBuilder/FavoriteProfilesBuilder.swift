//
//  FavoriteProfilesBuilder.swift
//  FavoriteProfiles
//
//  Created by José Victor Pereira Costa on 02/06/21.
//  Copyright © 2021 José Victor Pereira Costa. All rights reserved.
//

import Foundation

protocol FavoriteProfilesBuilderProtocol {
    func makeFavoriteProfilesViewController() -> FavoriteProfilesTableViewController
}

struct FavoriteProfileBuilder: FavoriteProfilesBuilderProtocol {
    
    func makeFavoriteProfilesViewController() -> FavoriteProfilesTableViewController {
        let favoriteProfilesLogicController = FavoriteProfilesLogicController()
        let tableViewController = FavoriteProfilesTableViewController(logicController: favoriteProfilesLogicController)
        favoriteProfilesLogicController.viewController = tableViewController
        return tableViewController
    }
}

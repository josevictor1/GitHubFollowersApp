//
//  GetFollowersCoordinator.swift
//  SearchFollowers
//
//  Created by José Victor Pereira Costa on 27/03/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import Foundation
import Commons
import Core
import UIKit

public final class GetFollowersCoordinator: NavigationCoordinator {
    public var parent: Coordinator?
    public var children: [Coordinator] = []
    public var navigationController: UINavigationController?

    public required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    public func start() {
        navigateToGetFollowers()
        setUpNavigationLayout()
    }

    private func setUpNavigationLayout() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .chateauGreen
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    func navigateToGetFollowers() {
        let viewController: GetFollowersViewController = .makeGetFollowers(delegate: self)
        navigationController?.pushViewController(viewController, animated: false)
    }

    func navigateToFollowers(with userFollowers: UserInformation) {
        let viewController: FollowersViewController = .makeFollowers(with: userFollowers)
        navigationController?.pushViewController(viewController, animated: true)
    }
}

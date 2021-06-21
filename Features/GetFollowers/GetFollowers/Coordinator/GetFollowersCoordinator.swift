//
//  GetFollowersCoordinator.swift
//  SearchFollowers
//
//  Created by José Victor Pereira Costa on 27/03/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import Commons
import Core
import UIKit

public protocol GetFollowersCoordinatorDelegate: AnyObject {
    func getFollowersDidOpenUserInformation(withLogin login: String)
    func getFollowersFavoritedSelectedUser(_ selectedUser: SelectedUserInformation)
}

public final class GetFollowersCoordinator: NavigationCoordinator {
    
    public var parent: Coordinator?
    public var children: [Coordinator] = []
    public var navigationController: UINavigationController?
    public weak var delegate: GetFollowersCoordinatorDelegate?

    public required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    public func start() {
        navigateToGetFollowers()
        setUpNavigationLayout()
    }
    
    public func reloadFollowers(with selectedUserInformation: SelectedUserInformation) {
        let viewController: FollowersCollectionViewController = .makeFollowers(with: selectedUserInformation,
                                                                               coordinator: self)
        reloadNavigationControllerStack(with: viewController)
    }
    
    private func reloadNavigationControllerStack(with viewController: UIViewController) {
        guard let getFollowerViewController = navigationController?.viewControllers.first else { return }
        navigationController?.setViewControllers([getFollowerViewController, viewController], animated: true)
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

    func navigateToFollowers(with selectedUserInformation: SelectedUserInformation) {
        let viewController: FollowersCollectionViewController = .makeFollowers(with: selectedUserInformation,
                                                                               coordinator: self)
        navigationController?.pushViewController(viewController, animated: true)
    }

    func navigateToUserInformation(with follower: String) {
        delegate?.getFollowersDidOpenUserInformation(withLogin: follower)
    }
    
    func navigateToFavories(with selectedUser: SelectedUserInformation) {
        delegate?.getFollowersFavoritedSelectedUser(selectedUser)
    }
}

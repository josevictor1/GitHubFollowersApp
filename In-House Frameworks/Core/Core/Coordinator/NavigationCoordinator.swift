//
//  NavigationCoordinator.swift
//  Core
//
//  Created by José Victor Pereira Costa on 27/03/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import UIKit

public protocol NavigationCoordinator: Coordinator {

    // MARK: - Initializers

    /// Creates a Coordinator with the given navigationController.
    /// - Parameter navigationController: The `UINavigationController` responsible to embed the coordinator's flow.
    init(navigationController: UINavigationController)

    // MARK: - Properties

    /// The `UINavigationController` responsible to embed the coordinator's flow.
    var navigationController: UINavigationController? { get set }

}

public extension NavigationCoordinator {

    /// Create an `NavigationCoordinator` object with an default `navigationController` and set `nil` .
    /// - Parameters:
    ///   - navigationController: The navigation controller responsible to embed the flow.
    ///   - parent: The parent coordinator.
    /// - Returns: A concret instance of `NavigationCoordinator`.
    static func instantiate(navigationController: UINavigationController = UINavigationController(),
                            parent: Coordinator? = nil) -> Self {
        let coordinator = Self.init(navigationController: navigationController)
        parent?.children.append(coordinator)
        return coordinator
    }
}

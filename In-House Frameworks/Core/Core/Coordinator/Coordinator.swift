//
//  Coordinator.swift
//  Core
//
//  Created by José Victor Pereira Costa on 26/02/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import UIKit

public protocol Coordinator: AnyObject {

    // MARK: - Properties

    /// The  reference to the parent coordinator.
    var parent: Coordinator? { get set }

    /// The children coordinators.
    var children: [Coordinator] { get set }

    // MARK: - Life Cycle

    /// Start the coordinator flow doing all the necessary configuration.
    func start()
}

public extension Coordinator {

    /// Remove child coordinator.
    /// - Parameter child: Coordinator to be removed from children.
    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in children.enumerated()
            where coordinator === child {
                children.remove(at: index)
                break
        }
    }
}

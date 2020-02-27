//
//  Coordinator.swift
//  Core
//
//  Created by José Victor Pereira Costa on 26/02/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import UIKit

protocol Coordinator {
    
    // MARK: - Initializers
    
    /// Creates a new Coordinator with the given navigationController
    /// - Parameter navigationController: The __UINavigationController__ responsible to embed the coordinator's flow
    init(navigationController: UINavigationController)
    
    // MARK: - Properties
    
    /// The  reference to the parent coordinator
    var parent: Coordinator? { get set }
    
    /// The children coordinators
    var children: [Coordinator]? { get set }
    
    /// The __UINavigationController__ responsible to embed the coordinator's flow
    var navigationController: UINavigationController? { get set }
    
    // MARK: - Life Cycle
    
    /// Start the coordinator flow
    func start()
    
    /// <#Description#>
    func childDidFinish()
}

extension Coordinator {
    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                children.remove(at: index)
                break
            }
        }
    }
}

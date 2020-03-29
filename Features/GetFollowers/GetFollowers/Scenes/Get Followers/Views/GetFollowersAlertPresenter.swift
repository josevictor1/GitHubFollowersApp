//
//  GetFollowers.swift
//  GitHub
//
//  Created by José Victor Pereira Costa on 26/03/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import UIKit
import UIComponents

protocol GetFollowersAlertPresenterProtocol {
    
    /// Present an alert with the passed error.
    /// - Parameter error: Error to be presented.
    func present(_ error: GetFollowersError)
}

class GetFollowersAlertPresenter: GetFollowersAlertPresenterProtocol {
    
    // MARK: - Properties
    
    private let presentingViewController: UIViewController
    private weak var alertController: UIViewController?
    
    // MARK: - Initializer
    
    init(viewController: UIViewController) {
        presentingViewController = viewController
    }
    
    // MARK: - Presentation
    
    private func alert(to error: GetFollowersError) -> Alert {
        let title = "Something went wrong"
        let description = error.message.localizedMessage
        let buttonTitle = "Ok"

        return Alert(title: title, description: description, buttonTitle: buttonTitle)
    }
    
    
    /// Present an alert over current context.
    /// - Parameter error: The error message to be presented.
    func present(_ error: GetFollowersError) {
        let viewController = CustomAlertController(alert: alert(to: error)) { [unowned self]  in
            self.alertController?.dismiss(animated: true)
        }
        
        alertController = viewController
        
        if let navigationController = presentingViewController.navigationController {
            navigationController.present(viewController, animated: true)
        } else {
            presentingViewController.present(viewController, animated: true)
        }
    }
    
}

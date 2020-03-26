//
//  GetFollowers.swift
//  GitHub
//
//  Created by José Victor Pereira Costa on 26/03/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import UIKit
import UIComponents

class GetFollowersAlertPresenter {
    
    private let presentingViewController: UIViewController
    private weak var alertController: UIViewController?
    
    init(viewController: UIViewController) {
        presentingViewController = viewController
    }
    
    private func alert(to error: GetFollowersError) -> Alert {
        let title = "Something went wrong"
        let description = error.errorMessage.localizedMessage
        let buttonTitle = "Ok"
        
        return Alert(title: title, description: description, buttonTitle: buttonTitle)
    }
    
    
    func present(_ error: GetFollowersError) {
        let viewController = CustomAlertController(alert: alert(to: error)) { [unowned self]  in
            self.alertController?.dismiss(animated: true)
        }
        alertController = viewController
        presentingViewController.present(viewController, animated: true)
    }
    
}

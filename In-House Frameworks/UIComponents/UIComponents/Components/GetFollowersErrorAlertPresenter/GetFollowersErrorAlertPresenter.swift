//
//  GetFollowers.swift
//  GitHub
//
//  Created by José Victor Pereira Costa on 26/03/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import UIKit
import Commons

public protocol GetFollowersErrorAlertPresenterProtocol {
    func present(_ error: GetFollowersError)
    func configureAlert(to presentingViewController: UIViewController)
}

public final class GetFollowersErrorAlertPresenter: GetFollowersErrorAlertPresenterProtocol {
    private weak var presentingViewController: UIViewController?
    private weak var alertViewController: UIViewController?
    
    public init() {}
    
    public func configureAlert(to presentingViewController: UIViewController) {
        self.presentingViewController = presentingViewController
    }
    
    private func makeAlert(for error: GetFollowersError) -> Alert {
        let title = Localizable.somethingWentWrong.localized
        let description = error.message.localizedMessage
        let buttonTitle = Localizable.ok.localized
        return Alert(title: title, description: description, buttonTitle: buttonTitle)
    }
    
    public func present(_ error: GetFollowersError) {
        let alertViewController = makeAlertController(for: error)
        self.alertViewController = alertViewController
        present(alertViewController)
    }
    
    private func makeAlertController(for error: GetFollowersError) -> UIViewController {
        CustomAlertController(alert: makeAlert(for: error)) { [unowned self]  in
            self.alertViewController?.dismiss(animated: true)
        }
    }
    
    private func present(_ viewController: UIViewController) {
        if let presentingViewController = presentingViewController,
           let navigationController = presentingViewController.navigationController {
            navigationController.present(viewController, animated: true)
        } else {
            presentingViewController?.present(viewController, animated: true)
        }
    }
}

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

    func configureAlert(to presentingViewController: UIViewController)
}

class GetFollowersAlertPresenter: GetFollowersAlertPresenterProtocol {

    // MARK: - Properties

    private weak var presentingViewController: UIViewController?
    private weak var alertController: UIViewController?

    // MARK: - Configuration

    func configureAlert(to presentingViewController: UIViewController) {
        self.presentingViewController = presentingViewController
    }

    // MARK: - Presentation

    private func alert(to error: GetFollowersError) -> Alert {
        let title = LocalizedStrings.somethingWentWrong.localized
        let description = error.message.localizedMessage
        let buttonTitle = LocalizedStrings.ok.localized
        return Alert(title: title, description: description, buttonTitle: buttonTitle)
    }

    /// Present an alert over current context.
    /// - Parameter error: The error message to be presented.
    func present(_ error: GetFollowersError) {
        let viewController = CustomAlertController(alert: alert(to: error)) { [unowned self]  in
            self.alertController?.dismiss(animated: true)
        }

        alertController = viewController

        if let presentingViewController = presentingViewController,
            let navigationController = presentingViewController.navigationController {
            navigationController.present(viewController, animated: true)
        } else {
            presentingViewController?.present(viewController, animated: true)
        }
    }
}

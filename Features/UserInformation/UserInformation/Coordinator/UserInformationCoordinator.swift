//
//  UserInfromationCoordinator.swift
//  UserInformation
//
//  Created by José Victor Pereira Costa on 24/02/21.
//

import Core
import Commons
import UIKit
import SafariServices
import MessageUI

protocol UserInformationCoordinatorProtocol {
    func navigateToPage(withURL url: URL)
    func navigateToEmail(withAddress emailAddress: String)
    func navigateToFollowers(with selectedUserInformation: SelectedUserInformation)
}

public protocol UserInformationCoordintorDelegate: AnyObject {
    func navigateToFollowers(with selectedUserInformation: SelectedUserInformation)
}

public final class UserInformationCoordinator: NavigationCoordinator {
    public var parent: Coordinator?
    public var children: [Coordinator] = []
    public var navigationController: UINavigationController?
    public weak var delegate: UserInformationCoordintorDelegate?

    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    public func start() {
        setUpNavigationControllerLayout()
    }

    private func setUpNavigationControllerLayout() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .chateauGreen
        navigationController?.modalPresentationStyle = .popover
    }

    public func navigateToUserInformation(withLogin login: String) {
        let viewController = UserInformationFactory.makeUserInformation(with: login,
                                                                        coordinator: self)
        navigationController?.setViewControllers([viewController], animated: false)
    }
}

extension UserInformationCoordinator: UserInformationCoordinatorProtocol {
    
    func navigateToPage(withURL url: URL) {
        let safariViewController = SFSafariViewController(url: url)
        navigationController?.pushViewController(safariViewController, animated: true)
    }
    
    func navigateToEmail(withAddress emailAddress: String) {
        guard MFMailComposeViewController.canSendMail() else { return }
        let emailController = makeEmail(toAddress: emailAddress)
        navigationController?.pushViewController(emailController, animated: true)
    }
    
    func navigateToFollowers(with selectedUserInformation: SelectedUserInformation) {
        navigationController?.dismiss(animated: true) { [unowned self] in
            self.delegate?.navigateToFollowers(with: selectedUserInformation)
        }
    }
    
    private func makeEmail(toAddress emailAddress: String) -> MFMailComposeViewController {
        let email = MFMailComposeViewController()
        email.setToRecipients([emailAddress])
        return email
    }
}

extension UserInformationCollectionViewController: MFMailComposeViewControllerDelegate {
    
    func mailComposeController(_ controller: MFMailComposeViewController,
                               didFinishWith result: MFMailComposeResult,
                               error: Error?) {
        navigationController?.popViewController(animated: true)
    }
}

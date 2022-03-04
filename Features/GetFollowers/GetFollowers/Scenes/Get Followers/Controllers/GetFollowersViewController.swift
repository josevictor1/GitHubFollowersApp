//
//  GetFollowersViewController.swift
//  GitHub
//
//  Created by José Victor Pereira Costa on 26/02/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import UIKit
import Commons
import UIComponents

protocol SearchCoordinator: AnyObject {
    func showUserInformation(_ userInformation: SelectedUserInformation)
}

protocol GetFollowersViewControllerInput {
    func viewController(didSelectFollower selectedFollower: String)
}

final class GetFollowersViewController: UIViewController {
    
    private unowned let coordinator: SearchCoordinator
    private let getFollowersView: GetFollowersViewProtocol
    private let logicController: GetFollowersLogicControllerProtocol
    private let presenter: GetFollowersErrorAlertPresenterProtocol
    private let keyboardObserver: KeyboardObserverProtocol
    
    init(view: GetFollowersViewProtocol,
         logicController: GetFollowersLogicControllerProtocol,
         presenter: GetFollowersErrorAlertPresenterProtocol,
         delegate: SearchCoordinator,
         keyboardObserver: KeyboardObserverProtocol) {
        getFollowersView = view
        self.logicController = logicController
        self.presenter = presenter
        self.coordinator = delegate
        self.keyboardObserver = keyboardObserver
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = getFollowersView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpKeyboardObserver()
    }
    
    private func fetchUser(with username: String?) {
        guard let username = username, !username.isEmpty else { return }
        startLoading()
        logicController.fetchUserInformation(for: username) { [unowned self] result in
            switch result {
            case .success(let user):
                self.coordinator.showUserInformation(user)
            case .failure(let error):
                self.presenter.present(error)
            }
            self.stopLoading()
        }
    }
    
    private func setUpKeyboardObserver() {
        keyboardObserver.onKeyboardAppeared = { [unowned self] notification in
            let rect = notification.keyboardFrame(for: self.view)
            self.getFollowersView.scrollUpGetFollowersButton(at: rect.height)
        }
        keyboardObserver.onKeyboardDisappeared = { [unowned self] _ in
            self.getFollowersView.scrollUpGetFollowersButton(at: .zero)
        }
    }
}

extension GetFollowersViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}

extension GetFollowersViewController: GetFollowersViewControllerInput {
    
    func viewController(didSelectFollower selectedFollower: String) {
        fetchUser(with: selectedFollower)
    }
}

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
    func showUserInformation(_ userInformation: UserInformation)
}

protocol GetFollowersViewControllerInput {
    func viewController(didSelectFollower selectedFollower: String)
}

final class GetFollowersViewController: UIViewController {
    private(set) var logicController: GetFollowersLogicControllerProtocol?
    private(set) var presenter: GetFollowersAlertPresenterProtocol?
    private(set) weak var delegate: SearchCoordinator?
    private let keyboardObserver: KeyboardObserverProtocol
    private let getFollowersView: GetFollowersViewProtocol
    
    init(view: GetFollowersViewProtocol, keyboardObserver: KeyboardObserverProtocol) {
        getFollowersView = view
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
        logicController?.fetchUserInformation(for: username) { [unowned self] result in
            switch result {
            case .success(let user):
                self.delegate?.showUserInformation(user)
            case .failure(let error):
                self.presenter?.present(error)
            }
            self.stopLoading()
        }
    }
    
    private func setUpKeyboardObserver() {
        keyboardObserver.onKeyboardAppeared = { [unowned self] notification in
            let rect = notification.keyboardFrame(for: self.view)
            self.getFollowersView.scrollUpGetFollowersButton(at: rect.height)
        }
        keyboardObserver.onKeyboardDisappeared = { [unowned self] notification in
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

extension GetFollowersViewController {
    
    static func makeGetFollowers(view: GetFollowersViewProtocol = GetFollowersView(),
                                 delegate: SearchCoordinator,
                                 presenter: GetFollowersAlertPresenterProtocol = GetFollowersErrorAlertPresenter(),
                                 logicController: GetFollowersLogicControllerProtocol = GetFollowersLogicController(),
                                 keyboardObserver: KeyboardObserverProtocol = KeyboardObserver()) -> GetFollowersViewController {
        
        let viewController = GetFollowersViewController(view: view, keyboardObserver: keyboardObserver)
        view.delegate = viewController
        viewController.presenter = presenter
        viewController.logicController = logicController
        viewController.delegate = delegate
        presenter.configureAlert(to: viewController)
        return viewController
    }
}

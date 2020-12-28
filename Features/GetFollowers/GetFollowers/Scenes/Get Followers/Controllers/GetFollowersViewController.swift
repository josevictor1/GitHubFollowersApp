//
//  GetFollowersViewController.swift
//  GitHub
//
//  Created by José Victor Pereira Costa on 26/02/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import UIKit
import Commons

protocol GetFollowersViewControllerDelegate: AnyObject {
    func viewControllerDidGetFollowers(_ userFollowers: UserFollowers)
}

final class GetFollowersViewController: UIViewController {
    
    private(set) var logicController: GetFollowersLogicControllerProtocol?
    private(set) var presenter: GetFollowersAlertPresenterProtocol?
    private let keyboardObserver = KeyboardObserver()
    private(set) weak var delegate: GetFollowersViewControllerDelegate?
    
    private lazy var getFollowersView: GetFollowersView = {
        let view = GetFollowersView()
        view.onGetFollowersButtonTapped = onGetFollowersButtonTapped
        view.set(textFieldDelegate: self)
        return view
    }()
    
    private lazy var onGetFollowersButtonTapped: (String?) -> Void = { [unowned self] username in
        self.fetchUser(with: username)
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
        logicController?.getFollowers(of: username) { [unowned self] result in
            switch result {
            case .success(let followers):
                let userFollowers = UserFollowers(username: username, followers: followers)
                self.delegate?.viewControllerDidGetFollowers(userFollowers)
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

// MARK: - UITextFieldDelegate

extension GetFollowersViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}

// MARK: - Factory

extension GetFollowersViewController {
    
    static func makeGetFollowers(delegate: GetFollowersViewControllerDelegate,
                                 presenter: GetFollowersAlertPresenterProtocol = GetFollowersAlertPresenter(),
                                 logicController: GetFollowersLogicControllerProtocol = GetFollowersLogicController()) -> GetFollowersViewController {
        
        let viewController = GetFollowersViewController()
        viewController.presenter = presenter
        viewController.logicController = logicController
        viewController.delegate = delegate
        presenter.configureAlert(to: viewController)
        return viewController
    }
}

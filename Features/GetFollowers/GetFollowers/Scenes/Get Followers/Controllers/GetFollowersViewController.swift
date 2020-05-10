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

    /// Method called when `GetFollowersViewController` finishes to fetch users.
    /// - Parameter user: User fetched
    func viewControllerDidGotFollowers(_ followers: [Follower])
}

class GetFollowersViewController: UIViewController {

    // MARK: - Properties

    private var logicController: GetFollowersLogicProtocol?
    private var presenter: GetFollowersAlertPresenterProtocol?
    private let keyboardObserver = KeyboardObserver()
    private weak var delegate: GetFollowersViewControllerDelegate?
    
    // MARK: - Subviews
    
    private lazy var getFollowersView: GetFollowersView = {
        let view = GetFollowersView()
        view.onGetFollowersButtonTapped = onGetFollowersButtonTapped
        view.setTextFieldDelegate(self)
        return view
    }()

    // MARK: - Actions

    lazy var onGetFollowersButtonTapped: ((String?) -> Void) = { [unowned self] username in
        self.fetchUser(with: username)
    }

    // MARK: - Life Cycle

    override func loadView() {
        super.loadView()
        view = getFollowersView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpKeyboardObserver()
    }

    // MARK: - Business Logic

    private func fetchUser(with username: String?) {
        
        guard let username = username, !username.isEmpty else { return }
        
        logicController?.getFollowers(of: username) { [unowned self] result in
            switch result {
            case .success(let followers):
                self.delegate?.viewControllerDidGotFollowers(followers)
            case .failure(let error):
                self.presenter?.present(error)
            }
        }
    }
    
    // MARK: - View Logic
    
    private func setUpKeyboardObserver() {
        keyboardObserver.onKeyboardAppeared = { [unowned self] notification in
            self.setUpButtonHeight(with: notification)
        }
        keyboardObserver.onKeyboardDisappearerd = { [unowned self] notification in
            self.getFollowersView.scrollUpGetFollowersButton(at: .zero)
        }
    }
    
    private func setUpButtonHeight(with keyboardNotification: Notification)  {
        
        guard let userInfo = keyboardNotification.userInfo,
            let keyboardValue = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        
        getFollowersView.scrollUpGetFollowersButton(at: keyboardViewEndFrame.height)
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

    static func makeGetFollowers() -> GetFollowersViewController {
        let viewController = GetFollowersViewController()
        viewController.presenter = GetFollowersAlertPresenter(viewController: viewController)
        return viewController
    }
}

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
    func viewControllerDidFetchUser(_ user: String)
}

class GetFollowersViewController: UIViewController {
    
    // MARK: - Properties
    
    var modelController: GetFollowersModel?
    weak var delegate: GetFollowersViewControllerDelegate?
    
    lazy var onGetFollowersButtonTapped: ((String) -> Void) = { [unowned self] username in
        self.fetchUser(with: username)
    }
    
    lazy var getFollowersView: GetFollowersView = {
        let view = GetFollowersView()
        view.getFollowersButtonTapped = onGetFollowersButtonTapped
        return view
    }()
    
    // MARK: - Life Cycle
    
    override func loadView() {
        super.loadView()
        view = getFollowersView
    }
    
    private func fetchUser(with username: String) {
        modelController?.fetchUser(with: username) { [unowned self] result in
            switch result {
            case .success(let username):
                self.delegate?.viewControllerDidFetchUser(username)
            case .failure(let error):
                break
            }
        }
    }
    
}


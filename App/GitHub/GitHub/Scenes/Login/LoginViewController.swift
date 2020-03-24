//
//  ViewController.swift
//  GitHub
//
//  Created by José Victor Pereira Costa on 26/02/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import UIKit
import Commons

protocol LoginService {
    func singUp(with user: String)
}

class LoginViewController: UIViewController {
    
    // MARK: - Properties
    
    var service: LoginService?
    
    lazy var onGetFollowersButtonTapped: ((String) -> Void) = { [unowned self] userName in
        self.service?.singUp(with: userName)
    }
    
    lazy var loginView: LoginView = {
        let view = LoginView()
        view.getFollowersButtonTapped = onGetFollowersButtonTapped
        return view
    }()
    
    // MARK: - Life Cycle
    
    override func loadView() {
        super.loadView()
        view = loginView
    }
    
}


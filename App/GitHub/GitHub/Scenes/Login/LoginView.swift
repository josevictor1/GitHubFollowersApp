//
//  LoginView.swift
//  GitHub
//
//  Created by José Victor Pereira Costa on 29/02/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import UIKit

final class LoginView: UIView {
    
    // MARK: - Actions clojures
    
    private var getFollowersButtonTapped: ((String) -> Void)?
    
    // MARK: - Initializers
    
    init(getFollowersButtonDidTap: @escaping((String) -> Void)) {
        super.init(frame: UIScreen.main.bounds)
        self.getFollowersButtonTapped = getFollowersButtonDidTap
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Properties
    
    private lazy var logoImage: UIImageView = {
        let image = UIImage(named: "gh-logo-dark")!
        let imageView = UIImageView(image: image)
        return imageView
    }()
    
    private lazy var usernameTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Enter Username"
        return textField
    }()
    private lazy var getFollowersButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.text = "Get Follewrs"
        return button
    }()
    
    private func setUp() {
        setUpLogoImageView()
    }
    
    private func setUpLogoImageView() {
        addSubview(logoImage)

    }
    
}

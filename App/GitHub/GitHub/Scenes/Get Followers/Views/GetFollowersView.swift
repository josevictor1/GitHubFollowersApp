//
//  GetFollowersView.swift
//  GitHub
//
//  Created by José Victor Pereira Costa on 29/02/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import UIKit

public final class GetFollowersView: UIView {
    
    // MARK: - Action closures
    
    var getFollowersButtonTapped: ((String) -> Void)?
    
    // MARK: - Initializers
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Subviews
    
    private lazy var logoImage: UIImageView = {
        let image = UIImage(named: "gh-logo")!
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var usernameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Username"
        textField.textAlignment = .center
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 12
        textField.layer.borderColor = UIColor.tertiarySystemFill.cgColor
        textField.backgroundColor = .secondarySystemBackground
        textField.font = .preferredFont(forTextStyle: .body)
        textField.adjustsFontForContentSizeCategory = true
        textField.layer.masksToBounds = true
        return textField
    }()
    
    private lazy var getFollowersButton: UIButton = {
        let button = UIButton()
        button.setTitle("Get Followers", for: .normal)
        button.titleLabel?.font = .preferredFont(forTextStyle: .body)
        button.titleLabel?.adjustsFontForContentSizeCategory = true
        button.titleLabel?.baselineAdjustment = .alignCenters
        button.backgroundColor = UIColor(red: 45/255,
                                         green: 186/255,
                                         blue: 78/255,
                                         alpha: 1)
        button.layer.cornerRadius = 12
        return button
    }()
    
    
    // MARK: - Constraints setup
    
    func setUp() {
        setUpLogoImageView()
        setUpUsernameTextField()
        setUpGetFollowersButton()
        backgroundColor = .systemBackground
    }
    
    private func setUpLogoImageView() {
        let constraints = [logoImage.topAnchor.constraint(equalTo: topAnchor, constant: 70),
                           logoImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 77),
                           logoImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -77),
                           logoImage.heightAnchor.constraint(lessThanOrEqualToConstant: 200)]
        place(logoImage, with: constraints)
    }
    
    private func setUpUsernameTextField() {
        let constraints = [usernameTextField.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 53),
                           usernameTextField.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor, constant: 31),
                           usernameTextField.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor, constant: -31),
                           usernameTextField.heightAnchor.constraint(greaterThanOrEqualToConstant: 62)]
        place(usernameTextField, with: constraints)
    }
    
    private func setUpGetFollowersButton() {
        let constraints = [getFollowersButton.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor, constant: 31),
                           getFollowersButton.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor, constant: -31),
                           getFollowersButton.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor, constant: -31),
                           getFollowersButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 62),
                           getFollowersButton.topAnchor.constraint(greaterThanOrEqualTo: usernameTextField.bottomAnchor, constant: 10)]
        place(getFollowersButton, with: constraints)
    }
    
}

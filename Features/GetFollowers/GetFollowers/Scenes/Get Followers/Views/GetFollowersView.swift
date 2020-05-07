//
//  GetFollowersView.swift
//  GitHub
//
//  Created by José Victor Pereira Costa on 29/02/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import UIKit
import Commons

public final class GetFollowersView: UIView {
    
    // MARK: - Properties
    
    private var bottomButtonConstraint: NSLayoutConstraint?
    
    // MARK: - Closures
    
    var onGetFollowersButtonTapped: ((String?) -> Void)?
    
    // MARK: - Initializers
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Subviews
    
    private lazy var logoImageView: UIImageView = {
        let image = Assets.localizable(image: ImagesAssets.getFollowersLogo)
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var usernameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = Assets.localizable(string: LocalizedStrings.enterUsername,
                                                   in: Bundle(for: Self.self))
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
        button.titleLabel?.numberOfLines = .zero
        button.titleLabel?.font = .preferredFont(forTextStyle: .body)
        button.titleLabel?.adjustsFontForContentSizeCategory = true
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = UIColor(red: 45/255,
                                         green: 186/255,
                                         blue: 78/255,
                                         alpha: 1)
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(getFollowersButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.addArrangedSubview(logoImageView)
        stackView.addArrangedSubview(usernameTextField)
        return stackView
    }()
    
    // MARK: - Actions
    
    @objc private func getFollowersButtonTapped() {
        onGetFollowersButtonTapped?(usernameTextField.text)
    }
    
    // MARK: - Setup
    
    private func setUp() {
        setUpSatckView()
        setUpLogoImageView()
        setUpUsernameTextField()
        setUpGetFollowersButton()
        backgroundColor = .systemBackground
    }
    
    // MARK: - Constraints
    
    private func setUpLogoImageView() {
        logoImageView.heightAnchor.constraint(lessThanOrEqualToConstant: 200).isActive = true
    }
    
    private func setUpUsernameTextField() {
        usernameTextField.heightAnchor.constraint(equalToConstant: 62).isActive = true
    }
    
    private func setUpSatckView() {
        let constraints = [stackView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: 70),
                           stackView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor, constant: 31),
                           stackView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor, constant: -31)
        ]
        place(stackView, with: constraints)
    }
    
    private func setUpGetFollowersButton() {
        let constraints = [getFollowersButton.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor,
                                                                       constant: 31),
                           getFollowersButton.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor,
                                                                        constant: -31),
                           getFollowersButton.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor,
                                                                      constant: -31),
                           getFollowersButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 62),
                           getFollowersButton.topAnchor.constraint(greaterThanOrEqualTo: stackView.bottomAnchor,
                                                                   constant: 10)]
        place(getFollowersButton, with: constraints)
    }
    
}

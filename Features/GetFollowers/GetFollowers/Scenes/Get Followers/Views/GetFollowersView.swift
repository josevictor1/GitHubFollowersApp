//
//  GetFollowersView.swift
//  GitHub
//
//  Created by José Victor Pereira Costa on 29/02/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import UIKit
import Commons

protocol GetFollowersViewProtocol: UIView {
    var delegate: GetFollowersViewDelegate? { get set }
    func scrollUpGetFollowersButton(at height: CGFloat)
}

typealias GetFollowersViewDelegate = GetFollowersViewControllerInput & UITextFieldDelegate

final class GetFollowersView: UIView, GetFollowersViewProtocol {
    private var bottomButtonConstraint: NSLayoutConstraint?
    private let cornerRadius: CGFloat = 12
    private let smallPadding: CGFloat = 10
    private let mediumPadding: CGFloat = 31
    private let largePadding: CGFloat = 62
    private let extraLargePadding: CGFloat = 200

    weak var delegate: GetFollowersViewDelegate? {
        didSet { usernameTextField.delegate = delegate }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
    }

    private let logoImageView: UIImageView = {
        let imageAsset: ImagesAssets = .getFollowersLogo
        let image = UIImage(named: imageAsset.rawValue)
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var usernameTextField: UITextField = {
        let textField = UITextField()
        let placeholder: LocalizedStrings = .enterUsername
        textField.placeholder = placeholder.localized
        textField.textAlignment = .center
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = cornerRadius
        textField.layer.borderColor = UIColor.tertiarySystemFill.cgColor
        textField.returnKeyType = .done
        textField.backgroundColor = .secondarySystemBackground
        textField.font = .preferredFont(forTextStyle: .body)
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.adjustsFontForContentSizeCategory = true
        textField.layer.masksToBounds = true
        return textField
    }()

    private lazy var getFollowersButton: UIButton = {
        let button = UIButton()
        let title: LocalizedStrings = .getFollowers
        button.setTitle(title.localized, for: .normal)
        button.titleLabel?.numberOfLines = .zero
        button.titleLabel?.font = .preferredFont(forTextStyle: .body)
        button.titleLabel?.adjustsFontForContentSizeCategory = true
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = .chateauGreen
        button.layer.cornerRadius = cornerRadius
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
        guard let username = usernameTextField.text else { return }
        delegate?.viewController(didSelectFollower: username)
    }

    func scrollUpGetFollowersButton(at height: CGFloat) {
        UIView.animate(withDuration: 0.25) { [unowned self] in
            self.bottomButtonConstraint?.constant = height > .zero ? -height : -self.mediumPadding
            self.layoutIfNeeded()
        }
    }

    private func setUp() {
        setUpDismissOnTapOutOfTheKeyboard()
        setUpConstraints()
        setUpBackgroundColor()
    }

    private func setUpDismissOnTapOutOfTheKeyboard() {
        let gesture = UITapGestureRecognizer()
        gesture.addTarget(self, action: #selector(dismissKeyboard))
        addGestureRecognizer(gesture)
    }

    @objc private func dismissKeyboard() {
        usernameTextField.resignFirstResponder()
    }

    private func setUpConstraints() {
        setUpStackViewConstraints()
        setUpLogoImageViewConstraints()
        setUpUsernameTextFieldConstraints()
        setUpGetFollowersButtonConstraints()
    }

    private func setUpBackgroundColor() {
        backgroundColor = .systemBackground
    }

    private func setUpLogoImageViewConstraints() {
        logoImageView.heightAnchor.constraint(lessThanOrEqualToConstant: extraLargePadding).isActive = true
    }

    private func setUpUsernameTextFieldConstraints() {
        usernameTextField.heightAnchor.constraint(equalToConstant: largePadding).isActive = true
    }

    private func setUpStackViewConstraints() {
        let constraints = [stackView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor,
                                                          constant: largePadding),
                           stackView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor,
                                                              constant: mediumPadding),
                           stackView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor,
                                                               constant: -mediumPadding)
        ]
        place(stackView, with: constraints)
    }

    private func setUpGetFollowersButtonConstraints() {
        bottomButtonConstraint = getFollowersButton.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor,
                                                                            constant: -mediumPadding)
        let constraints = [getFollowersButton.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor,
                                                                       constant: mediumPadding),
                           getFollowersButton.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor,
                                                                        constant: -mediumPadding),
                           bottomButtonConstraint!,
                           getFollowersButton.heightAnchor.constraint(greaterThanOrEqualToConstant: largePadding),
                           getFollowersButton.topAnchor.constraint(greaterThanOrEqualTo: stackView.bottomAnchor,
                                                                   constant: smallPadding)]
        place(getFollowersButton, with: constraints)
    }
}

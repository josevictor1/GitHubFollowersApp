//
//  CustomAlertView.swift
//  UIComponents
//
//  Created by José Victor Pereira Costa on 25/03/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import UIKit
import Commons

final class CustomAlertView: UIView {
    
    // MARK: - Closures
    
    var confirmButtonAction: Action?
    
    // MARK: - Subviews
    
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = .preferredFont(forTextStyle: .headline)
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = .zero
        return titleLabel
    }()
    
    private let descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.font = .preferredFont(forTextStyle: .caption1)
        descriptionLabel.adjustsFontSizeToFitWidth = true
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = .zero
        return descriptionLabel
    }()
    
    private lazy var confirmButton: UIButton = {
        let confirmButton = UIButton()
        confirmButton.titleLabel?.font = .preferredFont(forTextStyle: .headline)
        confirmButton.titleLabel?.textAlignment = .center
        confirmButton.layer.cornerRadius = 12
        confirmButton.layer.masksToBounds = true
        confirmButton.backgroundColor = .red
        confirmButton.addTarget(self,
                                action: #selector(confirmButtonTapped),
                                for: .touchUpInside)
        return confirmButton
    }()

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 20
        return stackView
    }()
    
    // MARK: - Initializer
    
    init(alert: Alert, action: Action? = nil) {
        super.init(frame: .zero)
        setUp(alert)
        confirmButtonAction = action
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    
    @objc private func confirmButtonTapped() {
        confirmButtonAction?()
    }
    
    // MARK: - Setup
    
    private func setUp(_ alert: Alert) {
        setUpView()
        setUpConstraints()
        setUpStackViewArrangedSubviews()
        configure(with: alert)
    }
    
    private func setUpView() {
        backgroundColor = .secondarySystemBackground
        layer.cornerRadius = 16
    }
    
    private func setUpStackViewArrangedSubviews() {
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(confirmButton)
    }
    
    // MARK: - Constraints

    private func setUpConstraints() {
        setUpConfirmButtonConstraints()
        setUpStackViewConstraints()
    }
    
    private func setUpConfirmButtonConstraints() {
        let constraints = [
            confirmButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 50)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setUpStackViewConstraints() {
        let constraints = [
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
        ]
        place(stackView, with: constraints)
    }
    
    private func configure(with alert: Alert) {
        titleLabel.text = alert.title
        descriptionLabel.text = alert.description
        confirmButton.setTitle(alert.buttonTitle, for: .normal)
    }
}

//
//  CustomAlertView.swift
//  UIComponents
//
//  Created by José Victor Pereira Costa on 25/03/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import UIKit
import Commons

class CustomAlertView: UIView {

    // MARK: - Closures

    var confirmButtonAction: Action?

    // MARK: - Initializer

    init(alert: Alert, action: Action?) {
        super.init(frame: .zero)
        setUp(alert)
        confirmButtonAction = action
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Subviews

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .caption1)
        label.adjustsFontForContentSizeCategory = true
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    private lazy var confirmButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .preferredFont(forTextStyle: .headline)
        button.titleLabel?.adjustsFontForContentSizeCategory = true
        button.titleLabel?.textAlignment = .center
        button.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.backgroundColor = .red
        return button
    }()

    // MARK: - Actions

    @objc private func confirmButtonTapped() {
        confirmButtonAction?()
    }

    // MARK: - Setup

    private func setUp(_ alert: Alert) {
        setUpView()
        setUpTitleLabel(alert.title)
        setUpDescriptionLabel(alert.description)
        setUpConfirmButton(alert.buttonTitle)
    }

    // MARK: - Constraints

    private func setUpView() {
        backgroundColor = .secondarySystemBackground
        layer.cornerRadius = 16
    }

    private func setUpTitleLabel(_ title: String) {
        titleLabel.text = title
        let constraints = [titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 24),
                           titleLabel.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor),
                           titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor),
                           titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor)]
        place(titleLabel, with: constraints)
    }

    private func setUpDescriptionLabel(_ description: String) {
        descriptionLabel.text = description
        let constraints = [descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 28),
                           descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 26),
                           descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -26)]
        place(descriptionLabel, with: constraints)
    }

    private func setUpConfirmButton(_ buttonTitle: String) {
        confirmButton.setTitle(buttonTitle, for: .normal)
        let constraints = [confirmButton.topAnchor.constraint(greaterThanOrEqualTo: descriptionLabel.bottomAnchor,
                                                              constant: 22),
                           confirmButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
                           confirmButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
                           confirmButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)]
        place(confirmButton, with: constraints)
    }

}

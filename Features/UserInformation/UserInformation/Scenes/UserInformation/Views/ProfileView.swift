//
//  ProfileView.swift
//  UserInformation
//
//  Created by José Victor Pereira Costa on 24/02/21.
//  Copyright © 2021 José Victor Pereira Costa. All rights reserved.
//

import Commons
import UIKit

final class ProfileView: UIView {

    private let userDetailView = UserDetailsView()

    private let biograpyLabel: UILabel = {
        let biograpyLabel = UILabel()
        biograpyLabel.font = .preferredFont(forTextStyle: .caption1)
        biograpyLabel.tintColor = .systemGray2
        biograpyLabel.numberOfLines = .zero
        biograpyLabel.adjustsFontSizeToFitWidth = true
        return biograpyLabel
    }()

    private let stackView: UIStackView = {
        let userInformationStackView = UIStackView()
        userInformationStackView.alignment = .leading
        userInformationStackView.distribution = .fill
        userInformationStackView.axis = .vertical
        userInformationStackView.spacing = 16
        return userInformationStackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
    }

    private func setUp() {
        setUpStackViewConstraints()
        setUpStackViewSubviews()
    }

    private func setUpStackViewConstraints() {
        let constraints = [
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]
        place(stackView, with: constraints)
    }

    private func setUpStackViewSubviews() {
        stackView.addArrangedSubview(userDetailView)
        stackView.addArrangedSubview(biograpyLabel)
    }

    func configure(with profile: ProfileInformation) {
        userDetailView.configure(with: profile.userDetails)
        biograpyLabel.text = profile.bibliography
    }
}

//
//  ProfileView.swift
//  UserInformation
//
//  Created by José Victor Pereira Costa on 24/02/21.
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
        embed(stackView)
    }

    private func setUpStackViewSubviews() {
        stackView.addArrangedSubview(userDetailView)
        stackView.addArrangedSubview(biograpyLabel)
    }

    func configure(with profile: Profile) {
        userDetailView.configure(with: profile.userDetails)
        biograpyLabel.text = profile.bibliography
    }
}

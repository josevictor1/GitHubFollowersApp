//
//  InformationDetailView.swift
//  UserInformation
//
//  Created by José Victor Pereira Costa on 25/02/21.
//  Copyright © 2021 José Victor Pereira Costa. All rights reserved.
//

import ImageDownloader
import Commons
import UIKit

final class UserDetailsView: UIView {

    private let avatarImageView: UIImageView = {
        let avatarImageView = UIImageView()
        avatarImageView.contentMode = .scaleAspectFit
        avatarImageView.layer.cornerRadius = 8
        avatarImageView.clipsToBounds = true
        return avatarImageView
    }()

    private let loginLabel: UILabel = {
        let loginLabel = UILabel()
        loginLabel.font = .preferredFont(forTextStyle: .largeTitle)
        loginLabel.adjustsFontSizeToFitWidth = true
        loginLabel.tintColor = .systemGray2
        return loginLabel
    }()

    private let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.font = .preferredFont(forTextStyle: .body)
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.tintColor = .systemGray2
        return nameLabel
    }()

    private let userLocationView = UserLocationView()

    private let informationStackView: UIStackView = {
        let userInformationStackView = UIStackView()
        userInformationStackView.alignment = .leading
        userInformationStackView.distribution = .fill
        userInformationStackView.axis = .vertical
        return userInformationStackView
    }()

    private let contentStackView: UIStackView = {
        let contentStackView = UIStackView()
        contentStackView.distribution = .fill
        contentStackView.alignment = .leading
        contentStackView.axis = .horizontal
        contentStackView.spacing = 16
        return contentStackView
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
        setUpConstraints()
        setUpStackViews()
    }

    private func setUpConstraints() {
        setUpAvatarImageViewContraints()
        setUpContentStackViewConstraints()
    }

    private func setUpAvatarImageViewContraints() {
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            avatarImageView.heightAnchor.constraint(equalToConstant: 90),
            avatarImageView.widthAnchor.constraint(equalToConstant: 90)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    private func setUpContentStackViewConstraints() {
        embed(contentStackView)
    }

    private func setUpStackViews() {
        setUpInformationStackViewSubviews()
        setUpContentStackViewSubViews()
    }

    private func setUpInformationStackViewSubviews() {
        informationStackView.addArrangedSubview(loginLabel)
        informationStackView.addArrangedSubview(nameLabel)
        informationStackView.addArrangedSubview(userLocationView)
    }

    private func setUpContentStackViewSubViews() {
        contentStackView.addArrangedSubview(avatarImageView)
        contentStackView.addArrangedSubview(informationStackView)
    }

    func configure(with userDetail: UserDetails) {
        avatarImageView.loadImage(forULR: userDetail.avatarURL,
                                  placeHolder: ImageAssets.placeholder.image)
        loginLabel.text = userDetail.login
        nameLabel.text = userDetail.name
        userLocationView.location = userDetail.location
        userLocationView.isHidden = userDetail.location.isEmpty
    }
}

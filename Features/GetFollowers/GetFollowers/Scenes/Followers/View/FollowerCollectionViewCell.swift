//
//  FollowersCell.swift
//  GetFollowers
//
//  Created by José Victor Pereira Costa on 27/10/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import ImageDownloader
import UIKit

final class FollowerCollectionViewCell: UICollectionViewCell {

    private let avatarImageView: UIImageView = {
        let avatarImageView = UIImageView()
        avatarImageView.contentMode = .scaleAspectFit
        avatarImageView.layer.cornerRadius = 8
        return avatarImageView
    }()

    private let usernameLabel: UILabel = {
        let usernameLabel = UILabel()
        usernameLabel.numberOfLines = .zero
        usernameLabel.font = .preferredFont(forTextStyle: .footnote)
        usernameLabel.tintColor = .label
        usernameLabel.adjustsFontForContentSizeCategory = true
        return usernameLabel
    }()

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 13
        return stackView
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
        setUpStackViewArrangedSubviews()
    }

    private func setUpConstraints() {
        setUpStackViewConstraints()
        setUpAvatarImageViewConstraints()
    }

    private func setUpAvatarImageViewConstraints() {
        let constraints = [
            avatarImageView.heightAnchor.constraint(equalToConstant: 90),
            avatarImageView.widthAnchor.constraint(equalToConstant: 90)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    private func setUpStackViewConstraints() {
        embed(stackView)
    }

    private func setUpStackViewArrangedSubviews() {
        stackView.addArrangedSubview(avatarImageView)
        stackView.addArrangedSubview(usernameLabel)
    }
    
    func configure(with follower: Follower) {
        avatarImageView.loadImage(forULR: follower.imageURL, placeHolder: UIImage())
        usernameLabel.text = follower.login
    }
}

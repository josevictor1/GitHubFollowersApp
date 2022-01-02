//
//  ProfileTableViewCell.swift
//  FavoriteProfiles
//
//  Created by José Victor Pereira Costa on 26/06/21.
//  Copyright © 2021 José Victor Pereira Costa. All rights reserved.
//

import Commons
import ImageDownloader
import UIComponents
import UIKit

final class ProfileTableViewCell: UITableViewCell {
    
    private let avatarImageView: UIImageView = {
        let avatarImageView = UIImageView()
        avatarImageView.contentMode = .scaleAspectFit
        avatarImageView.layer.cornerRadius = 8
        avatarImageView.clipsToBounds = true
        return avatarImageView
    }()
    
    private let loginLabel: UILabel = {
        let usernameLabel = UILabel()
        usernameLabel.numberOfLines = .zero
        usernameLabel.font = .preferredFont(forTextStyle: .title2)
        usernameLabel.tintColor = .label
        usernameLabel.adjustsFontForContentSizeCategory = true
        return usernameLabel
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.contentMode = .scaleAspectFit
        stackView.alignment = .center
        stackView.spacing = 15
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
    }
    
    private func setUp() {
        selectionStyle = .none
        setUpConstraints()
        setUpViews()
    }
    
    private func setUpViews() {
        setUpStackViewArrangedSubviews()
    }
    
    private func setUpStackViewArrangedSubviews() {
        stackView.addArrangedSubview(avatarImageView)
        stackView.addArrangedSubview(loginLabel)
    }
    
    private func setUpConstraints() {
        setUpStackViewConstraints()
        setUpAvatarImageConstraints()
    }
    
    private func setUpStackViewConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ]
        place(stackView, with: constraints)
    }
    
    private func setUpAvatarImageConstraints() {
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            avatarImageView.widthAnchor.constraint(equalToConstant: 60),
            avatarImageView.heightAnchor.constraint(equalToConstant: 60)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func configure(with favoriteProfile: FavoriteProfile) {
        loginLabel.text = favoriteProfile.login
        avatarImageView.loadImage(forULR: favoriteProfile.avatarURL,
                                  placeHolder: ImageAssets.placeholder.image)
    }
}

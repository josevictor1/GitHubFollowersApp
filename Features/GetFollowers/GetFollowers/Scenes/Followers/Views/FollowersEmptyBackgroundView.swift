//
//  FollowersEmptyBackgroundView.swift
//  GetFollowers
//
//  Created by José Victor Pereira Costa on 20/02/21.
//  Copyright © 2021 José Victor Pereira Costa. All rights reserved.
//

import UIKit
import Commons

final class FollowersEmptyBackgroundView: UIView {
    
    private let messageLabel: UILabel = {
        let messageLabel = UILabel()
        messageLabel.numberOfLines = .zero
        messageLabel.font = .preferredFont(forTextStyle: .title3)
        messageLabel.tintColor = .secondarySystemBackground
        messageLabel.adjustsFontForContentSizeCategory = true
        messageLabel.textAlignment = .center
        messageLabel.text = LocalizedStrings.followersNotFound.localized
        return messageLabel
    }()

    private let backgroundImageView: UIImageView = {
        let backgroundImageView = UIImageView()
        backgroundImageView.contentMode = .bottomLeft
        backgroundImageView.image = ImageAssets.emptyStateLogo.image
        return backgroundImageView
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
        setUpLayout()
        setUpConstraints()
    }

    private func setUpLayout() {
        backgroundColor = .systemBackground
    }

    private func setUpConstraints() {
        setUpBackgroundImageViewConstraints()
        setUpMessageLabelConstraints()
    }

    private func setUpMessageLabelConstraints() {
        let constraints = [
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 65),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -65),
            messageLabel.bottomAnchor.constraint(equalTo: centerYAnchor, constant: -30)
        ]
        place(messageLabel, with: constraints)
    }

    private func setUpBackgroundImageViewConstraints() {
        let constraints = [
            backgroundImageView.heightAnchor.constraint(equalToConstant: 436),
            backgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 65),
            backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]
        place(backgroundImageView, with: constraints)
    }
}

//
//  FollowersCell.swift
//  GetFollowers
//
//  Created by José Victor Pereira Costa on 27/10/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import UIKit

class FollowerCollectionViewCell: UICollectionViewCell {
    
    private let avatarImageView: UIImageView = {
        let avatarImageView = UIImageView()
        avatarImageView.contentMode = .scaleAspectFit
        avatarImageView.layer.cornerRadius = 8
        return avatarImageView
    }()
    
    private let usernameLabel: UILabel = {
        let usernameLabel = UILabel()
        usernameLabel.numberOfLines = .zero
        usernameLabel.font = .preferredFont(forTextStyle: .title3)
        usernameLabel.adjustsFontForContentSizeCategory = true
        return usernameLabel
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setUp() {
        
    }
    
    
}

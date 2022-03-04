//
//  InformationView.swift
//  UserInformation
//
//  Created by José Victor Pereira Costa on 26/03/21.
//  Copyright © 2021 José Victor Pereira Costa. All rights reserved.
//

import UIKit

final class InformationView: UIView {
    
    let iconImageView: UIImageView = {
        let iconImageView = UIImageView()
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.tintColor = .gray
        return iconImageView
    }()
    
    let titleLabel: UILabel = {
        let titleLable = UILabel()
        titleLable.font = .boldSystemFont(ofSize: 18)
        titleLable.adjustsFontSizeToFitWidth = true
        titleLable.textColor = .gray
        return titleLable
    }()
    
    let informationLabel: UILabel = {
        let informationLabel = UILabel()
        informationLabel.font = .boldSystemFont(ofSize: 18)
        informationLabel.adjustsFontSizeToFitWidth = true
        informationLabel.textColor = .systemGray2
        informationLabel.textAlignment = .center
        return informationLabel
    }()
    
    private let topContentStackView: UIStackView = {
        let topContentStackView = UIStackView()
        topContentStackView.axis = .horizontal
        topContentStackView.distribution = .fillProportionally
        topContentStackView.spacing = 6
        return topContentStackView
    }()
    
    private let fullContentStackView: UIStackView = {
        let fullContentStackView = UIStackView()
        fullContentStackView.axis = .vertical
        fullContentStackView.distribution = .equalSpacing
        return fullContentStackView
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
        setUpFullContentStackViewConstraints()
    }
    
    private func setUpFullContentStackViewConstraints() {
        embed(fullContentStackView)
    }
    
    private func setUpStackViews() {
        setUpTopContentStackView()
        setUpFullContentStackView()
    }
    
    private func setUpTopContentStackView() {
        topContentStackView.addArrangedSubview(iconImageView)
        topContentStackView.addArrangedSubview(titleLabel)
    }
    
    private func setUpFullContentStackView() {
        fullContentStackView.addArrangedSubview(topContentStackView)
        fullContentStackView.addArrangedSubview(informationLabel)
    }
}

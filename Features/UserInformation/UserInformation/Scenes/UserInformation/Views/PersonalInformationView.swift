//
//  CompanyInformationView.swift
//  UserInformation
//
//  Created by José Victor Pereira Costa on 28/03/21.
//  Copyright © 2021 José Victor Pereira Costa. All rights reserved.
//

import UIKit
import Core
import Commons

final class PersonalInformationView: UIView {
    
    private let informationView: InformationView = {
        let informationView = InformationView()
        let iconImage = ImageAssets.followersIcon.image
        informationView.iconImageView.image = iconImage
        let title = Localizable.company.localized
        informationView.titleLabel.text = title
        return informationView
    }()
    
    private lazy var navigationButton: UIButton = {
        let navigationButton = UIButton()
        let iconImage = ImageAssets.navigationIcon.image
        navigationButton.setImage(iconImage, for: .normal)
        navigationButton.imageView?.tintColor = .white
        navigationButton.imageView?.contentMode = .center
        navigationButton.layer.cornerRadius = 13
        navigationButton.backgroundColor = .neutralBlackC
        navigationButton.addTarget(self,
                                   action: #selector(navigationButtonTapped),
                                   for: .touchUpInside)
        return navigationButton
    }()
    
    var isNavigationButtonHidden: Bool {
        get { navigationButton.isHidden }
        set { navigationButton.isHidden = newValue }
    }
    
    var onNavigationButtonTapped: (() -> Void)?
    
    var companyName: String? {
        get { informationView.informationLabel.text }
        set { informationView.informationLabel.text = newValue}
    }
    
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
    }
    
    private func setUpConstraints() {
        setUpInformationViewContratins()
        setUpNavigationButtonConstraints()
    }
    
    private func setUpInformationViewContratins() {
        let constraints = [
            informationView.topAnchor.constraint(equalTo: topAnchor),
            informationView.leadingAnchor.constraint(equalTo: leadingAnchor),
            informationView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]
        place(informationView, with: constraints)
    }
    
    private func setUpNavigationButtonConstraints() {
        let constraints = [
            navigationButton.topAnchor.constraint(equalTo: topAnchor),
            navigationButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            navigationButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            navigationButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 60),
            navigationButton.widthAnchor.constraint(equalTo: navigationButton.heightAnchor)
        ]
        place(navigationButton, with: constraints)
    }
    
    @objc private func navigationButtonTapped() {
        onNavigationButtonTapped?()
    }
}

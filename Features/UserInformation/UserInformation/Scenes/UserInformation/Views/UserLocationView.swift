//
//  UserLocationView.swift
//  UserInformation
//
//  Created by José Victor Pereira Costa on 25/02/21.
//

import Commons
import UIKit

final class UserLocationView: UIView {

    private let iconImageView: UIImageView = {
        let iconImageView = UIImageView()
        iconImageView.image = ImagesAssets.locationIcon.image
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.tintColor = .systemGray
        return iconImageView
    }()

    private let locationLabel: UILabel = {
        let locationLabel = UILabel()
        locationLabel.font = .preferredFont(forTextStyle: .subheadline)
        locationLabel.tintColor = .systemGray2
        return locationLabel
    }()

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .bottom
        stackView.distribution = .fillProportionally
        stackView.axis = .horizontal
        return stackView
    }()

    var location: String? {
        set { locationLabel.text = newValue }
        get { locationLabel.text }
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
        setUpStackViewContraints()
        setUpStackViewSubviews()
    }

    private func setUpConstraints() {
        setUpIconImageViewConstraints()
        setUpStackViewContraints()
    }

    private func setUpIconImageViewConstraints() {
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            iconImageView.heightAnchor.constraint(equalToConstant: 23),
            iconImageView.widthAnchor.constraint(equalToConstant: 23)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    private func setUpStackViewContraints() {
        embed(stackView)
    }

    private func setUpStackViewSubviews() {
        stackView.addArrangedSubview(iconImageView)
        stackView.addArrangedSubview(locationLabel)
    }
}

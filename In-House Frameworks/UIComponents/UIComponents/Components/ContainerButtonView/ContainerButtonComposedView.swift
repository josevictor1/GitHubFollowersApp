//
//  ContainerButtonComposedView.swift
//  UIComponents
//
//  Created by José Victor Pereira Costa on 27/03/21.
//  Copyright © 2021 José Victor Pereira Costa. All rights reserved.
//

import UIKit

public final class ContainerButtonComposedView<View: UIView>: UIView {
    
    public var onButtonTapped: (() -> Void)?
    
    public let containerView = View()
    
    public lazy var roundedButton: UIButton = {
        let roundedButton = UIButton()
        roundedButton.layer.cornerRadius = 10
        roundedButton.titleLabel?.font = .boldSystemFont(ofSize: 20)
        roundedButton.addTarget(self,
                                action: #selector(buttonTapped),
                                for: .touchUpInside)
        return roundedButton
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillProportionally
        stackView.axis = .vertical
        stackView.spacing = 20
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
        setUpConstaints()
        setUpStackViewSubviews()
    }
    
    private func setUpConstaints() {
        setUpRoundedButtonConstraints()
        setUpStackViewConstratins()
    }
    
    private func setUpRoundedButtonConstraints() {
        roundedButton.translatesAutoresizingMaskIntoConstraints = true
        let constraints = [
            roundedButton.heightAnchor.constraint(equalToConstant: 44)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setUpStackViewConstratins() {
        let constraints = [
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 14),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -14),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25)
        ]
        place(stackView, with: constraints)
    }
    
    private func setUpStackViewSubviews() {
        stackView.addArrangedSubview(containerView)
        stackView.addArrangedSubview(roundedButton)
    }
    
    @objc private func buttonTapped() {
        onButtonTapped?()
    }
}

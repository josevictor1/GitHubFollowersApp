//
//  RepositoryInformationView.swift
//  UserInformation
//
//  Created by José Victor Pereira Costa on 28/03/21.
//  Copyright © 2021 José Victor Pereira Costa. All rights reserved.
//

import UIKit

final class RepositoryInformationView: UIView {
    
    let leftInformationView = InformationView()
    let rightInformationView = InformationView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
    }
    
    private func setUp() {
        setUpStackViewSubviews()
    }

    private func setUpStackViewSubviews() {
        setUpLeftInformationView()
        setUpRightInformationView()
    }
    
    private func setUpLeftInformationView() {
        let constraints = [
            leftInformationView.topAnchor.constraint(equalTo: topAnchor),
            leftInformationView.bottomAnchor.constraint(equalTo: bottomAnchor),
            leftInformationView.leadingAnchor.constraint(equalTo: leadingAnchor)
        ]
        place(leftInformationView, with: constraints)
    }
    
    private func setUpRightInformationView() {
        let constraints = [
            rightInformationView.topAnchor.constraint(equalTo: topAnchor),
            rightInformationView.bottomAnchor.constraint(equalTo: bottomAnchor),
            rightInformationView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ]
        place(rightInformationView, with: constraints)
    }
}

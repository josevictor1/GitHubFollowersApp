//
//  RoundedContainerCollectionViewCell.swift
//  UIComponents
//
//  Created by José Victor Pereira Costa on 24/03/21.
//  Copyright © 2021 José Victor Pereira Costa. All rights reserved.
//

import UIKit

public final class RoundedContainerCollectionViewCell<View: UIView>: UICollectionViewCell {
    
    public let containerView = View()
    
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
        setUpContainerViewContraints()
    }
    
    private func setUpLayout() {
        layer.cornerRadius = 20
        backgroundColor = .secondarySystemBackground
    }
    
    private func setUpContainerViewContraints() {
        embed(containerView)
    }
}

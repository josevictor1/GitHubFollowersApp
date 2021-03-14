//
//  CollectionReusableViewContainer.swift
//  UIComponents
//
//  Created by José Victor Pereira Costa on 27/02/21.
//  Copyright © 2021 José Victor Pereira Costa. All rights reserved.
//

import UIKit

public final class ContainerReusableView<View: UIView>: UICollectionReusableView {
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
        embed(containerView)
    }
}

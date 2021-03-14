//
//  AccountCreationYearView.swift
//  UserInformation
//
//  Created by José Victor Pereira Costa on 27/02/21.
//

import UIKit

final class AccountCreationYearView: UIView {

    private let yearLabel: UILabel = {
        let yearLabel = UILabel()
        yearLabel.font = .preferredFont(forTextStyle: .footnote)
        yearLabel.adjustsFontSizeToFitWidth = true
        yearLabel.textAlignment = .center
        yearLabel.tintColor = .systemGray
        return yearLabel
    }()

    var year: String? {
        set { yearLabel.text = newValue }
        get { yearLabel.text }
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
        embed(yearLabel)
    }
}

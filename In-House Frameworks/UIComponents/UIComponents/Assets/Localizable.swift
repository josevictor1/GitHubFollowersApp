//
//  Localizable.swift
//  UIComponents
//
//  Created by José Victor Pereira Costa on 03/04/21.
//  Copyright © 2021 José Victor Pereira Costa. All rights reserved.
//

import Foundation

enum Localizable: String {
    case somethingWentWrong
    case ok
    
    var localized: String {
        let bundle = Bundle(for: GetFollowersErrorAlertPresenter.self)
        return rawValue.localized(bundle: bundle)
    }
}

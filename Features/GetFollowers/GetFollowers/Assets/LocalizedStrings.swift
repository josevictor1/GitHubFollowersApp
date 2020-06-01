//
//  GetFollowersLocalizedStrings.swift
//  GetFollowers
//
//  Created by José Victor Pereira Costa on 03/05/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import Commons

enum LocalizedStrings: String {
    case enterUsername = "enter_username"
    case somethingWentWrong = "something_went_wrong"
    case ok = "ok"
    
    var localized: String {
        rawValue.localized(bundle: Bundle(for: FollowersView.self))
    }
}

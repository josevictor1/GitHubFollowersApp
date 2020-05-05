//
//  GetFollowersLocalizedStrings.swift
//  GetFollowers
//
//  Created by José Victor Pereira Costa on 03/05/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import Commons

enum LocalizedStrings: AssetProtocol {
    
    case enterUsername
    
    var rawValue: String {
        switch self {
        case .enterUsername:
            return "enter_username"
        }
    }
    
    init?(rawValue: String) {
        switch rawValue {
        case "enter_username":
            self = .enterUsername
        default:
            return nil
        }
    }
}

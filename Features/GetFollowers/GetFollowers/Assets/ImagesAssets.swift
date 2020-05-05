//
//  GetFollowersImageAssets.swift
//  GetFollowers
//
//  Created by José Victor Pereira Costa on 03/05/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import Commons

enum ImagesAssets: AssetProtocol {
    
    case getFollowersLogo
    
    var rawValue: String {
        switch self {
        case .getFollowersLogo:
            return "gh-logo"
        }
    }
    
    init?(rawValue: String) {
        switch rawValue {
        case "gh-logo":
            self = .getFollowersLogo
        default:
            return nil
        }
    }
}
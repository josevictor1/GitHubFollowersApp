//
//  GetFollowersImageAssets.swift
//  GetFollowers
//
//  Created by José Victor Pereira Costa on 03/05/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//
import UIKit
import Commons

enum ImagesAssets: String {
    case getFollowersLogo = "gh-logo"
    case emptyStateLogo = "empty-state-logo"

    init?(rawValue: String) {
        switch rawValue {
        case "gh-logo":
            self = .getFollowersLogo
        case "empty-state-logo":
            self = .emptyStateLogo
        default:
            return nil
        }
    }

    var image: UIImage {
        UIImage(named: self.rawValue) ?? UIImage()
    }
}

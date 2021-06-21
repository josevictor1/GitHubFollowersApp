//
//  ImageAssets.swift
//  Commons
//
//  Created by José Victor Pereira Costa on 25/02/21.
//  Copyright © 2021 José Victor Pereira Costa. All rights reserved.
//

import UIKit

public enum ImageAssets: String {
    case companySateLogo
    case companyIcon
    case emptyStateLogo
    case favoriteIcon
    case folderIcon
    case followersIcon
    case getFollowersLogo
    case gistsIcon
    case locationIcon
    case magnifyingglass
    case navigationIcon
    case placeholder

    public var image: UIImage {
        UIImage(named: rawValue) ?? UIImage()
    }
}

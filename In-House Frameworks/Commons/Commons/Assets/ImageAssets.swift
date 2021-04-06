//
//  ImageAssets.swift
//  Commons
//
//  Created by José Victor Pereira Costa on 25/02/21.
//  Copyright © 2021 José Victor Pereira Costa. All rights reserved.
//

import UIKit

public enum ImageAssets: String {
    case getFollowersLogo
    case emptyStateLogo
    case companySateLogo
    case companyIcon
    case folderIcon
    case followersIcon
    case gistsIcon
    case locationIcon
    case magnifyingglass
    case navigationIcon
    case placeholder

    public var image: UIImage {
        UIImage(named: self.rawValue) ?? UIImage()
    }
}

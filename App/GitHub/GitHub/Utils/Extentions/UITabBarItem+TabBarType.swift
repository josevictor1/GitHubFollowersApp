//
//  UITabBarItem.swift
//  GitHub
//
//  Created by José Victor Pereira Costa on 02/06/21.
//  Copyright © 2021 José Victor Pereira Costa. All rights reserved.
//

import UIKit
import Commons

extension UITabBarItem {
    
    enum TabBarType {
        case getFollowers
        case favoriteProfiles
        
        var title: String {
            switch self {
            case .getFollowers:
                return "Search"
            case .favoriteProfiles:
                return "Favorites"
            }
        }
        
        var image: UIImage {
            switch self {
            case .getFollowers:
                return ImageAssets.magnifyingglass.image
            case .favoriteProfiles:
                return ImageAssets.favoriteIcon.image
            }
        }
    }
    
    static func tabBarItem(for type: TabBarType) -> UITabBarItem {
        UITabBarItem(title: type.title,
                     image: type.image,
                     tag: .zero)
    }
}

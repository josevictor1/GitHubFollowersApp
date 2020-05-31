//
//  FollowersViewController.swift
//  GetFollowers
//
//  Created by José Victor Pereira Costa on 24/05/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import UIKit

class FollowersViewController: UIViewController, UISearchBarDelegate, UICollectionViewDelegate {
    
    private lazy var followersView: FollowersView = {
        FollowersView(collectionViewDelegate: self,
                      searchBarDelegate: self)
    }()
    
    override func loadView() {
        view = followersView
    }
    
}

extension FollowersViewController {
    
    static func makeFollowers() -> FollowersViewController {
        let viewController = FollowersViewController()
        return viewController
    }
}

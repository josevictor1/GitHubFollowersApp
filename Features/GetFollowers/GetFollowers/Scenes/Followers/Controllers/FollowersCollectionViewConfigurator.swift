//
//  FollowersCollectionViewConfigurator.swift
//  GetFollowers
//
//  Created by José Victor Pereira Costa on 27/10/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import UIKit

protocol FollowersCollectionViewConfiguratorProtocol {
    func configure(_ cell: UICollectionViewCell, with model: Follower)
}

class FollowersCollectionViewConfigurator: FollowersCollectionViewConfiguratorProtocol {
    
    func configure(_ cell: UICollectionViewCell, with follower: Follower) {
        guard let cell = cell as? FollowerCollectionViewCell else { return }
        cell.username = follower.login
    }
}

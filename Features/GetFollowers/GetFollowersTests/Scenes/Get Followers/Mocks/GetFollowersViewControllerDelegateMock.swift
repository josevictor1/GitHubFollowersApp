//
//  GetFollowersViewControllerDelegateMock.swift
//  GetFollowersTests
//
//  Created by José Victor Pereira Costa on 30/03/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import Foundation
@testable import GetFollowers

class GetFollowersViewControllerDelegateMock: GetFollowersViewControllerDelegate {
    
    var didViewControllerGotFollowers = false
    
    func viewControllerDidGotFollowers(_ followers: [Follower]) {
        didViewControllerGotFollowers.toggle()
    }
    
}

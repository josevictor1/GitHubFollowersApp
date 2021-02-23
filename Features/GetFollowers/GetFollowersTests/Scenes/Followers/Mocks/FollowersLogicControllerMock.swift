//
//  FollowersLogicControllerMock.swift
//  GetFollowersTests
//
//  Created by José Victor Pereira Costa on 22/02/21.
//  Copyright © 2021 José Victor Pereira Costa. All rights reserved.
//

import Foundation
@testable import GetFollowers

final class FollowersLogicControllerMock: FollowersLogicControllerProtocol {
    var userLogin = String()
    var searchedLogin = String()
    var selectedIndex = Int()
    var wereFollowersLoaded = false
    var wasNextPagedLoaded = false
    var wasSearchCanceled = false
    
    func loadFollowers() {
        wereFollowersLoaded = true
    }
    
    func loadNextPage() {
        wasNextPagedLoaded = true
    }
    
    func searchFollower(withLogin login: String) {
        searchedLogin = login
    }
    
    func selectFollower(atIndex index: Int) {
        self.selectedIndex = index
    }
    
    func cancelSearch() {
        wasSearchCanceled = true
    }
}

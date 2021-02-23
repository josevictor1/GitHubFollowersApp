//
//  FollowersCoordinatorMock.swift
//  GetFollowersTests
//
//  Created by José Victor Pereira Costa on 22/02/21.
//  Copyright © 2021 José Victor Pereira Costa. All rights reserved.
//

import Foundation
@testable import GetFollowers

final class FollowersCoordinatorMock: FollowersCoordinator {
    var loginToBeShown = String()
    
    func showInformation(for login: String) {
        self.loginToBeShown = login
    }
}

//
//  GetFollowersViewControllerDelegateMock.swift
//  GetFollowersTests
//
//  Created by José Victor Pereira Costa on 30/03/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import Foundation
@testable import GetFollowers

final class GetFollowersViewControllerDelegateMock: SearchCoordinator {
    var didViewControllerGotFollowers = false
    var expectationCompletion: (() -> Void)?

    func viewControllerDidGetFollowers(_ userFollowers: UserInformation) {
        didViewControllerGotFollowers.toggle()
        expectationCompletion?()
    }
}

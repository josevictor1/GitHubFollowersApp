//
//  GetFollowersAlertPresenterMock.swift
//  GetFollowersTests
//
//  Created by José Victor Pereira Costa on 30/03/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import UIKit
@testable import GetFollowers

class GetFollowersAlertPresenterMock: GetFollowersAlertPresenterProtocol {

    var viewController: UIViewController?

    func configureAlert(to presentingViewController: UIViewController) {
        viewController = presentingViewController
    }

    var onAlertPresented: ((GetFollowersError) -> Void)?

    func present(_ error: GetFollowersError) {
        onAlertPresented?(error)
    }

}

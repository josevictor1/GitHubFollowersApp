//
//  GetFollowersAlertPresenterMock.swift
//  GetFollowersTests
//
//  Created by José Victor Pereira Costa on 30/03/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import UIKit
import Commons
import UIComponents

@testable import GetFollowers

final class GetFollowersAlertPresenterMock: GetFollowersErrorAlertPresenterProtocol {
    var viewController: UIViewController?
    var onAlertPresented: ((GetFollowersError) -> Void)?
    var presentedError: GetFollowersError?

    func configureAlert(to presentingViewController: UIViewController) {
        viewController = presentingViewController
    }

    func present(_ error: GetFollowersError) {
        presentedError = error
        onAlertPresented?(error)
    }
}

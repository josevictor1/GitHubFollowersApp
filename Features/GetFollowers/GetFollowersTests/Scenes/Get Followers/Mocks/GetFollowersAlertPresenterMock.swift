//
//  GetFollowersAlertPresenterMock.swift
//  GetFollowersTests
//
//  Created by José Victor Pereira Costa on 30/03/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import UIKit
@testable import GetFollowers

final class GetFollowersAlertPresenterMock: GetFollowersAlertPresenterProtocol {
    var viewController: UIViewController?
    var onAlertPresented: ((GetFollowersError) -> Void)?

    func configureAlert(to presentingViewController: UIViewController) {
        viewController = presentingViewController
    }
    
    func present(_ error: GetFollowersError) {
        onAlertPresented?(error)
    }
}

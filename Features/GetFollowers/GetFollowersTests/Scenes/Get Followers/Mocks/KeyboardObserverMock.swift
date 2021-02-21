//
//  KeyboardObserverMock.swift
//  GetFollowersTests
//
//  Created by José Victor Pereira Costa on 14/01/21.
//  Copyright © 2021 José Victor Pereira Costa. All rights reserved.
//

import UIKit
import Commons

final class KeyboardObserverMock: KeyboardObserverProtocol {
    var onKeyboardAppeared: ((Notification) -> Void)?
    var onKeyboardDisappeared: ((Notification) -> Void)?
    
    func callKeyboardAppeard() {
        let notification = Notification(name: UIApplication.keyboardDidShowNotification)
        onKeyboardAppeared?(notification)
    }
    
    func callKeyboardDisappeared() {
        let notification = Notification(name: UIApplication.keyboardDidHideNotification)
        onKeyboardDisappeared?(notification)
    }
}

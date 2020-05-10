//
//  KeyboardAvoider.swift
//  GetFollowers
//
//  Created by José Victor Pereira Costa on 10/05/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import UIKit

class KeyboardAvoider {
    
    private let keyboardObserver: KeyboardObserver
    
    init(keyboardObserver: KeyboardObserver = KeyboardObserver()) {
        self.keyboardObserver = keyboardObserver
    }
    
    private func setUp() {
        keyboardObserver.onKeyboardAppeared = { notification in
            
        }
    }
    
    private func calulateKeyboard(with notification: Notification) {
//        guard let userInfo = notification.userInfo,
//            let keyboardFrame = notification.userInfo[UIResponder.keyboardWillShowNotification]
    }
    
    
    
    
}

//
//  KeyoardObserver.swift
//  GetFollowers
//
//  Created by José Victor Pereira Costa on 10/05/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import UIKit

class KeyboardObserver {
    
    var onKeyboardAppeared: ((_ notification: Notification) -> Void)?
    var onKeyboardDisappearerd: ((_ notification: Notification) -> Void)?
    
    private let notification: NotificationCenter
    
    init(notification: NotificationCenter = .default) {
        self.notification = notification
        registerNotifications()
    }
    
    func registerNotifications() {
        notification.addObserver(self,
                                 selector: #selector(keyboardWillAppear(notification:)),
                                 name: UIResponder.keyboardWillShowNotification,
                                 object: nil)
        notification.addObserver(self,
                                 selector: #selector(keyboardWillDisappear(notification:)),
                                 name: UIResponder.keyboardWillHideNotification,
                                 object: nil)
    }
    
    @objc private func keyboardWillAppear(notification: Notification) {
        onKeyboardAppeared?(notification)
    }
    
    @objc private func keyboardWillDisappear(notification: Notification) {
        onKeyboardDisappearerd?(notification)
    }
    
    deinit {
        notification.removeObserver(self)
    }
}

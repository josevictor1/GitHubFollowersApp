//
//  KeyoardObserver.swift
//  GetFollowers
//
//  Created by José Victor Pereira Costa on 10/05/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import UIKit

public protocol KeyboardObserverProtocol: AnyObject {
    /// The action called when keyboard appeared.
    var onKeyboardAppeared: ((_ notification: Notification) -> Void)? { get set }

    /// The action called when keyoard disappeard.
    var onKeyboardDisappeared: ((_ notification: Notification) -> Void)? { get set }
}

/// The abstraction that handles keyboard notifications.
public class KeyboardObserver: KeyboardObserverProtocol {

    // MARK: - Actions

    public var onKeyboardAppeared: ((_ notification: Notification) -> Void)?
    public var onKeyboardDisappeared: ((_ notification: Notification) -> Void)?

    // MARK: - Properties

    private let notification: NotificationCenter

    // MARK: - Initialiazer

    /// Creates an observer object with a received notification
    /// - Parameter notification: The received notification.
    public init(notification: NotificationCenter = .default) {
        self.notification = notification
        registerNotifications()
    }

    // MARK: - Notification

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
        onKeyboardDisappeared?(notification)
    }

    // MARK: - Deinitializer

    deinit { notification.removeObserver(self) }
}

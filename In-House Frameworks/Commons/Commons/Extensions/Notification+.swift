//
//  Notification.swift
//  Commons
//
//  Created by José Victor Pereira Costa on 11/05/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import UIKit

public extension Notification {
    
    /// Returns the keyboard frame in the received view.
    /// - Parameter view: The received view.
    /// - Returns: The `CGRect` that represents the keyboard frame.
    func keyboardFrame(for view: UIView) -> CGRect {
        
        guard let userInfo = self.userInfo,
            let keyboardValue = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
                return .zero
        }
        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        return keyboardViewEndFrame
    }
}

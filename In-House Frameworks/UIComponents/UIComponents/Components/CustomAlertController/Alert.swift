//
//  Alert.swift
//  UIComponents
//
//  Created by José Victor Pereira Costa on 25/03/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import Foundation

/// A structure that defines the `CustomAlertView` content.
public struct Alert {
    let title: String
    let description: String
    let buttonTitle: String

    public init(title: String, description: String, buttonTitle: String) {
        self.title = title
        self.description = description
        self.buttonTitle = buttonTitle
    }
}

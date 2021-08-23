//
//  ErrorMessages.swift
//  GitHub
//
//  Created by José Victor Pereira Costa on 26/03/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import Foundation

public enum ErrorMessage: String {
    case requestFail
    case invalidUsername
    case invalidResponse
    case invalidData
    case persistenceFail
    case userAlreadyRegistered

    public var localizedMessage: String {
        self.rawValue.localized()
    }
}

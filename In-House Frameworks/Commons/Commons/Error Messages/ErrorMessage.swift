//
//  ErrorMessages.swift
//  GitHub
//
//  Created by José Victor Pereira Costa on 26/03/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import Foundation

public enum ErrorMessage: String {

    case requestFail = "REQUEST_FAIL"
    case invalidUsername = "INVALID_USERNAME"
    case invalidResponse = "INVALID_RESPONSE"
    case invalidData = "INVALID_DATA"
    case favoritesPresistenceFail = "FAVORITES_PERSISTENCE_FAIL"
    case userAlreadyRegistered = "USER_ALREADY_REGISTERED"

    public var localizedMessage: String {
        self.rawValue.localized()
    }
}

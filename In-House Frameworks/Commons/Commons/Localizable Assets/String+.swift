//
//  String+Localizble.swift
//  Commons
//
//  Created by José Victor Pereira Costa on 28/05/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import Foundation

public extension String {
    
    /// Returns a localized string from a specific key, using the main bundle if one is not specified.
    ///
    ///  This method is a wrapper of the original function NSLocalizedString.
    ///   It aims to reduce the verbosity of the method.
    /// - Parameters:
    ///   - tableName: The receiver’s string table to search. If tableName is nil or is an empty string,
    ///    the method attempts to use the table in Localizable.strings.
    ///   - bundle: The bundle for a  `Localizable.strings` file.
    ///   - value: The value to return if key is nil or if a localized string for key can’t be found in the table.
    ///   - comment: The comment associated with the localized string.
    /// - Returns: Localized string.
    func localized(tableName: String? = nil,
                   bundle: Bundle = .main,
                   value: String = String(),
                   comment: String = String()) -> String {
        NSLocalizedString(self, tableName: tableName, bundle: bundle, value: value, comment: comment)
    }
}

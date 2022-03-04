//
//  String+.swift
//  Commons
//
//  Created by José Victor Pereira Costa on 05/04/21.
//  Copyright © 2021 José Victor Pereira Costa. All rights reserved.
//

import Foundation

public extension String {
    
    func addHTTPSchemeIfNecessary() -> String {
        let hasNoScheme = !lowercased().hasPrefix("http://") || !lowercased().hasPrefix("https://")
        guard hasNoScheme && !isEmpty else { return self }
        return "https://".appending(self)
    }
}

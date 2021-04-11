//
//  SelectedUserInformation.swift
//  Commons
//
//  Created by José Victor Pereira Costa on 10/04/21.
//  Copyright © 2021 José Victor Pereira Costa. All rights reserved.
//

import Foundation

public struct SelectedUserInformation {
    public let login: String
    public let numberOfFollowers: Int
    
    public init(login: String, numberOfFollowers: Int) {
        self.login = login
        self.numberOfFollowers = numberOfFollowers
    }
}

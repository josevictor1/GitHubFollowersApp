//
//  PersonalInformation.swift
//  UserInformation
//
//  Created by José Victor Pereira Costa on 28/02/21.
//  Copyright © 2021 José Victor Pereira Costa. All rights reserved.
//

import Foundation

struct PersonalInformation {
    let name: String
    let email: String
    let blog: String
}

extension PersonalInformation: Equatable { }

extension PersonalInformation: Hashable { }

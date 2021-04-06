//
//  UserInformation.swift
//  UserInformation
//
//  Created by José Victor Pereira Costa on 27/02/21.
//  Copyright © 2021 José Victor Pereira Costa. All rights reserved.
//

import Foundation

enum UserInformation {
    case personalInformation(_ company: PersonalInformation)
    case repository(_ repository: Repository)
    case followers(_ followers: Followers)
}

extension UserInformation: Hashable {
    
    static func == (lhs: UserInformation, rhs: UserInformation) -> Bool {
        switch (lhs, rhs) {
        case let (.personalInformation(lhs), .personalInformation(rhs)):
            return lhs == rhs
        case let (.repository(lhs), .repository(rhs)):
            return lhs == rhs
        case let (.followers(lhs), .followers(rhs)):
            return lhs == rhs
        default:
            return false
        }
    }
}

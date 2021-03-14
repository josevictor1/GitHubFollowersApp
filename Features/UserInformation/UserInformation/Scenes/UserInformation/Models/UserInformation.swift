//
//  UserInformation.swift
//  UserInformation
//
//  Created by José Victor Pereira Costa on 27/02/21.
//

import Foundation

enum UserInformation {
    case company(_ company: Company)
    case repos(_ repos: Repos)
    case followers(_ followers: Followers)
}

extension UserInformation: Hashable {
    
    static func == (lhs: UserInformation, rhs: UserInformation) -> Bool {
        switch (lhs, rhs) {
        case let (.company(lhs), .company(rhs)):
            return lhs == rhs
        case let (.repos(lhs), .repos(rhs)):
            return lhs == rhs
        case let (.followers(lhs), .followers(rhs)):
            return lhs == rhs
        default:
            return false
        }
    }
}

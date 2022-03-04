//
//  Localizable.swift
//  UserInformation
//
//  Created by José Victor Pereira Costa on 28/03/21.
//  Copyright © 2021 José Victor Pereira Costa. All rights reserved.
//

import Foundation

enum Localizable: String {
    case company
    case website
    case following
    case followers
    case publicRepos
    case publicGists
    case githubProfile
    case getFollowers
    case githubCreation
    
    var localized: String {
        let bundle = Bundle(for: UserInformationCoordinator.self)
        return rawValue.localized(bundle: bundle)
    }
}

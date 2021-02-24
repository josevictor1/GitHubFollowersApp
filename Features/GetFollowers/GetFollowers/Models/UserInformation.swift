//
//  UserInformation.swift
//  GetFollowers
//
//  Created by José Victor Pereira Costa on 21/01/21.
//  Copyright © 2021 José Victor Pereira Costa. All rights reserved.
//

import Foundation

struct UserInformation {
    let login: String
    let numberOfFollowers: Int
}

extension UserInformation {

    init?(userNetworkingResponse: UserNetworkingResponse) {
        guard let login = userNetworkingResponse.login else { return nil }
        self.init(login: login,
                  numberOfFollowers: userNetworkingResponse.followers)
    }
}

//
//  UserInformation.swift
//  GetFollowers
//
//  Created by José Victor Pereira Costa on 21/01/21.
//  Copyright © 2021 José Victor Pereira Costa. All rights reserved.
//

import Commons
import GitHubServices

extension SelectedUserInformation {
    
    init?(userNetworkingResponse: UserInformationNetworkingResponse) {
        guard let login = userNetworkingResponse.login,
              let name = userNetworkingResponse.name else { return nil }
        self.init(login: login,
                  name: name,
                  avatarURL: userNetworkingResponse.avatarURL ?? String(),
                  numberOfFollowers: userNetworkingResponse.followers)
    }
}

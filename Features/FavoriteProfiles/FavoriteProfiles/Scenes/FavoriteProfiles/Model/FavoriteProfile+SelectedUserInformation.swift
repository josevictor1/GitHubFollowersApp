//
//  FavoriteUserProfile+SelectedUserInformation.swift
//  FavoriteProfiles
//
//  Created by José Victor Pereira Costa on 03/06/21.
//  Copyright © 2021 José Victor Pereira Costa. All rights reserved.
//

import Commons

extension FavoriteProfile {
    
    init(selectedUser: SelectedUserInformation) {
        self.init(login: selectedUser.login,
                  name: selectedUser.name,
                  avatarURL: selectedUser.avatarURL)
    }
}

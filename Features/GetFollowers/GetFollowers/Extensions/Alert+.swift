//
//  Alert+.swift
//  GetFollowers
//
//  Created by José Victor Pereira Costa on 12/09/21.
//  Copyright © 2021 José Victor Pereira Costa. All rights reserved.
//

import UIComponents

extension Alert {
    
    static var userAddedToFavorites: Alert {
        Alert(title: LocalizedStrings.userFavorited.localized,
              description: LocalizedStrings.userFavoritedMessage.localized,
              buttonTitle: LocalizedStrings.close.localized)
    }
}

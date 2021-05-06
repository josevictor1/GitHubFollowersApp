//
//  FavoriteManagedObject.swift
//  DataStore
//
//  Created by José Victor Pereira Costa on 03/05/21.
//  Copyright © 2021 José Victor Pereira Costa. All rights reserved.
//

import CoreData

final class FavoriteManagedObject: NSManagedObject {
    @NSManaged var name: String?
    @NSManaged var login: String?
    @NSManaged var avatarURL: String?
    @NSManaged var numberOfFollowers: NSNumber?
}

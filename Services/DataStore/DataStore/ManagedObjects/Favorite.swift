//
//  FavoriteManagedObject.swift
//  DataStore
//
//  Created by José Victor Pereira Costa on 03/05/21.
//  Copyright © 2021 José Victor Pereira Costa. All rights reserved.
//

import CoreData

public final class Favorite: NSManagedObject {
    @NSManaged public var avatarURL: String?
    @NSManaged public var login: String?
    @NSManaged public var name: String?
}

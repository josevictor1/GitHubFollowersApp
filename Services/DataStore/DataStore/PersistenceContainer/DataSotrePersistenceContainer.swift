//
//  DataSotrePersistenceContainer.swift
//  DataStore
//
//  Created by José Victor Pereira Costa on 02/05/21.
//  Copyright © 2021 José Victor Pereira Costa. All rights reserved.
//

import CoreData

public final class DataStorePersistenceContainer: NSPersistentContainer {
    
    public convenience init() {
        self.init(name: "GitHubFollowers")
    }
    
    public override class func defaultDirectoryURL() -> URL {
        let defaultDirectoryURL = super.defaultDirectoryURL()
        return defaultDirectoryURL.appendingPathComponent("PersistenceContainer", isDirectory: true)
    }
}

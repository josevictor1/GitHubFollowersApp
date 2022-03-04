//
//  PersistableElement.swift
//  DataStore
//
//  Created by José Victor Pereira Costa on 06/05/21.
//  Copyright © 2021 José Victor Pereira Costa. All rights reserved.
//

import Foundation

public protocol PersistableElement {
    var data: [String: Any] { get }
}

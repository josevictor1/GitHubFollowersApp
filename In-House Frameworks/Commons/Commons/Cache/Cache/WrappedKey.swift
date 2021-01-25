//
//  WrappedKey.swift
//  Commons
//
//  Created by José Victor Pereira Costa on 24/01/21.
//  Copyright © 2021 José Victor Pereira Costa. All rights reserved.
//

import Foundation

final class WrappedKey<Key: Hashable>: NSObject {
    private let key: Key
    
    init(key: Key) {
        self.key = key
    }
    
    override var hash: Int { key.hashValue }
    
    override func isEqual(_ object: Any?) -> Bool {
        guard let value = object as? WrappedKey else {
            return false
        }
        return value.key == key
    }
}

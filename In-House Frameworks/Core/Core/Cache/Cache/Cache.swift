//
//  TemporaryCache.swift
//  Commons
//
//  Created by José Victor Pereira Costa on 24/01/21.
//  Copyright © 2021 José Victor Pereira Costa. All rights reserved.
//

import Foundation

public typealias NSCacheWrapped<Key: Hashable, Value> = NSCache<WrappedKey<Key>, Entry<Value>>

public final class Cache<Key: Hashable, Value> {
    private let cache: NSCacheWrapped<Key, Value>

    public init(cache: NSCacheWrapped<Key, Value> = NSCacheWrapped<Key, Value>()) {
        self.cache = cache
    }

    public func saveData(_ data: Value, forKey key: Key) {
        cache.setObject(Entry(value: data), forKey: WrappedKey(key: key))
    }

    public func data(forKey key: Key) -> Value? {
        guard let entry = cache.object(forKey: WrappedKey(key: key)) else {
            return nil
        }
        return entry.value
    }
}

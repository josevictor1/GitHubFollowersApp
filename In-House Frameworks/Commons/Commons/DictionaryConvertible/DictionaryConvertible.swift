//
//  DictionaryConvertible.swift
//  Commons
//
//  Created by José Victor Pereira Costa on 18/06/21.
//  Copyright © 2021 José Victor Pereira Costa. All rights reserved.
//

public protocol DictionaryConvertible {
    var dictionary: [String: Any] { get }
}

public extension DictionaryConvertible {
    
    var dictionary: [String: Any] {
        Dictionary(uniqueKeysWithValues: attributeValues)
    }
    
    private var attributeValues: [(String, Any)] {
        let mirror = Mirror(reflecting: self)
        return mirror.children.compactMap { label, value in
            guard let label = label else { return nil }
            return (label, value)
        }
    }
}

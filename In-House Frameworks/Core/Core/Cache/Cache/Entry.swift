//
//  Entry.swift
//  Commons
//
//  Created by José Victor Pereira Costa on 24/01/21.
//  Copyright © 2021 José Victor Pereira Costa. All rights reserved.
//

import Foundation

public final class Entry<Value> {
    let value: Value

    init(value: Value) {
        self.value = value
    }
}

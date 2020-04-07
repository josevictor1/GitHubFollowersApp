//
//  Encodable.swift
//  Networking
//
//  Created by José Victor Pereira Costa on 06/04/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import Foundation

extension Encodable {
    
    func encode() -> Data? {
        try? JSONEncoder().encode(self)
    }
}

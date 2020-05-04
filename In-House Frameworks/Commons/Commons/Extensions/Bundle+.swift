//
//  Bundle+.swift
//  Commons
//
//  Created by José Victor Pereira Costa on 03/05/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import Foundation

extension Bundle {
    
    func bundle(for classType: AnyClass) -> Bundle {
        Bundle(for: classType)
    }
}

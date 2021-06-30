//
//  UITableView+.swift
//  Commons
//
//  Created by José Victor Pereira Costa on 26/06/21.
//  Copyright © 2021 José Victor Pereira Costa. All rights reserved.
//

import UIKit

public extension UITableView {
    
    final func registerCell<T: UITableViewCell>(_ cellClass: T.Type) {
        register(cellClass.self, forCellReuseIdentifier: cellClass.identifier)
    }
    
    final func dequeueReusableCell<T: UITableViewCell>(withClass cellClass: T.Type, for indexPath: IndexPath) -> T? {
        dequeueReusableCell(withIdentifier: cellClass.identifier, for: indexPath) as? T
    }
}

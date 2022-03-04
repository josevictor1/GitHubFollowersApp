//
//  FavoriteProfilesCustomDataSource.swift
//  FavoriteProfiles
//
//  Created by José Victor Pereira Costa on 02/01/22.
//  Copyright © 2022 José Victor Pereira Costa. All rights reserved.
//

import UIKit

protocol FavoriteProfilesCustomDataSourceDelegate: AnyObject {
    func tableViewDeletedCell(atIndexPath indexPath: IndexPath)
}

final class FavoriteProfilesCustomDataSource: FavoriteProfilesDataSource {
    
    weak var delegate: FavoriteProfilesCustomDataSourceDelegate?
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            delegate?.tableViewDeletedCell(atIndexPath: indexPath)
        default:
            break
        }
    }
}

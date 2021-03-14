//
//  UserInformationProvider.swift
//  UserInformation
//
//  Created by José Victor Pereira Costa on 27/02/21.
//

import Foundation

protocol UserInformationProviderProtocol {
    func fetchUserInformation(for user: String)
}

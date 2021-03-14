//
//  UserInformationLogicController.swift
//  UserInformation
//
//  Created by José Victor Pereira Costa on 26/02/21.
//

import Foundation

protocol UserInformationLogicControllerProtocol: AnyObject {
    func loadUserInformation()
}

protocol UserInformationLogicOutput {
    func didFectchUserProfile(_ userProfile: Profile)
}

final class UserInformationLogicController: UserInformationLogicControllerProtocol {

    func loadUserInformation() {

    }
}

//
//  UserInformationLogicController.swift
//  UserInformation
//
//  Created by José Victor Pereira Costa on 26/02/21.
//  Copyright © 2021 José Victor Pereira Costa. All rights reserved.
//

import Commons

protocol UserInformationLogicControllerProtocol: AnyObject {
    var profileInformation: ProfileInformation? { get }
    var selectedUserInformation: SelectedUserInformation? { get }
    var email: String? { get }
    var blogURL: URL? { get }
    var githubProfileURL: URL? { get }
    func loadUserInformation()
}

protocol UserInformationLogicOutput: AnyObject {
    func didFetchUserInformation(_ userInformation: [UserInformation])
    func didFetchUserInformationWithError(_ error: GetFollowersError)
    func didFetchUserInformationWithoutUpdates()
}

final class UserInformationLogicController: UserInformationLogicControllerProtocol {
    private let login: String
    private let provider: UserInformationProviderProtocol
    private unowned let viewController: UserInformationLogicOutput
    private var userInformationResponse: UserInformationResponse?
    
    var profileInformation: ProfileInformation?
    
    var selectedUserInformation: SelectedUserInformation? {
        guard let login = userInformationResponse?.login,
              let name = userInformationResponse?.name,
              let avatarURL = userInformationResponse?.avatarURL,
              let numberOfFollowers = userInformationResponse?.followers else { return nil }
        return SelectedUserInformation(login: login,
                                       name: name,
                                       avatarURL: avatarURL,
                                       numberOfFollowers: numberOfFollowers)
    }
    
    var email: String? { userInformationResponse?.email }
    
    var blogURL: URL? {
        guard let blog = userInformationResponse?.blog?.addHTTPSchemeIfNecessary() else { return nil }
        return URL(string: blog)
    }
    var githubProfileURL: URL? {
        guard let githubProfile = userInformationResponse?.htmlURL else { return nil }
        return URL(string: githubProfile)
    }
    
    init(login: String,
         viewController: UserInformationLogicOutput,
         provider: UserInformationProviderProtocol = UserInformationProvider()) {
        self.login = login
        self.viewController = viewController
        self.provider = provider
    }
    
    func loadUserInformation() {
        guard userInformationResponse == nil else {
            return viewController.didFetchUserInformationWithoutUpdates()
        }
        provider.fetchUserInformation(for: login) { [unowned self] result in
            switch result {
            case .success(let response):
                self.handleSuccess(with: response)
            case .failure(let error):
                self.viewController.didFetchUserInformationWithError(error)
            }
        }
    }
    
    private func handleSuccess(with response: UserInformationResponse) {
        userInformationResponse = response
        setUserProfile(with: response)
        updateViewController(with: response)
    }
    
    private func setUserProfile(with response: UserInformationResponse) {
        profileInformation = convertResponseIntoProfileInformation(response)
    }
    
    private func convertResponseIntoProfileInformation(_ response: UserInformationResponse) -> ProfileInformation {
        let userDetails = makeUserDetails(with: response)
        let bibliography = response.bio ?? String()
        let creationData = response.createdAt
        return ProfileInformation(userDetails: userDetails,
                                  bibliography: bibliography,
                                  creationDate: creationData)
    }
    
    private func makeUserDetails(with response: UserInformationResponse) -> UserDetails {
        let avatarURL = response.avatarURL ?? String()
        let name = response.name ?? String()
        let location = response.location ?? String()
        return UserDetails(avatarURL: avatarURL,
                           login: login,
                           name: name,
                           location: location)
    }
    
    private func updateViewController(with response: UserInformationResponse) {
        let userInformations = convertResponseIntoUserInformations(response)
        viewController.didFetchUserInformation(userInformations)
    }
    
    private func convertResponseIntoUserInformations(_ response: UserInformationResponse) -> [UserInformation] {
        let repository = makeRepository(with: response)
        let followers = makeFollowers(with: response)
        var userInformations: [UserInformation] = [.repository(repository), .followers(followers)]
        if let company = makeCompany(with: response) {
            userInformations.insert(.personalInformation(company), at: .zero)
        }
        return userInformations
    }
    
    private func makeCompany(with response: UserInformationResponse) -> PersonalInformation? {
        guard let companyName = response.company else { return nil }
        return PersonalInformation(name: companyName,
                                   email: response.email ?? String(),
                                   blog: response.blog ?? String())
    }
    
    private func makeRepository(with response: UserInformationResponse) -> Repository {
        let repos = String(describing: response.publicRepos)
        let gists = String(describing: response.publicGists)
        return Repository(repos: repos, gists: gists)
    }
    
    private func makeFollowers(with response: UserInformationResponse) -> Followers {
        let following = String(describing: response.following)
        let followers = String(describing: response.followers)
        return Followers(following: following, followers: followers)
    }
}

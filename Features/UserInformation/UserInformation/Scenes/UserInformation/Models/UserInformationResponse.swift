//
//  UserInformationResponse.swift
//  UserInformation
//
//  Created by José Victor Pereira Costa on 31/03/21.
//  Copyright © 2021 José Victor Pereira Costa. All rights reserved.
//

import GitHubServices

struct UserInformationResponse {
    let login: String?
    let avatarURL: String?
    let htmlURL: String
    let name: String?
    let company: String?
    let location: String?
    let email: String?
    let bio: String?
    let blog: String?
    let publicRepos: Int
    let publicGists: Int
    let followers: Int
    let following: Int
    let createdAt: Date
}

extension UserInformationResponse {
    
    init(networkingResponse: UserInformationNetworkingResponse) {
        self.init(login: networkingResponse.login,
                  avatarURL: networkingResponse.avatarURL,
                  htmlURL: networkingResponse.htmlURL,
                  name: networkingResponse.name,
                  company: networkingResponse.company,
                  location: networkingResponse.location,
                  email: networkingResponse.email,
                  bio: networkingResponse.bio,
                  blog: networkingResponse.blog,
                  publicRepos: networkingResponse.publicRepos,
                  publicGists: networkingResponse.publicGists,
                  followers: networkingResponse.followers,
                  following: networkingResponse.following,
                  createdAt: networkingResponse.createdAt)
    }
}

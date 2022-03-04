//
//  UserResponse.swift
//  GetFollowers
//
//  Created by José Victor Pereira Costa on 10/11/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import Foundation

public struct UserInformationNetworkingResponse: Decodable {
    public let login: String?
    public let id: Int
    public let nodeID: String?
    public let avatarURL: String?
    public let gravatarID: String
    public let url: String
    public let htmlURL: String
    public let followersURL: String
    public let followingURL: String
    public let gistsURL: String
    public let starredURL: String
    public let subscriptionsURL: String
    public let organizationsURL: String
    public let reposURL: String
    public let eventsURL: String
    public let receivedEventsURL: String
    public let type: String
    public let siteAdmin: Bool
    public let name: String?
    public let company: String?
    public let blog: String
    public let location: String?
    public let email: String?
    public let hireable: Bool?
    public let bio: String?
    public let twitterUsername: String?
    public let publicRepos: Int
    public let publicGists: Int
    public let followers: Int
    public let following: Int
    public let createdAt: Date
    public let updatedAt: Date
    
    enum CodingKeys: String, CodingKey {
        case login
        case id
        case nodeID = "node_id"
        case avatarURL = "avatar_url"
        case gravatarID = "gravatar_id"
        case url
        case htmlURL = "html_url"
        case followersURL = "followers_url"
        case followingURL = "following_url"
        case gistsURL = "gists_url"
        case starredURL = "starred_url"
        case subscriptionsURL = "subscriptions_url"
        case organizationsURL = "organizations_url"
        case reposURL = "repos_url"
        case eventsURL = "events_url"
        case receivedEventsURL = "received_events_url"
        case type
        case siteAdmin = "site_admin"
        case name
        case company
        case blog
        case location
        case email
        case hireable
        case bio
        case twitterUsername = "twitter_username"
        case publicRepos = "public_repos"
        case publicGists = "public_gists"
        case followers
        case following
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

//
//  GetFollowersFlowBuilder.swift
//  GetFollowers
//
//  Created by José Victor Pereira Costa on 11/07/21.
//  Copyright © 2021 José Victor Pereira Costa. All rights reserved.
//

import Commons
import Core

struct GetFollowersFlowBuilder {
    
    func getFollowers(delegate: SearchCoordinator) -> GetFollowersViewController {
        let builder: GetFollowersBuilderProtocol = getFollowersBuilder()
        return builder.makeGetFollowersViewController(delegate: delegate)
    }
    
    private func getFollowersBuilder() -> GetFollowersBuilderProtocol {
        if Environment.isTestModeEnabled {
            return GetFollowersBuilderMock()
        } else {
            return GetFollowersBuilder()
        }
    }
    
    func followers(selectedUserInformation: SelectedUserInformation,
                   followersCoordinator: FollowersCoordinator) -> FollowersCollectionViewController {
        let builder: FollowersBuilderProtocol = followersBuilder()
        return builder.followers(selectedUserInformation: selectedUserInformation, coordinator: followersCoordinator)
    }
    
    private func followersBuilder() -> FollowersBuilderProtocol {
        if Environment.isTestModeEnabled {
            return FollowersBuilderMock()
        } else {
            return FollowersBuilder()
        }
    }
}

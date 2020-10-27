import Foundation

protocol FollowersModelControllerProtocol {
    var username: String { get }
    func search(forFollower follower: String?) -> [Follower]
}

class FollowersModelController: FollowersModelControllerProtocol {
    
    private let userFollowers: UserFollowers
    
    var username: String {
        userFollowers.username
    }
    
    init(userFollowers: UserFollowers) {
        self.userFollowers = userFollowers
    }
    
    func search(forFollower follower: String?) -> [Follower] {
        guard let follower = follower, !follower.isEmpty else { return [] }
        return []
    }
}

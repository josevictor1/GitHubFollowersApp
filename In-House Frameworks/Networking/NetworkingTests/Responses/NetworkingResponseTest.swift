//
//  NetworkingResponseTest.swift
//  NetworkingTests
//
//  Created by José Victor Pereira Costa on 25/04/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import XCTest
@testable import Networking

class NetworkingResponseTest: XCTestCase {

    // MARK: - Mocks

    let followerDataMock = """
    [
        {
        "login": "octocat",
        "id": 1,
        "node_id": "MDQ6VXNlcjE=",
        "avatar_url": "https://github.com/images/error/octocat_happy.gif",
        "gravatar_id": "",
        "url": "https://api.github.com/users/octocat",
        "html_url": "https://github.com/octocat",
        "followers_url": "https://api.github.com/users/octocat/followers",
        "following_url": "https://api.github.com/users/octocat/following{/other_user}",
        "gists_url": "https://api.github.com/users/octocat/gists{/gist_id}",
        "starred_url": "https://api.github.com/users/octocat/starred{/owner}{/repo}",
        "subscriptions_url": "https://api.github.com/users/octocat/subscriptions",
        "organizations_url": "https://api.github.com/users/octocat/orgs",
        "repos_url": "https://api.github.com/users/octocat/repos",
        "events_url": "https://api.github.com/users/octocat/events{/privacy}",
        "received_events_url": "https://api.github.com/users/octocat/received_events",
        "type": "User",
        "site_admin": false
        }
    ]
    """.data(using: .utf8)!

    let httpURLResponseMock: HTTPURLResponse = {
        let url = URL(string: "api.github.com")!
        return HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)!
    }()

    let followersMock = [FollowerTestModel(login: "octocat", id: 1)]

    // MARK: - Factories

    func mockSUT(with data: Data, response: HTTPURLResponse) -> NetworkingResponse {
        NetworkingResponse(data: data, response: response)
    }

    // MARK: - Tests

    func testCanDecodeWithMap() throws {
        let sut = mockSUT(with: followerDataMock, response: httpURLResponseMock)

        let followers = try sut.map([FollowerTestModel].self)

        XCTAssertEqual(followers, followersMock)
    }

    func testDecodeWithError() {
        let sut = mockSUT(with: Data(), response: httpURLResponseMock)

        XCTAssertThrowsError(try sut.map([FollowerTestModel].self))
    }
}

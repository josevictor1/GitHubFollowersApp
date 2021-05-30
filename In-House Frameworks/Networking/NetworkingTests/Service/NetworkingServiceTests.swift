//
//  NetworkingServiceTests.swift
//  NetworkingTests
//
//  Created by José Victor Pereira Costa on 12/04/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import XCTest
@testable import Networking

final class NetworkingServiceTests: XCTestCase {
    
    private let urlMock = URL(string: "api.github.com")!
    private lazy var requestMock: URLRequest = {
        URLRequest(url: urlMock)
    }()
    
    private func makeSUT(session: URLSession = .shared) -> NetworkingService {
        NetworkingService(requestProvider: URLRequestCreator(), session: session)
    }
    
    enum ResponseStatusCode: Int {
        case success = 200
        case redirection = 300
        case clientError = 400
        case serverError = 500
        case unknownError = 1000
    }
    
    let dataMock = """
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
    
    private func makeHTTPURLResponse(with statusCode: ResponseStatusCode) -> HTTPURLResponse {
        HTTPURLResponse(url: urlMock, statusCode: statusCode.rawValue, httpVersion: nil, headerFields: nil)!
    }
    
    private func makeNSError(with statusCode: ResponseStatusCode) -> NSError {
        NSError(domain: "", code: statusCode.rawValue, userInfo: nil)
    }
    
    private func makeSession(with configuration: URLSessionConfiguration = .ephemeral,
                             _ completion: SessionMockCompletion? = nil) -> URLSession {
        configuration.protocolClasses = [SessionMock.self]
        SessionMock.requestHandler = completion
        return URLSession(configuration: configuration)
    }
    
    // MARK: - Tests
    
    func testSendRequestWithSuccess() {
        let session = makeSession { [unowned self] _ in
            return (self.makeHTTPURLResponse(with: .success), self.dataMock)
        }
        
        let sut = makeSUT(session: session)
        let request = RequestMock()
        let expectation = XCTestExpectation(description: "response")
        
        _ = sut.send(request) { result in
            switch result {
            case .success(let response):
                XCTAssertEqual(response.statusCode, 200)
            case .failure:
                XCTFail("Test should be succeded")
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testSendRequestWithError() {
        let session = makeSession { _ in throw NetworkingError.unknown }
        let sut = makeSUT(session: session)
        let request = RequestMock()
        let expectation = XCTestExpectation(description: "response")
        
        _ = sut.send(request) { result in
            switch result {
            case .success:
                XCTFail("Test should fail")
            case .failure(let error):
                XCTAssertNotNil(error)
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }
}

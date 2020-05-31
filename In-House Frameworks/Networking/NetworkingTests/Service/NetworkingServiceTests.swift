//
//  NetworkingServiceTests.swift
//  NetworkingTests
//
//  Created by José Victor Pereira Costa on 12/04/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import XCTest
@testable import Networking

class NetworkingServiceTests: XCTestCase {
    
    // MARK: - Mocks
    
    let urlMock = URL(string: "api.github.com")!
    lazy var requestMock: URLRequest = {
        URLRequest(url: urlMock)
    }()
    
    // MARK: - Factories
    
    func makeSUT(session: URLSession = .shared) -> NetworkingService {
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
    
    func makeHTTPURLResponse(with statusCode: ResponseStatusCode) -> HTTPURLResponse {
        HTTPURLResponse(url: urlMock, statusCode: statusCode.rawValue, httpVersion: nil, headerFields: nil)!
    }
    
    func makeNSError(with statusCode: ResponseStatusCode) -> NSError {
        NSError(domain: "", code: statusCode.rawValue, userInfo: nil)
    }
    
    func makeSession(with configuration: URLSessionConfiguration = .ephemeral,
                     _ completion: SessionMockCompletion? = nil) -> URLSession {
        configuration.protocolClasses = [SessionMock.self]
        SessionMock.requestHandler = completion
        return URLSession(configuration: configuration)
    }
    
    // MARK: - Tests
    
    func testSendRequestWithSuccess() {
        let session = makeSession { [unowned self] request in
            return (self.makeHTTPURLResponse(with: .success), self.dataMock)
        }
        
        let sut = makeSUT(session: session)
        let request = RequestMock()
        let expectation = XCTestExpectation(description: "response")
        
        sut.send(request) { result in
            switch result {
            case .success(let response):
                XCTAssertEqual(response.statusCode, 200)
            case .failure:
                XCTFail()
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
        
        sut.send(request) { result in
            switch result {
            case .success:
                XCTFail()
            case .failure(let error):
                XCTAssertNotNil(error)
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testConvertResponseToResultWithSuccess() {
        let sut = makeSUT()
        let httpURLResponseMock = makeHTTPURLResponse(with: .success)
        let expectedResponse = NetworkingResponse(data: Data(), request: requestMock, response: httpURLResponseMock)
        var receivedResponse: NetworkingResponse?
        
        let result = sut.convertResponseToResult(Data(), requestMock, httpURLResponseMock, nil)
        
        switch result {
        case .success(let response):
            receivedResponse = response
        case .failure:
            XCTFail()
        }
        
        XCTAssertNotNil(receivedResponse)
        XCTAssertEqual(receivedResponse, expectedResponse)
    }
    
    func testConvertResponseToResultWithNetworkingError() {
        let sut = makeSUT()
        let mockError = makeNSError(with: .serverError)
        let httpURLResponseMock = makeHTTPURLResponse(with: .serverError)
        let responseMock = NetworkingResponse(data: Data(), request: requestMock, response: httpURLResponseMock)
        let expectedError: NetworkingError = .server(mockError, responseMock)
        
        var receivedError: NetworkingError?
        
        let result = sut.convertResponseToResult(nil, requestMock, httpURLResponseMock, mockError)
        
        switch result {
        case .success:
            XCTFail()
        case .failure(let error):
            receivedError = error
        }
        
        XCTAssertNotNil(receivedError)
        XCTAssertEqual(receivedError, expectedError)
    }
    
    func testConvertErrorToNetworkingErrorWithRedirection() {
        let sut = makeSUT()
        let responseMock = NetworkingResponse(data: dataMock, response: makeHTTPURLResponse(with: .redirection))
        let mockError = makeNSError(with: .redirection)
        let expectedError: NetworkingError = .redirection(mockError, responseMock)
        
        let error = sut.convertErrorToNetworkingError(mockError, with: responseMock)
        
        XCTAssertEqual(error, expectedError)
    }
    
    func testConvertErrorToNetworkingErrorWithClientError() {
        let sut = makeSUT()
        let responseMock = NetworkingResponse(data: dataMock, response: makeHTTPURLResponse(with: .clientError))
        let mockError = makeNSError(with: .clientError)
        let expectedError: NetworkingError = .client(mockError, responseMock)
        
        let error = sut.convertErrorToNetworkingError(mockError, with: responseMock)
        
        XCTAssertEqual(error, expectedError)
    }
    
    func testConvertErrorToNetworkingErrorWithServerError() {
        let sut = makeSUT()
        let responseMock = NetworkingResponse(data: dataMock, response: makeHTTPURLResponse(with: .serverError))
        let mockError = makeNSError(with: .serverError)
        let expectedError: NetworkingError = .server(mockError, responseMock)
        
        let error = sut.convertErrorToNetworkingError(mockError, with: responseMock)
        
        XCTAssertEqual(error, expectedError)
    }
    
    func testConvertErrorToNetowrkingErrorWithUnknownError() {
        let sut = makeSUT()
        let responseMock = NetworkingResponse(data: Data(), response: makeHTTPURLResponse(with: .unknownError))
        let mockError = makeNSError(with: .unknownError)
        
        let error = sut.convertErrorToNetworkingError(mockError, with: responseMock)
        
        XCTAssertEqual(error, .unknown)
    }
    
}

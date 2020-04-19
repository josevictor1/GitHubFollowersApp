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
    
    let urlMock = URL(string: "www.test.com")!
    var requestMock: URLRequest  {
        URLRequest(url: urlMock)
    }
    
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
    
    func makeHTTPURLResponse(with statusCode: ResponseStatusCode) -> HTTPURLResponse {
        HTTPURLResponse(url: urlMock, statusCode: statusCode.rawValue, httpVersion: nil, headerFields: nil)!
    }
    
    func makeNSError(with statusCode: ResponseStatusCode) -> NSError {
        NSError(domain: "", code: statusCode.rawValue, userInfo: nil)
    }
    
    func makeSession(with configuration: URLSessionConfiguration = .ephemeral,
                     _ completion: SessionMockCompletion? = nil) -> URLSession {
        SessionMock.requestHandler = completion
        configuration.protocolClasses = [SessionMock.self]
        return URLSession(configuration: configuration)
    }
    
    // MARK: - Tests
    
    func testSendRequest() {
        let session = makeSession { [unowned self] request in
            return (self.makeHTTPURLResponse(with: .success), Data())
        }
        let sut = makeSUT(session: session)
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
        let responseMock = NetworkingResponse(data: Data(), response: makeHTTPURLResponse(with: .redirection))
        let mockError = makeNSError(with: .redirection)
        let expectedError: NetworkingError = .redirection(mockError, responseMock)
        
        let error = sut.convertErrorToNetworkingError(mockError, with: responseMock)
        
        XCTAssertEqual(error, expectedError)
    }
    
    func testConvertErrorToNetworkingErrorWithClientError() {
        let sut = makeSUT()
        let responseMock = NetworkingResponse(data: Data(), response: makeHTTPURLResponse(with: .clientError))
        let mockError = makeNSError(with: .clientError)
        let expectedError: NetworkingError = .client(mockError, responseMock)
        
        let error = sut.convertErrorToNetworkingError(mockError, with: responseMock)
        
        XCTAssertEqual(error, expectedError)
    }
    
    func testConvertErrorToNetworkingErrorWithServerError() {
        let sut = makeSUT()
        let responseMock = NetworkingResponse(data: Data(), response: makeHTTPURLResponse(with: .serverError))
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

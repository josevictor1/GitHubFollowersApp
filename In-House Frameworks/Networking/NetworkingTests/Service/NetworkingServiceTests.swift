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
    
    let mockURL = URL(string: "www.test.com")!
    var mockRequest: URLRequest  {
        URLRequest(url: mockURL)
    }
    
    // MARK: - Factories
    
    func makeSUT() -> NetworkingService {
        NetworkingService(requestProvider: URLRequestCreator())
    }
    
    enum ResponseStatusCode: Int {
        case success = 200
        case redirection = 300
        case clientError = 400
        case serverError = 500
        case unknownError = 1000
    }
    
    func makeHTTPURLResponse(with statusCode: ResponseStatusCode) -> HTTPURLResponse {
        HTTPURLResponse(url: mockURL, statusCode: statusCode.rawValue, httpVersion: nil, headerFields: nil)!
    }
    
    func makeNSError(with statusCode: ResponseStatusCode) -> NSError {
        NSError(domain: "", code: statusCode.rawValue, userInfo: nil)
    }
    
    // MARK: - Tests
    
    func testConvertResponseToResultWithSuccess() {
        let sut = makeSUT()
        let httpURLResponseMock = makeHTTPURLResponse(with: .success)
        let expectedResponse = NetworkingResponse(data: Data(), request: mockRequest, response: httpURLResponseMock)
        var receivedResponse: NetworkingResponse?
        
        let result = sut.convertResponseToResult(Data(), mockRequest, httpURLResponseMock, nil)
        
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
        let responseMock = NetworkingResponse(data: Data(), request: mockRequest, response: httpURLResponseMock)
        let expectedError: NetworkingError = .server(mockError, responseMock)
        
        var receivedError: NetworkingError?
        
        let result = sut.convertResponseToResult(nil, mockRequest, httpURLResponseMock, mockError)
        
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

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
    let mockError = NSError(domain: "", code: 0, userInfo: nil)
    
    // MARK: - Factories
    
    func makeSUT() -> NetworkingService {
        NetworkingService(requestProvider: URLRequestCreator())
    }
    
    enum ResponseStatus {
        case success
        case redirection
        case clientError
        case serverError
        case unknownError
    }
    
    func makeHTTPURLResponse(with status: ResponseStatus) -> HTTPURLResponse {
        let url = URL(string: "www.test.com")!
        var statusCode: Int = 1000
        switch status {
        case .success:
            statusCode = 200
        case .redirection:
            statusCode = 300
        case .clientError:
            statusCode = 400
        case .serverError:
            statusCode = 500
        case .unknownError:
            break
        }
        return HTTPURLResponse(url: url, statusCode: statusCode, httpVersion: nil, headerFields: nil)!
    }
    
    // MARK: - Tests
    
    
    func testConvertErrorToNetworkingErrorWithRedirection() {
        let sut = makeSUT()
        let responseMock = NetworkingResponse(data: Data(),
                                              response: makeHTTPURLResponse(with: .redirection))
        let expectedError: NetworkingError = .redirection(mockError, responseMock)
        
        let error = sut.convertErrorToNetworkingError(mockError, with: responseMock)
        
        XCTAssertEqual(error, expectedError)
    }
    
    func testConvertErrorToNetworkingErrorWithClientError() {
        let sut = makeSUT()
        let responseMock = NetworkingResponse(data: Data(),
                                              response: makeHTTPURLResponse(with: .clientError))
        let expectedError: NetworkingError = .client(mockError, responseMock)
        
        let error = sut.convertErrorToNetworkingError(mockError, with: responseMock)
        
        XCTAssertEqual(error, expectedError)
    }
    
    func testConvertErrorToNetworkingErrorWithServerError() {
        let sut = makeSUT()
        let responseMock = NetworkingResponse(data: Data(),
                                              response: makeHTTPURLResponse(with: .serverError))
        let expectedError: NetworkingError = .server(mockError, responseMock)
        
        let error = sut.convertErrorToNetworkingError(mockError, with: responseMock)
        
        XCTAssertEqual(error, expectedError)
    }
    
    func testConvertErrorToNetowrkingErrorWithUnknownError() {
        let sut = makeSUT()
        let responseMock = NetworkingResponse(data: Data(),
                                              response: makeHTTPURLResponse(with: .unknownError))
        
        let error = sut.convertErrorToNetworkingError(mockError, with: responseMock)
        
        XCTAssertEqual(error, .unknown)
    }
    
}

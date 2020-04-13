//
//  RequestBuilderTests.swift
//  NetworkingTests
//
//  Created by José Victor Pereira Costa on 04/04/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import XCTest
@testable import Networking

class RequestBuilderTests: XCTestCase {
    
    var requestMock = RequestMock()
    var bodyMock = EncodableMock()
    
    func makeSUT() -> URLRequestCreator {
        URLRequestCreator()
    }
    
    func testEcoding() throws {
        let sut = makeSUT()
    
        let data = try sut.encode(bodyMock)
        
        XCTAssertNotNil(data)
    }
    
    func testCreateURLRequestFromRequest() throws {
        let sut = makeSUT()
        
        let urlRequest = try sut.createURLRequest(from: requestMock)
        
        XCTAssertNotNil(urlRequest)
    }
    
    func testCreateURLRequestFromRequestWithInvialidURL() {
        let sut = makeSUT()
        let randomString = "...---"
        requestMock.urlHost = randomString
        requestMock.urlPath = randomString
        
        XCTAssertThrowsError(try sut.createURLRequest(from: requestMock)) { error in
            XCTAssertEqual(error as! NetworkingError, .invalidURL)
        }
    }
    
}
 

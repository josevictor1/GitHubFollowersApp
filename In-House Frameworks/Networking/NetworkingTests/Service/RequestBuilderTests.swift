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
    
    func testCreateURLRequestFromRequest() throws {
        let sut = URLRequestCreator()
        
        let urlRequest = try sut.createURLRequest(from: requestMock)
        
        XCTAssertNotNil(urlRequest)
    }
    
    
    func testCreateURLRequestFromRequestWithInvialidURL() {
        let sut = URLRequestCreator()
        let randomString = "...---"
        requestMock.urlHost = randomString
        requestMock.urlPath = randomString
        
        XCTAssertThrowsError(try sut.createURLRequest(from: requestMock)) { error in
            XCTAssertEqual(error as! NetworkingError, .invalidURL)
        }
    }
    
}
 

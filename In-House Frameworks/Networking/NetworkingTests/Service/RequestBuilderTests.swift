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
    
    func testCreateEndPoint() {
        let sut = URLRequestCreator()
        
        let endpoint = sut.creatEndpoint(from: requestMock)
        
        XCTAssertNotNil(endpoint)
    }
    
    func testCreateURL() {
        let sut = URLRequestCreator()
        
        let url = sut.createURL(from: requestMock)
        
        XCTAssertNotNil(url)
    }
    
    func testCreateURLRequestFromRequest() throws {
        let sut = URLRequestCreator()
        
        let urlRequest = try sut.createURLRequest(from: requestMock)
        
        XCTAssertNotNil(urlRequest)
    }

}

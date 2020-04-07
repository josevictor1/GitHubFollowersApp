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
    
    func testBuildURLRequestFromRequest() throws {
        let sut = URLRequestCreator()
        let requestMock = RequestMock()
        
        let urlRequest = try sut.createURLRequest(from: requestMock)
        
        XCTAssertNotNil(urlRequest)
    }

}

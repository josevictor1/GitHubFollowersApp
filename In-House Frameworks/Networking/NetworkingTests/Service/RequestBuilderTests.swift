//
//  RequestBuilderTests.swift
//  NetworkingTests
//
//  Created by José Victor Pereira Costa on 04/04/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import XCTest
@testable import Networking

final class RequestBuilderTests: XCTestCase {
    private var requestMock = RequestMock()
    private var bodyMock = EncodableMock()
    private let sut = URLRequestCreator()

    func testCreateURLRequestFromRequest() throws {
        let urlRequest = try sut.createURLRequest(from: requestMock)
        
        XCTAssertNotNil(urlRequest)
    }

    func testCreateURLRequestFromRequestWithInvialidURL() {
        let randomString = "...---"
        requestMock.urlHost = randomString
        requestMock.urlPath = randomString

        XCTAssertThrowsError(try sut.createURLRequest(from: requestMock)) { error in
            XCTAssertEqual((error as? NetworkingError) ?? .unknown, .invalidURL)
        }
    }
}

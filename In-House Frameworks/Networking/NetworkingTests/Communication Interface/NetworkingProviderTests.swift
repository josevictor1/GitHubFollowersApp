//
//  NetworkingTests.swift
//  NetworkingTests
//
//  Created by José Victor Pereira Costa on 31/03/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import XCTest
@testable import Networking

class NetworkingProvierTests: XCTestCase {
    
    // MARK: - Mock
    
    let networkingServiceMock = NetworkingServiceMock()
    
    // MARK: - SUT Factory
    
    func makeSUT() -> NetworkingProvider {
        NetworkingProvider(service: networkingServiceMock)
    }
    
    // MARK: - Tests
    
    func testRequestPerformed() {
        let sut = makeSUT()
        let request = RequestMock()
        var didRequestPerform = false
        
        sut.perform(request) { _ in
            didRequestPerform = true
        }
        
        XCTAssertTrue(didRequestPerform)
    }
}

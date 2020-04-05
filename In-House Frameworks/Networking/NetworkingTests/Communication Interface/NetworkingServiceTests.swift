//
//  NetworkingTests.swift
//  NetworkingTests
//
//  Created by José Victor Pereira Costa on 31/03/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import XCTest
@testable import Networking

class NetworkingServiceTests: XCTestCase {
    
    // MARK: - Mock
    
    let networkingServiceMock = NetworkingServiceMock()
    
    // MARK: - SUT Factory
    
    func makeSUT() -> NetworkingService {
        NetworkingService()
    }
    
    // MARK: - Tests
    

    
}

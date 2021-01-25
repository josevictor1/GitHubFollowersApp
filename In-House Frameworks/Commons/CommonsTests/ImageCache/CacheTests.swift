//
//  TemporaryCacheTests.swift
//  CommonsTests
//
//  Created by José Victor Pereira Costa on 24/01/21.
//  Copyright © 2021 José Victor Pereira Costa. All rights reserved.
//

import XCTest
@testable import Commons

final class CacheTests: XCTestCase {
    private let sut = Cache<String, String>()
    
    func testStoreDataOnTemporaryCache() {
        let test = "Test"
        
        sut.saveData(test, forKey: test)
        
        let data = sut.data(forKey: test)
        XCTAssertNotNil(data)
        XCTAssertEqual(data, test)
    }
}

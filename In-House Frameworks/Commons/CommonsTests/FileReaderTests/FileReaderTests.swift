//
//  FileReaderTests.swift
//  CommonsTests
//
//  Created by José Victor Pereira Costa on 22/01/21.
//  Copyright © 2021 José Victor Pereira Costa. All rights reserved.
//

import XCTest
@testable import Commons

final class FileReaderTests: XCTestCase {
    
    private let sut: FileReader = {
        let bundle = Bundle(for: FileReaderTests.self)
        let fileHeader = FileReader(bundle: bundle)
        return fileHeader
    }()

    func testReadFile() throws {
        let data = try sut.readDataForFile(withName: "Test", type: .JSON)
        XCTAssertNotNil(data)
    }

    func testFileNotFound() {
        XCTAssertThrowsError(try sut.readDataForFile(withName: "FileNotFound", type: .JSON))
    }
}

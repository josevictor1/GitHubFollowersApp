//
//  PaginationControllerTests.swift
//  GetFollowersTests
//
//  Created by José Victor Pereira Costa on 23/02/21.
//  Copyright © 2021 José Victor Pereira Costa. All rights reserved.
//

import XCTest
@testable import GetFollowers

final class PaginationControllerTests: XCTestCase {
    
    private var sut: PaginationController {
        PaginationController(maximumPageSize: 30,
                             numberOfItems: 40,
                             startPage: 1)
    }

    func testThereAreLeftPages() {
        let sut = self.sut
        XCTAssertTrue(sut.areThereLeftPages)
    }

    func testTurnPage() {
        let sut = self.sut
        sut.turnPage()

        XCTAssertEqual(sut.currentPage, 2)
    }

    func testTurnMoreThenOnePage() {
        let sut = self.sut
        (0...1).forEach { _ in sut.turnPage() }

        XCTAssertEqual(sut.currentPage, 3)
    }

    func testTurnPagesWithNoPagesLeft() {
        let sut = PaginationController(numberOfItems: .zero, startPage: 1)

        sut.turnPage()

        XCTAssertEqual(sut.currentPage, 1)
    }
}

//
//  FavoriteProfilesViewController.swift
//  FavoriteProfilesTests
//
//  Created by José Victor Pereira Costa on 25/06/21.
//  Copyright © 2021 José Victor Pereira Costa. All rights reserved.
//

import XCTest
@testable import FavoriteProfiles

final class FavoriteProfilesTableViewControllerTests: XCTestCase {
    
    private func makeSUT(provider: FavoriteProfilesProvider) -> FavoriteProfilesTableViewController {
        let logicController = FavoriteProfilesLogicController(provider: provider)
        let sut = FavoriteProfilesTableViewController(logicController: logicController)
        logicController.viewController = sut
        return sut
    }

    func testLoadFavoriteProfiles() {
        let provider = FavoriteProfilesServiceMock()
        let sut = makeSUT(provider: provider)

        sut.viewDidAppear(false)
        
        XCTAssertTrue((((sut.tableView.dataSource?.tableView(sut.tableView, numberOfRowsInSection: 0))!) > 0))
    }
}

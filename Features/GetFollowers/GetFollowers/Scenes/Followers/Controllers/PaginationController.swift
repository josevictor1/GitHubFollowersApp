//
//  FollowersPaginationController.swift
//  GetFollowers
//
//  Created by José Victor Pereira Costa on 23/02/21.
//  Copyright © 2021 José Victor Pereira Costa. All rights reserved.
//

import Foundation

protocol PaginationControllerProtocol {
    var maximumPageSize: Int { get }
    var currentPage: Int { get }
    var areThereLeftPages: Bool { get }
    func turnPage()
}

final class PaginationController: PaginationControllerProtocol {
    private var numberOfItems: Int
    private(set) var maximumPageSize: Int
    private(set) var currentPage: Int
    var areThereLeftPages: Bool { numberOfItems > .zero }

    init(maximumPageSize: Int = 20, numberOfItems: Int, startPage: Int = 1) {
        self.maximumPageSize = maximumPageSize
        self.numberOfItems = numberOfItems
        currentPage = startPage
    }

    func turnPage() {
        guard areThereLeftPages else { return }
        updateNumberOfItems()
        updateCurrentPage()
    }

    private func updateCurrentPage() {
        currentPage += 1
    }

    private func updateNumberOfItems() {
        if numberOfItems >= maximumPageSize {
            numberOfItems -= maximumPageSize
        } else {
            numberOfItems = .zero
        }
    }
}

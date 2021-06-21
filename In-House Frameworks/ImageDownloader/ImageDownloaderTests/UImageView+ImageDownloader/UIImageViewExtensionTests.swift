//
//  ImageDownloaderTests.swift
//  ImageDownloaderTests
//
//  Created by José Victor Pereira Costa on 27/01/21.
//

import XCTest
@testable import ImageDownloader

final class UIImageViewExtensionTests: XCTestCase {
    
    private let sut = UIImageView()

    private func setUpImageViewWithPlaceHolder() {
        sut.loadImage(forULR: "https://simple.wikipedia.org/wiki/Black#/media/File:Black.png",
                      placeHolder: .blackImage)
    }

    private func checkPlaceHolderSetupOnImageView() {
        checkIfTheImageNilForImageView()
        checkIfTheImagesMatchWithThePassedPlaceHolder()
    }

    private func checkIfTheImagesMatchWithThePassedPlaceHolder() {
        XCTAssertEqual(sut.image, .blackImage)
    }

    private func checkIfTheImageNilForImageView() {
        XCTAssertNotNil(sut.image)
    }

    func testLoadImageWithPlaceHolder() {
        setUpImageViewWithPlaceHolder()

        checkPlaceHolderSetupOnImageView()
    }
}

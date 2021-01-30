//
//  ImageDownloaderTests.swift
//  ImageDownloaderTests
//
//  Created by José Victor Pereira Costa on 27/01/21.
//

import XCTest
@testable import ImageDownloader

 
final class ImageDownloaderTests: XCTestCase {
    private let imageDownloader: ImageDownloader = {
        let mockNetowrkingService = NetworkingServiceMock()
        return ImageDownloader(networkingService: mockNetowrkingService)
    }()
    private let expectation = XCTestExpectation(description: "Should have downloaded the image.")
    
    private func setUpImageDownloaderLoadImage() {
        imageDownloader.loadImage(fromURL: "https://simple.wikipedia.org/wiki/Black#/media/File:Black.png",
                                  completion: downloadImageCompletion)
    }
    private var downloadImageCompletion: (Result<UIImage, Error>) -> Void {
        { [unowned self] result in
            switch result {
            case .success(let response):
                checkCorrectImageIfTheCurrectImageWasLoaded(response)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
    }
    
    private func checkCorrectImageIfTheCurrectImageWasLoaded(_ image: UIImage) {
        expectation.fulfill()
        XCTAssertEqual(image.pngData(), UIImage.blackImage.pngData())
    }
    
    private func checkReceivedSuccessWhenLoadImage() {
        wait(for: [expectation], timeout: 1)
    }
    
    func testRequestImage() {
        setUpImageDownloaderLoadImage()
        
        checkReceivedSuccessWhenLoadImage()
    }
}

//
//  SessionMock.swift
//  NetworkingTests
//
//  Created by José Victor Pereira Costa on 18/04/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import Foundation
import XCTest

typealias SessionMockCompletion = ((URLRequest) throws -> (HTTPURLResponse, Data))

class SessionMock: URLProtocol {

    static var requestHandler: SessionMockCompletion?

    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override func startLoading() {
        guard let handler = SessionMock.requestHandler else {
            return XCTFail("Received unexpected request with no handler set")
        }
        do {
            let (response, data) = try handler(request)
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            client?.urlProtocol(self, didLoad: data)
            client?.urlProtocolDidFinishLoading(self)
        } catch {
            client?.urlProtocol(self, didFailWithError: error)
        }
    }

    override func stopLoading() { }

}

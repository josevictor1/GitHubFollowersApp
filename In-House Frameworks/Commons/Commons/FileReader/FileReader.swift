//
//  FileReader.swift
//  Commons
//
//  Created by José Victor Pereira Costa on 22/01/21.
//  Copyright © 2021 José Victor Pereira Costa. All rights reserved.
//

import Foundation

public enum FileReaderError: Error {
    case fileNotFound(_ file: String)

    var localizedDescription: String {
        switch self {
        case .fileNotFound(let file):
            return "\(file) not found."
        }
    }
}

public enum ResourceType: String {
    case JSON = "json"
}

public final class FileReader {
    private let bundle: Bundle

    public init(bundle: Bundle = .main) {
        self.bundle = bundle
    }

    public func readDataForFile(withName fileName: String, type: ResourceType) throws -> Data {
        let path = try filePath(fileName, type: type)
        return try data(forPath: path)
    }

    private func data(forPath path: String) throws -> Data {
        let url = URL(fileURLWithPath: path)
        return try Data(contentsOf: url)
    }

    private func filePath(_ fileName: String, type: ResourceType) throws -> String {
        guard let path = bundle.path(forResource: fileName, ofType: type.rawValue) else {
            throw FileReaderError.fileNotFound(fileName)
        }
        return path
    }
}

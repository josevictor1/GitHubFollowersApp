//
//  FollowerTestModel.swift
//  NetworkingTests
//
//  Created by José Victor Pereira Costa on 25/04/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import Foundation

struct FollowerTestModel: Decodable {

    let login: String
    let id: Int

    enum CodingKeys: String, CodingKey {
        case login
        case id
    }
}

extension FollowerTestModel: Equatable {

    static func == (_ lhs: FollowerTestModel, _ rhs: FollowerTestModel) -> Bool {
        return lhs.login == rhs.login && lhs.id == rhs.id
    }
}

//
//  Environment.swift
//  Core
//
//  Created by José Victor Pereira Costa on 12/07/21.
//  Copyright © 2021 José Victor Pereira Costa. All rights reserved.
//

import Foundation

public struct Environment {
    public static let isTestModeEnabled = CommandLine.arguments.contains("-testMode")
}

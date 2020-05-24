//
//  LocalizableAssets.swift
//  Commons
//
//  Created by José Victor Pereira Costa on 02/05/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import UIKit

/// Protocol that specify the asset.
public protocol AssetProtocol where Self: RawRepresentable, Self.RawValue == String { }

/// The astraction tha acess the project assets.
public class Assets {
    
    /// Returns the localized `String` to correspondent to the received asset.
    /// - Parameter string: The string asset to be localized.
    /// - Returns: The localized string.
    public static func localizable<Asset: AssetProtocol>(string: Asset, in bundle: Bundle = .main) -> String {
        string.rawValue.localized(bundle: bundle)
    }
    
    /// Returns the `UIImage` corrrespondent to received asset.
    /// - Parameter image: The image asset to be instantiated.
    /// - Returns: The image.
    public static func localizable<Asset: AssetProtocol>(image: Asset, in bundle: Bundle = .main) -> UIImage {
        UIImage(named: image.rawValue, in: bundle, with: .none) ?? UIImage()
    }
}

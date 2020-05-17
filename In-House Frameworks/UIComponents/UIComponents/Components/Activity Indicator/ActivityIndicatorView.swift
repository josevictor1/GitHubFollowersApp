//
//  ActivityIndicator.swift
//  UIComponents
//
//  Created by José Victor Pereira Costa on 11/05/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import UIKit
import Core

/// Custom activity indicador.
public class ActivityIndicatorView: UIView {
    
    // MARK: - Properies
    
    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.style = .large
        view.hidesWhenStopped = true
        view.color = .secondarySystemBackground
        return view
    }()
    
    /// Shared instace of `ActivityIndicatorView`.
    public static let shared = ActivityIndicatorView()
    
    // MARK: - Initializer
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setUpLayout()
        embed(activityIndicatorView)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Setup
    
    func setUpLayout() {
        layer.cornerRadius = 8
        backgroundColor = UIColor.quaternarySystemFill.withAlphaComponent(0.7)
    }
    
    // MARK: - Life Cycle
    
    public func start() {
        activityIndicatorView.startAnimating()
    }
    
    public func stop() {
        activityIndicatorView.stopAnimating()
    }
}

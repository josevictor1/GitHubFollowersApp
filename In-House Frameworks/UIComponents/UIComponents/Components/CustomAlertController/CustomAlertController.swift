//
//  CustomAlertController.swift
//  UIComponents
//
//  Created by José Victor Pereira Costa on 25/03/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import UIKit
import Commons

public typealias Action = (() -> Void)

/// Custom alert based on the project especifications
public final class CustomAlertController: UIViewController {

    // MARK: - Properties

    /// An instance of `CustomAlertView`.
    private let alertView: CustomAlertView
    private let confirmButtonAction: Action?

    // MARK: - Initializers

    /// Creates and returns a view controller for displaying an custom alert to the user.
    ///
    /// The custom alert has espessial caracterisctics and is composed by a title, descritption and a button.
    /// - Parameters:
    ///   - alert: The alert cotaining a title, description and a button title.
    ///   - action: The action called when the allert button is tapped.
    public init(alert: Alert, action: Action? = nil) {
        alertView = CustomAlertView(alert: alert)
        confirmButtonAction = action
        super.init(nibName: nil, bundle: nil)
        setUpPresentationStyle()
    }
    
    private func setUpPresentationStyle() {
        modalPresentationStyle = .overFullScreen
        modalTransitionStyle = .crossDissolve
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    // MARK: - Setup
    
    private func setUp() {
        setUpBackgroundColor()
        setUpAlertViewConstraints()
        setUpCustomAlertViewAction()
    }
    
    private func setUpBackgroundColor() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
    }

    private func setUpCustomAlertViewAction() {
        alertView.confirmButtonAction = { [unowned self] in
            dismiss(animated: true, completion: self.confirmButtonAction)
        }
    }

    private func setUpAlertViewConstraints() {
        let constraints = [
            alertView.centerYAnchor.constraint(equalTo: view.centerYAnchor,
                                               constant: -30),
            alertView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                               constant: 47),
            alertView.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                constant: -47)
        ]
        view.place(alertView, with: constraints)
    }
}

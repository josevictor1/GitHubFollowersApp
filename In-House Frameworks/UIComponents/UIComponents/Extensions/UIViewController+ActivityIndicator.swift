//
//  UIViewController+ActivityIndicator.swift
//  UIComponents
//
//  Created by José Victor Pereira Costa on 11/05/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import UIKit

public extension UIViewController {
    
    private var activityIndicator: ActivityIndicatorView { .shared }
    
    private func addActivityIndicatorAsSubview() {
        view.addSubview(activityIndicator)
        activityIndicator.frame = CGRect(x: .zero, y: .zero, width: 80, height: 80)
        activityIndicator.center = view.center
    }
    
    func startLoading() {
        addActivityIndicatorAsSubview()
        activityIndicator.start()
    }
    
    func stopLoading() {
        activityIndicator.removeFromSuperview()
        activityIndicator.stop()
    }
    
}

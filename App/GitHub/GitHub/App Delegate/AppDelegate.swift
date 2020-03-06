//
//  AppDelegate.swift
//  GitHub
//
//  Created by José Victor Pereira Costa on 26/02/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var mainCoordinator: MainCoordinator?
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        setUpMainCoordinator()
        return true
    }
    
    private func setUpMainCoordinator() {
        mainCoordinator = MainCoordinator(navigationController: UINavigationController(),
                                          window: window!)
        mainCoordinator?.start()
    }

}


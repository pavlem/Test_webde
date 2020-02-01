//
//  AppDelegate.swift
//  TestWebDe
//
//  Created by Pavle Mijatovic on 01/02/2020.
//  Copyright © 2020 Pavle Mijatovic. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    // MARK: - App Lifecycle
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        setRootVC()
        return true
    }
    
    // MARK: - Helper
    private func setRootVC() {        
        window = UIWindow()
        window?.rootViewController = UINavigationController(rootViewController: UIStoryboard.startVC)
        window?.makeKeyAndVisible()
    }
}


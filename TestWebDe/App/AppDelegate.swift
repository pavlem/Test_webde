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
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "StartVC_ID")
        
        window = UIWindow()
        window?.rootViewController = UINavigationController(rootViewController: vc)
        window?.makeKeyAndVisible()
    }
}


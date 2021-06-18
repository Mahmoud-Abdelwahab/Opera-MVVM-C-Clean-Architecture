//
//  AppDelegate.swift
//  Opera
//
//  Created by Mahmoud Abdul-Wahab on 17/06/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let router = MainTabbarCoordinator().strongRouter
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        router.setRoot(for: window!)
        return true
    }

  


}


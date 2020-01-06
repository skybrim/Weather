//
//  AppDelegate.swift
//  Weather
//
//  Created by wiley on 2019/12/27.
//  Copyright © 2019 wiley. All rights reserved.
//

import UIKit
@_exported import Util
@_exported import RxSwift
@_exported import RxCocoa

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coordinator: Coordinator?
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        // Override point for customization after application launch.
        
        let root = WeatherViewController()
        coordinator = Coordinator(root: root)

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = root
        window?.makeKeyAndVisible()
        
        return true
    }
}

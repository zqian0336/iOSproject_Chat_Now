//
//  AppDelegate.swift
//  Chat-Now
//
//  Created by Zhicheng Qian on 9/23/18.
//  Copyright © 2018 Zhicheng Qian. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        AppController.shared.show(in: UIWindow(frame: UIScreen.main.bounds))
        
        return true
    }
    
}

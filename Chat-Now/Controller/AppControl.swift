//
//  AppControl.swift
//  Chat-Now
//
//  Created by Zhicheng Qian on 9/27/18.
//  Copyright © 2018 Zhicheng Qian. All rights reserved.
//

import UIKit
import Firebase

final class AppController {
    
    static let shared = AppController()
    
    init() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(userStateDidChange),
            name: Notification.Name.AuthStateDidChange,
            object: nil
        )
    }
    
    private var window: UIWindow!
    private var rootViewController: UIViewController? {
        didSet {
            if let vc = rootViewController {
                

                window.rootViewController = vc
            }
            
        }
    }
    
    // MARK: - Helpers
    
    func show(in window: UIWindow?) {
        guard let window = window else {
            fatalError("Cannot layout app with a nil window.")
        }
        
        FirebaseApp.configure()
        
        self.window = window
        window.tintColor = .myColor
        window.backgroundColor = .blue
        print("Problem is here")
        
        handleAppState()
        
        window.makeKeyAndVisible()
        
    }
    
    private func handleAppState() {
        if let user = Auth.auth().currentUser {
            let vc = ChannelsViewController(currentUser: user)
            rootViewController = NavigationController(vc)
        } else {
            let vc = WelcomeViewController()
            rootViewController = NavigationController(vc)
        }
    }
    
    // MARK: - Notifications
    
    @objc internal func userStateDidChange() {
        DispatchQueue.main.async {
            self.handleAppState()
        }
    }
    
}

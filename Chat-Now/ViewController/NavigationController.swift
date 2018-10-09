//
//  NavigationController.swift
//  Chat-Now
//
//  Created by Zhicheng Qian on 9/27/18.
//  Copyright © 2018 Zhicheng Qian. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {
    
    init(_ rootVC: UIViewController) {
        super.init(nibName: nil, bundle: nil)
        pushViewController(rootVC, animated: false)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.tintColor = .myColor
        //navigationBar.prefersLargeTitles = true
        navigationBar.titleTextAttributes = [.foregroundColor: UIColor.myColor]
        //navigationBar.largeTitleTextAttributes = navigationBar.titleTextAttributes
        navigationBar.isTranslucent = false
        toolbar.tintColor = .myColor
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle ?? .default
    }
    
}

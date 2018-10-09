//
//  WelcomeViewController.swift
//  Chat-Now
//
//  Created by Zhicheng Qian on 9/24/18.
//  Copyright © 2018 Zhicheng Qian. All rights reserved.
//

import UIKit
import Firebase

class WelcomeViewController: UIViewController {

    @IBOutlet weak var SigninButton: UIButton!
    @IBOutlet weak var SigninButtonBackView: UIView!
    @IBOutlet weak var LoginButton: UIButton!
    @IBOutlet weak var LoginButtonBackView: UIView!
    
    @IBAction func SigninPressed() {
        let vc = SigninViewController()
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    @IBAction func LoginPressed() {
        let vc = LoginViewController()
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print("Welcome")
        SigninButtonBackView.smoothRoundCorners(to: SigninButtonBackView.bounds.height / 2)
        LoginButtonBackView.smoothRoundCorners(to: LoginButtonBackView.bounds.height / 2)
        navigationController?.isNavigationBarHidden = true

    }
    
}

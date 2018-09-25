//
//  LoginViewController.swift
//  Chat-Now
//
//  Created by Zhicheng Qian on 9/24/18.
//  Copyright © 2018 Zhicheng Qian. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class LoginViewController: UIViewController {

    private let CONTACT_SEGUE = "ContactSegue2"
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Login(_ sender: Any) {
        SVProgressHUD.show()
        
        Auth.auth().signIn(withEmail: email.text!, password: password.text!) { (user, error) in
            
            if error != nil {
                print(error!)
            } else {
                print("Log in successful!")
                
                SVProgressHUD.dismiss()
                self.performSegue(withIdentifier: self.CONTACT_SEGUE, sender: self)
                
            }
            
        }
        
    }
    
    
    

}

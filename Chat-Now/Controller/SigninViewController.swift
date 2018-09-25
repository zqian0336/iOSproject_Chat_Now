//
//  SigninViewController.swift
//  Chat-Now
//
//  Created by Zhicheng Qian on 9/24/18.
//  Copyright © 2018 Zhicheng Qian. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class SigninViewController: UIViewController {

    private let CONTACT_SEGUE = "ContactSegue"
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var phoneNum: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    @IBAction func Signin(_ sender: Any) {
        SVProgressHUD.show()
        
        //Set up a new user on our Firebase database
        
        Auth.auth().createUser(withEmail: emailText.text!, password: password.text!) { (user, error) in
            
            if error != nil {
                print(error!)
            } else {
                print("Registration Successful!")
                
                SVProgressHUD.dismiss()
                
                self.performSegue(withIdentifier: self.CONTACT_SEGUE, sender: self)
            }
        }
    }
    
    

    
}

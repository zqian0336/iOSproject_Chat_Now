//
//  LoginViewController.swift
//  Chat-Now
//
//  Created by Zhicheng Qian on 9/28/18.
//  Copyright © 2018 Zhicheng Qian. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    
    @IBOutlet weak var EmailBackView: UIView!
    @IBOutlet weak var PasswordBackView: UIView!
    @IBOutlet weak var Email: UITextField!
    @IBOutlet weak var Password: UITextField!
    @IBOutlet weak var LoginbuttonBackView: UIView!
    
    
    @IBAction func LoginPressed() {
        login()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        EmailBackView.smoothRoundCorners(to: 8)
        PasswordBackView.smoothRoundCorners(to: 8)
        LoginbuttonBackView.smoothRoundCorners(to: LoginbuttonBackView.bounds.height / 2)

    }
    
    private func login() {
        
        guard let email = Email.text, !email.isEmpty else {
            //SVProgressHUD.dismiss()
            showMissingEmailAlert()
            return
        }
        guard let password = Password.text, !password.isEmpty else {
            //SVProgressHUD.dismiss()
            showMissingPasswordAlert()
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error != nil {
                print(error!)
                //SVProgressHUD.dismiss()
                self.showWrongFormatAlert()
                
            } else {
                print("Successfully Log in ")
                //SVProgressHUD.dismiss()
                
            }
            
        }
    }
    
    private func showMissingEmailAlert() {
        let ac = UIAlertController(title: "Email Required", message: "Please enter your email.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Okay", style: .default, handler: { _ in
            DispatchQueue.main.async {
                self.Email.becomeFirstResponder()
            }
        }))
        present(ac, animated: true, completion: nil)
    }
    
    private func showMissingPasswordAlert() {
        let ac = UIAlertController(title: "Password Required", message: "Please enter your password (no less than 6 characters).", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Okay", style: .default, handler: { _ in
            DispatchQueue.main.async {
                self.Password.becomeFirstResponder()
            }
        }))
        present(ac, animated: true, completion: nil)
    }
    
    private func showWrongFormatAlert() {
        let ac = UIAlertController(title: "Incorrect Format", message: "Please enter a password that not less than 6 characters  OR enter your email in proper format).", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Got it", style: .default, handler: { _ in
            DispatchQueue.main.async {
                self.Email.becomeFirstResponder()
            }
        }))
        present(ac, animated: true, completion: nil)
    }
    
    
    
    


}

//
//  LoginViewController.swift
//  Chat-Now
//
//  Created by Zhicheng Qian on 9/27/18.
//  Copyright © 2018 Zhicheng Qian. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class SigninViewController: UIViewController {
    
    @IBOutlet var actionButton: UIButton!
    @IBOutlet weak var NicknameFieldBack: UIView!
    @IBOutlet weak var PasswordFieldBack: UIView!
    @IBOutlet weak var EmailFieldBack: UIView!
    @IBOutlet weak var NickName: UITextField!
    @IBOutlet weak var Password: UITextField!

    @IBOutlet weak var Email: UITextField!
    @IBOutlet var actionButtonBackingView: UIView!
    @IBOutlet var bottomConstraint: NSLayoutConstraint!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //navigationController?.isNavigationBarHidden = true
        NicknameFieldBack.smoothRoundCorners(to: 8)
        PasswordFieldBack.smoothRoundCorners(to: 8)
        EmailFieldBack.smoothRoundCorners(to: 8)
        actionButtonBackingView.smoothRoundCorners(to: actionButtonBackingView.bounds.height / 2)

        //=============Press Enter to sign in ==========
        
        Email.tintColor = .myColor
        Email.addTarget(
            self,
            action: #selector(textFieldDidReturn),
            for: .primaryActionTriggered
        )

        Password.tintColor = .myColor
        Password.addTarget(
            self,
            action: #selector(textFieldDidReturn),
            for: .primaryActionTriggered
        )

        NickName.tintColor = .myColor
        NickName.addTarget(
            self,
            action: #selector(textFieldDidReturn),
            for: .primaryActionTriggered
        )
        
        registerForKeyboardNotifications()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        NickName.becomeFirstResponder()
//        Email.becomeFirstResponder()
//        Password.becomeFirstResponder()
//        NickName.becomeFirstResponder()
    }
    
    // MARK: - Actions
    
    @IBAction func actionButtonPressed() {
        signIn()
    }
    
    @objc private func textFieldDidReturn() {
        signIn()
    }
    
    // MARK: - Helpers
    
    private func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    private func signIn() {
        
        //SVProgressHUD.show()
        
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
        guard let nickname = NickName.text, !nickname.isEmpty else {
            //SVProgressHUD.dismiss()
            showMissingNameAlert()
            return
        }
        
//        Email.resignFirstResponder()
//        Password.resignFirstResponder()
//        NickName.resignFirstResponder()
        
        
        AppSettings.displayName = nickname
//        Auth.auth().signInAnonymously(completion: nil)
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if error != nil {
                print(error!)
                //SVProgressHUD.dismiss()
                self.showWrongFormatAlert()
                
            } else {
                print("Successfully Sign in ")
                //SVProgressHUD.dismiss()
                
            }
  
        }
    }
    
    private func showMissingNameAlert() {
        let ac = UIAlertController(title: "Username Required", message: "Please enter a username.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Okay", style: .default, handler: { _ in
            DispatchQueue.main.async {
                self.NickName.becomeFirstResponder()
            }
        }))
        present(ac, animated: true, completion: nil)
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
    // MARK: - Notifications
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo else {
            return
        }
        guard let keyboardHeight = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height else {
            return
        }
        guard let keyboardAnimationDuration = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue else {
            return
        }
        guard let keyboardAnimationCurve = (userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber)?.uintValue else {
            return
        }

        let options = UIView.AnimationOptions(rawValue: keyboardAnimationCurve << 16)
        bottomConstraint.constant = keyboardHeight + 20

        UIView.animate(withDuration: keyboardAnimationDuration, delay: 0, options: options, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }

    @objc private func keyboardWillHide(_ notification: Notification) {
        guard let userInfo = notification.userInfo else {
            return
        }
        guard let keyboardAnimationDuration = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue else {
            return
        }
        guard let keyboardAnimationCurve = (userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber)?.uintValue else {
            return
        }

        let options = UIView.AnimationOptions(rawValue: keyboardAnimationCurve << 16)
        bottomConstraint.constant = 20

        UIView.animate(withDuration: keyboardAnimationDuration, delay: 0, options: options, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    

}

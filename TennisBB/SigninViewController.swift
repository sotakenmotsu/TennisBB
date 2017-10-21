//
//  SigninViewController.swift
//  TennisBB
//
//  Created by 剱物蒼太 on 2017/10/21.
//  Copyright © 2017年 剱物蒼太. All rights reserved.
//

import UIKit
import Firebase

class SigninViewController: UIViewController {
    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        passwordTextField.isSecureTextEntry = true
//        self.layoutFaceBookButton()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func willSignup() {
        signup()
    }
    
    @IBAction func willTransitionToLogin() {
        transitionToLogin()
    }
    
    @IBAction func willLoginWithFacebook() {
        self.loginWithFacebook()
    }
    
    func transitionToLogin() {
        self.performSegue(withIdentifier: "toLogin", sender: self)
    }
    
    func transitionToView() {
        self.performSegue(withIdentifier: "toView", sender: self)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func signup() {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        FIRAuth.auth()?.createUser(withemail: email, password: password, completion: { (user, error) in
            if error == nil {
                self.transitionToLogin()
            } else {
                print("\(error?.localizedDescription)")
            }
        })
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

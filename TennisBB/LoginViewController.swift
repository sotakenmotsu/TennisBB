//
//  LoginViewController.swift
//  TennisBB
//
//  Created by 剱物蒼太 on 2017/10/21.
//  Copyright © 2017年 剱物蒼太. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class LoginViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        passwordTextField.isSecureTextEntry = true
        emailTextField.placeholder = "email"
        passwordTextField.placeholder = "password"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if self.checkUserVerify() {
            self.transitionToView()
        }
    }
    
    @IBAction func didRegisterUser() {
        login()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func transitionToView() {
        self.performSegue(withIdentifier: "toVC", sender: self)
    }
    
    func login() {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
            if error == nil {
                if let loginUser = user {
                    if self.checkUserValidate(user: loginUser) {
                        print(Auth.auth().currentUser)
                        self.transitionToView()
                    } else {
                        self.presentValidatealert()
                    }
                }
            } else {
                print("error...\(error?.localizedDescription)")
            }
        })
    }
    
    func checkUserValidate(user: User) -> Bool {
        return user.isEmailVerified
    }
    
    func presentValidatealert() {
        let alert = UIAlertController(title:"メール認証", message: "メール認証をおこなってください", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func checkUserVerify() -> Bool {
        guard let user = Auth.auth().currentUser else { return false }
        return user.isEmailVerified
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

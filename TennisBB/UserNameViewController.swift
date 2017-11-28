//
//  UserNameViewController.swift
//  TennisBB
//
//  Created by 剱物蒼太 on 2017/11/07.
//  Copyright © 2017年 剱物蒼太. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class UserNameViewController: UIViewController {

    @IBOutlet var usernameTextField: UITextField!
    var database: Firestore!
    var ref: DocumentReference? = nil
    var contents = [Content]()
    var username: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        FirebaseApp.configure()
        database = Firestore.firestore()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.  sotakenmotsu@gmail.com
    }
    func createDocument() {
        ref = database.collection("Users").addDocument(data: [
            "username": username
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(self.ref!.documentID)")
            }
        }
    }
    
    @IBAction func namedButton() {
        username = usernameTextField.text
        self.createDocument()
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

//
//  ViewController.swift
//  TennisBB
//
//  Created by 剱物蒼太 on 2017/01/11.
//  Copyright © 2017年 剱物蒼太. All rights reserved.
//

import UIKit
import Foundation
import RealmSwift

class LookForViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var selectedcell: UITableViewCell!
    @IBOutlet weak var tableview: UITableView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableview.dataSource = self
        tableview.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func segueToLContentsViewController() {
        self.performSegue(withIdentifier: "toLContentsViewController", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return selectedcell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedcell as! Int
    }
    
}

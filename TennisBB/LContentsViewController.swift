//
//  LcontentsViewController.swift
//  TennisBB
//
//  Created by 剱物蒼太 on 2017/01/25.
//  Copyright © 2017年 剱物蒼太. All rights reserved.
//

import UIKit
import Foundation
import RealmSwift

class LContentsViewController: UIViewController {

    @IBOutlet weak var TableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        TableView.dataSource = self
//        TableView.delegate = self
        
        self.setupTableViewHeader()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupTableViewHeader() {
        TableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 150))
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

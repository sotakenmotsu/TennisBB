//
//  SearchViewController.swift
//  TennisBB
//
//  Created by 剱物蒼太 on 2018/06/22.
//  Copyright © 2018年 剱物蒼太. All rights reserved.
//

import UIKit
import Firebase


class SearchViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SearchViewControllerTableViewCell
        cell.placelabel.text  = "swift"
        cell.endlabel.text = "swift"
        cell.startlabel.text = "Swift"
        return cell
    }
}

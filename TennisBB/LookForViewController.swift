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

class LookForViewController: UITableViewController {
    
    let realm = try! Realm()
    var contents: Results<Contents>? = nil
    var content: Contents?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        contents = realm.objects(Contents.self)
        self.tableView.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "customCell")
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(refreshTableView), for: UIControlEvents.valueChanged)
        self.refreshControl = refresh
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
//    func segueToLContentsViewController() {
//        self.performSegue(withIdentifier: "toLContentsViewController", sender: nil)
//    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! CustomCell
        cell.placelabel.text = contents?[indexPath.row].place
        cell.startlabel.text = contents?[indexPath.row].starttime
        cell.endlabel.text = contents?[indexPath.row].endtime
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contents?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        content = contents?[indexPath.row]
        if content != nil {
            performSegue(withIdentifier: "toLContentsView", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        if (segue.identifier == "toLContentsView"){
            let LC: LContentsViewController = (segue.destination as? LContentsViewController)!
            LC.contents = content
        }
    }
    
    func refreshTableView() {
        sleep(1)
        tableView.reloadData()
        refreshControl?.endRefreshing()
    }

}

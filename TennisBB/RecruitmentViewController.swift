//
//  RecruitmentViewController.swift
//  TennisBB
//
//  Created by 剱物蒼太 on 2017/01/11.
//  Copyright © 2017年 剱物蒼太. All rights reserved.
//

import UIKit
import Foundation
import RealmSwift

class RecruitmentViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableview: UITableView!
    let realm = try! Realm()
    var contents: Results<Contents>? = nil
    var refresh: UIRefreshControl!
    @IBOutlet var newpostbutton: UIButton!


    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.dataSource = self
        contents = realm.objects(Contents.self)
        self.tableview.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "customCell")
        self.refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(refreshTableView), for: UIControlEvents.valueChanged)
        self.tableview.addSubview(refresh)
        self.view.backgroundColor = ColorManager.maincolor
        newpostbutton.backgroundColor = ColorManager.buttoncolor
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func back(_ segue: UIStoryboardSegue) {
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! CustomCell
        cell.placelabel.text = contents?[indexPath.row].place
        cell.startlabel.text = contents?[indexPath.row].starttime
        cell.endlabel.text = contents?[indexPath.row].endtime
        cell.backgroundColor = ColorManager.tablecolor
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contents?.count ?? 0
    }
    
    func showalert(indexPath: IndexPath) {
        let alert: UIAlertController = UIAlertController(title: "この投稿を削除します", message: "よろしいですか？", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title:"キャンセル", style: .cancel))
        alert.addAction(UIAlertAction(title: "削除", style: .destructive, handler: { action in
            try! self.realm.write {
                guard let content = self.contents?[indexPath.row] else {
                    return
                }
                self.realm.delete(content)
            }
            self.tableview.deleteRows(at: [indexPath], with: .fade) }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deletebutton: UITableViewRowAction = UITableViewRowAction(style: .normal, title: "削除") {
            (action, index) -> Void in self.showalert(indexPath: indexPath)
        }
        return [deletebutton]
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.showalert(indexPath: indexPath)
        }
    }
    
    func refreshTableView() {
        sleep(1)
        tableview.reloadData()
        refresh.endRefreshing()
    }
    
    @IBAction func postbutton() {
        self.view.backgroundColor = ColorManager.buttoncolor
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

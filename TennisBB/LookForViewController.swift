
//  ViewController.swift
//  TennisBB
//
//  Created by 剱物蒼太 on 2017/01/11.
//  Copyright © 2017年 剱物蒼太. All rights reserved.
//

import UIKit
import Foundation
import Firebase

class LookForViewController: UITableViewController {
    
//    let realm = try! Realm()
    var contents = [Content]()
    var content: Content?
    var boards = [Board]()
    var database: Firestore = Firestore.firestore()
    var board: AnyClass!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        contents = realm.objects(Contents.self)
        database.collection("Boards").getDocuments(completion: { (documents, error) in
            // エラー処理
            if error == nil {
                print("gotdocuments")
            }else{
                print("didn't getdocuments")
            }
            // QuerySnapshotを[Board]に変換
            for document in documents!.documents {
                print("\(document.documentID) => \(document.data())")
                Board(dic: document.data())
                board = Board(dic: document.data())
            }
            // [Board]をboardsに入れる
            self.boards = [Board]()
            print(Board())
        })
        self.tableView.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "customCell")
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(refreshTableView), for: UIControlEvents.valueChanged)
        self.refreshControl = refresh
        self.view.backgroundColor = ColorManager.maincolor
        tableView.tableFooterView = UIView(frame: .zero)
        navigationController?.navigationBar.barTintColor = ColorManager.barcolor
        navigationController?.navigationBar.tintColor = UIColor(red: 66/255, green: 66/255, blue: 66/255, alpha: 1)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func segueToLContentsViewController() {
        self.performSegue(withIdentifier: "toLContentsViewController", sender: nil)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! CustomCell
        cell.placelabel.text = contents[indexPath.row].place
        cell.startlabel.text = contents[indexPath.row].starttime
        cell.endlabel.text = contents[indexPath.row].endtime
        cell.backgroundColor = ColorManager.tablecolor
        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contents.count ?? 0
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        content = contents[indexPath.row]
        if content != nil {
            performSegue(withIdentifier: "toLContentsView", sender: nil)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        if (segue.identifier == "toLContentsView"){
            let LC: LContentsViewController = (segue.destination as? LContentsViewController)!
            LC.contents = contents
        }
    }
    
    func refreshTableView() {
        sleep(1)
        tableView.reloadData()
        refreshControl?.endRefreshing()
    }


}

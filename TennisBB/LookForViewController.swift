
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
    
    var boards = [Board]()
    var board: Board?
    var bid = [String]()
    var database: Firestore = Firestore.firestore()
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib
        database.collection("Boards").getDocuments(completion: { (documents, error) in
            if error == nil {
                print("gotdocuments")
                self.boards.removeAll()
                for document in documents!.documents {
                    print("\(document.documentID) => \(document.data())")
                    self.boards.append(Board(dic: document.data()))
                    self.bid.append("\(document.documentID)")
                }
                self.tableView.reloadData()
            }else{
                print("didn't getdocuments")
            }
        })
        self.tableView.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "customCell")
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(refreshTableView), for: UIControlEvents.valueChanged)
        self.refreshControl = refresh
        self.view.backgroundColor = ColorManager.maincolor
        tableView.tableFooterView = UIView(frame: .zero)
        navigationController?.navigationBar.barTintColor = ColorManager.barcolor
        navigationController?.navigationBar.tintColor = UIColor(red: 66/255, green: 66/255, blue: 66/255, alpha: 1)
        navigationItem.rightBarButtonItem = editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        self.tableView.setEditing(editing, animated: animated)
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return indexPath.row == boards.count
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        //削除処理
        database.collection("Boards").document("\(bid[indexPath.row])").delete() { err in
            if let err = err {
                print("didn't delete")
            } else {
                print("delete complete")
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func segueToLContentsViewController() {
        self.performSegue(withIdentifier: "toLContentsViewController", sender: nil)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! CustomCell
        cell.placelabel.text = boards[indexPath.row].place
        cell.startlabel.text = "\(boards[indexPath.row].startTime + 8)時"
        cell.endlabel.text = "\(boards[indexPath.row].endTime + 8)時"
        cell.backgroundColor = ColorManager.tablecolor
        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return boards.count
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        board = boards[indexPath.row]
        if board != nil {
            performSegue(withIdentifier: "toLContentsView", sender: nil)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        if (segue.identifier == "toLContentsView"){
            let LC: LContentsViewController = (segue.destination as? LContentsViewController)!
            LC.boards = boards
            LC.board = board
        }
    }
    
    func refreshTableView() {
        sleep(1)
        tableView.reloadData()
        refreshControl?.endRefreshing()
    }


}

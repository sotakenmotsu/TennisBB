//
//  RecruitmentViewController.swift
//  TennisBB
//
//  Created by 剱物蒼太 on 2017/01/11.
//  Copyright © 2017年 剱物蒼太. All rights reserved.
//

import UIKit
import Foundation
import Firebase

class RecruitmentViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
//    let realm = try! Realm()
//    var contents: Results<Contents>? = nil
    var board: Board?
    var boards = [Board]()
    var refresh: UIRefreshControl!
    @IBOutlet var newpostbutton: UIButton!
    var database: Firestore = Firestore.firestore()
    var bid = [String]()
    var row: Int!


    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        database.collection("Boards").getDocuments(completion: { (documents, error) in
            if error == nil {
                print("gotdocuments")
                self.boards.removeAll()
                self.bid.removeAll()
                for document in documents!.documents {
                    //                    print("\(document.documentID) => \(document.data())")
                    self.boards.append(Board(dic: document.data()))
                    self.bid.append("\(document.documentID)")
                }
                self.tableView.reloadData()
            }else{
                print("didn't getdocuments")
            }
        })
        self.tableView.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "customCell")
        self.refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(refreshTableView), for: UIControlEvents.valueChanged)
        self.tableView.addSubview(refresh)
        self.view.backgroundColor = ColorManager.maincolor
        newpostbutton.backgroundColor = ColorManager.buttoncolor
        newpostbutton.setTitleColor(.white, for: .normal)
        tableView.tableFooterView = UIView(frame: .zero)
        self.tabBarController?.tabBar.barTintColor = ColorManager.barcolor
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
        cell.placelabel.text = boards[indexPath.row].place
        cell.startlabel.text = "\(boards[indexPath.row].startTime + 8)時"
        cell.endlabel.text = "\(boards[indexPath.row].endTime + 8)時"
        cell.backgroundColor = ColorManager.tablecolor
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return boards.count ?? 0
    }
    
    func showalert(indexPath: IndexPath) {
        let alert: UIAlertController = UIAlertController(title: "この投稿を削除します", message: "よろしいですか？", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title:"キャンセル", style: .cancel))
        alert.addAction(UIAlertAction(title: "削除", style: .destructive, handler: { action in
            self.database.collection("Boards").document("\(self.bid[indexPath.row])").delete() { err in
                if let err = err {
                    print("didn't delete")
                    self.refreshTableView()
                } else {
                    print("delete complete")
                }
            } }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deletebutton: UITableViewRowAction = UITableViewRowAction(style: .normal, title: "削除") {
            (action, index) -> Void in self.showalert(indexPath: indexPath)
        }
        return [deletebutton]
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "削除"
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.showalert(indexPath: indexPath)
        }
    }
    
    func segueToLContentsViewController() {
        self.performSegue(withIdentifier: "toRContentsVEViewController", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        board = boards[indexPath.row]
        if board != nil {
            performSegue(withIdentifier: "toRContentsVEView", sender: nil)
        }
        row = indexPath.row
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        if (segue.identifier == "toRContentsVEView"){
            let RC: RecruitmentContentsViewEditViewController = (segue.destination as? RecruitmentContentsViewEditViewController)!
            RC.board = board
            RC.row = row
        }
    }

    
    func refreshTableView() {
        sleep(1)
        database.collection("Boards").getDocuments(completion: { (documents, error) in
            if error == nil {
                print("gotdocuments")
                self.boards.removeAll()
                self.bid.removeAll()
                for document in documents!.documents {
                    //                    print("\(document.documentID) => \(document.data())")
                    self.boards.append(Board(dic: document.data()))
                    self.bid.append("\(document.documentID)")
                }
                self.tableView.reloadData()
            }else{
                print("didn't getdocuments")
            }
        })
        refresh.endRefreshing()
    }
    
    @IBAction func postbutton() {
        self.view.backgroundColor = ColorManager.buttoncolor
    }


    

    /*
     MARK: - Navigation

     In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         Get the new view controller using segue.destinationViewController.
         Pass the selected object to the new view controller.
    }
    */

}


//
//  RContentsVEViewController.swift
//  TennisBB
//
//  Created by 剱物蒼太 on 2018/02/06.
//  Copyright © 2018年 剱物蒼太. All rights reserved.
//

import UIKit
import Foundation

class RContentsVEViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    var board: Board?
    var boards = [Board]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        let sizewidth = UIScreen.main.bounds.size.width
        let headerView = HeaderView.instantiate()
        headerView.frame = CGRect(x: 0, y: 0, width: sizewidth, height: 340)
        headerView.setContents(contents: board!, isHidden: false)
        tableView.tableHeaderView = headerView
        self.view.backgroundColor = ColorManager.maincolor
        tableView.tableFooterView = UIView(frame: .zero)

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var Content = segue.destination as! HeaderView
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "articleCell")!
        return cell
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    @IBAction func back(segue: UIStoryboardSegue) {
        
    }
}

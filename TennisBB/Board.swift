//
//  Board.swift
//  TennisBB
//
//  Created by 剱物蒼太 on 2017/11/28.
//  Copyright © 2017年 剱物蒼太. All rights reserved.
//

import UIKit
import Foundation

class Board  {
    
    var place = ""
    var date: Int!
    var startTime: Int!
    var endTime: Int!
    var member: Int!
    var level: Int!
    var comment = ""
    var uid = ""
    
    init(dic: [String: Any]) {
        self.place = dic["place"] as! String
        self.date = dic["date"] as! Int
        self.startTime = dic["start"] as! Int
        self.endTime = dic["end"] as! Int
        self.member = dic["member"] as! Int
        self.level = dic["level"] as! Int
        self.comment = dic["comment"] as! String
        
    }
    
    func toDictionary() -> [String: Any] {
        let dic: [String: Any] = ["place": self.place,
                                  "date": self.date,
                                  "start": self.startTime,
                                  "end": self.endTime,
                                  "member": self.member,
                                  "level": self.level,
                                  "comment": self.comment]
        return dic
    }

}









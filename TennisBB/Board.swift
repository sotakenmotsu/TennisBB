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
    var date = ""
    var startTime: Int!
    var endTime: Int!
    var member: Int!
    var level: Int!
    var comment = ""
    var uid = ""
    
    convenience init(dic: [String: Any]) {
        self.init()
        self.place = dic["place"] as! String
        self.date = dic["date"] as! String
        self.startTime = dic["start"] as! Int
        self.endTime = dic["end"] as! Int
        self.member = dic["member"] as! Int
        self.level = dic["level"] as! Int
        self.comment = dic["comment"] as! String
        self.uid = dic["uid"] as! String
        
    }
    
    convenience init(place: String, date: String, startTime: Int, endTime: Int, member: Int, level: Int, comment: String, uid: String) {
        self.init()
        self.place = place
        self.date = date
        self.startTime = startTime
        self.endTime = endTime
        self.member = member
        self.level = level
        self.comment = comment
        self.uid = uid
    }
    
    func toDictionary() -> [String: Any] {
        let dic: [String: Any] = ["place": self.place,
                                  "date": self.date,
                                  "start": self.startTime,
                                  "end": self.endTime,
                                  "member": self.member,
                                  "level": self.level,
                                  "comment": self.comment,
                                  "uid": self.uid]
        return dic
    }

}









//
//  Realm.swift
//  TennisBB
//
//  Created by 剱物蒼太 on 2017/02/09.
//  Copyright © 2017年 剱物蒼太. All rights reserved.
//

import UIKit
import Foundation

class Content {
    
     var place = ""
     var date = ""
     var starttime = ""
     var endtime = ""
     var member = ""
     var level = ""
     var comment = ""
    
     var id = 0
    
    init(dic: [String: Any]) {
        
        self.comment = dic["a"] as! String
    }
    
    func toDictionary() -> [String: Any] {
        
        let dic: [String: Any] = ["comment": self.comment]
        return dic
    }
    
}

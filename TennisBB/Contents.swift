//
//  Realm.swift
//  TennisBB
//
//  Created by 剱物蒼太 on 2017/02/09.
//  Copyright © 2017年 剱物蒼太. All rights reserved.
//

import UIKit
import Foundation
import RealmSwift

class Contents: Object {
    
    dynamic var place = ""
    dynamic var starttime = ""
    dynamic var endtime = ""
    dynamic var member = ""
    dynamic var level = ""
    dynamic var comment = ""
    
    static let realm = try! Realm()
    
    dynamic var id = 0
    override static func primaryKey() -> String? {
        return "id"
    }
    
    static func loadAll() -> [Contents] {
        let contents = realm.objects(Contents.self)
        var ret: [Contents] = []
        for content in contents {
            ret.append(content)
        }
        return ret
    }
}

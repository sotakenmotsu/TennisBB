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

class Realm: Object {
    dynamic var place = ""
    dynamic var starttime: Int = 0
    dynamic var endtime: Int = 0
    dynamic var member: Int = 0
    dynamic var level = ""
    dynamic var comment = ""

    }

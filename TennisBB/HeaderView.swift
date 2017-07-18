//
//  HeaderView.swift
//  TennisBB
//
//  Created by 剱物蒼太 on 2017/07/08.
//  Copyright © 2017年 剱物蒼太. All rights reserved.
//

import UIKit
import Foundation
import RealmSwift

class HeaderView: UIView {
    
    static func instantiate() -> HeaderView {
        let view = Bundle.main.loadNibNamed("HeaderView", owner: self, options: nil)?.first as! HeaderView
        return view
    }
    
    @IBOutlet var place: UILabel!
    @IBOutlet var date: UILabel!
    @IBOutlet var Stime: UILabel!
    @IBOutlet var Etime: UILabel!
    @IBOutlet var member: UILabel!
    @IBOutlet var level: UILabel!
    @IBOutlet var comment: UILabel!
    
    func setContents(contents: Contents) {
        place.text = contents.place
        date.text = contents.date
        Stime.text = contents.starttime
        Etime.text = contents.endtime
        member.text = contents.member
        level.text = contents.level
        comment.text = contents.comment
    }
        

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

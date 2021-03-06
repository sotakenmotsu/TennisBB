//
//  HeaderView.swift
//  TennisBB
//
//  Created by 剱物蒼太 on 2017/07/08.
//  Copyright © 2017年 剱物蒼太. All rights reserved.
//

import UIKit
import Foundation

protocol HeaderViewDelegate: class {
    func back()
    func edit()
}

class HeaderView: UIView {
    
    weak var delegate: HeaderViewDelegate?
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
    @IBOutlet var back: UIButton!
    @IBOutlet var edit: UIButton!
    
    func setContents(contents: Board, isHidden: Bool) {
        place.text = contents.place
        place.textColor = UIColor.black
        date.text = contents.date
        date.textColor = UIColor.black
        Stime.text = "\(contents.startTime + 8)時"
        Stime.textColor = UIColor.black
        Etime.text = "\(contents.endTime + 8)時"
        Etime.textColor = UIColor.black
        member.text = "\(contents.member + 0)人"
        member.textColor = UIColor.black
        level.text = "Lv.\(contents.level + 0)"
        level.textColor = UIColor.black
        comment.text = contents.comment
        comment.textColor = UIColor.black
        back.setTitleColor(.white, for: .normal)
        edit.setTitleColor(.white, for: .normal)
        back.isHidden = isHidden
        edit.isHidden = isHidden
    }
    
    @IBAction func backButton() {
         delegate?.back()
    }
    
    @IBAction func editButton() {
        delegate?.edit()
    }


    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}


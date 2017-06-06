//
//  CustomCell.swift
//  TennisBB
//
//  Created by 剱物蒼太 on 2017/06/06.
//  Copyright © 2017年 剱物蒼太. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    @IBOutlet var placelabel: UILabel!
    @IBOutlet var startlabel: UILabel!
    @IBOutlet var endlabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

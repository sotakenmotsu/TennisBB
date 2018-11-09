//
//  SearchViewControllerTableViewCell.swift
//  TennisBB
//
//  Created by 剱物蒼太 on 2018/06/29.
//  Copyright © 2018年 剱物蒼太. All rights reserved.
//

import UIKit

class SearchViewControllerTableViewCell: UITableViewCell {
    
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

//
//  TableViewCell.swift
//  TheHomeOfWatch
//
//  Created by qianfeng on 16/9/21.
//  Copyright © 2016年 ZQ. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var imageV: UIImageView!
    
    
    @IBOutlet weak var titleL: UILabel!
    
    @IBOutlet weak var timeL: UILabel!
    
    @IBOutlet weak var brandL: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

//
//  HotPointTableViewCell.swift
//  TheHomeOfWatch
//
//  Created by qianfeng on 16/9/24.
//  Copyright © 2016年 ZQ. All rights reserved.
//

import UIKit

class HotPointTableViewCell: UITableViewCell {

    @IBOutlet weak var hotImageView: UIImageView!
    
    @IBOutlet weak var hotTitleL: UILabel!
    
    @IBOutlet weak var hotReadL: UILabel!
    
    @IBOutlet weak var hotCommentL: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        hotTitleL.font = UIFont.boldSystemFontOfSize(15)
    
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

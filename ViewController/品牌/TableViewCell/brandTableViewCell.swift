//
//  brandTableViewCell.swift
//  TheHomeOfWatch
//
//  Created by qianfeng on 16/9/22.
//  Copyright © 2016年 ZQ. All rights reserved.
//

import UIKit

class brandTableViewCell: UITableViewCell {

    
    @IBOutlet weak var ImageView: UIImageView!
        
    @IBOutlet weak var brandname1L: UILabel!
    
    @IBOutlet weak var brandname2L: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        brandname2L.font = UIFont.boldSystemFontOfSize(17)
    
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

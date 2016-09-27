//
//  MoreViewController.swift
//  TheHomeOfWatch
//
//  Created by qianfeng on 16/9/20.
//  Copyright © 2016年 ZQ. All rights reserved.
//

import UIKit

class MoreViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "更多"
        let bar = self.navigationController?.navigationBar
        let image = UIImage.init(named: "navigationBg")?.stretchableImageWithLeftCapWidth(160, topCapHeight: 22)
        bar?.setBackgroundImage(image, forBarMetrics: .Default)
        bar?.titleTextAttributes = [NSFontAttributeName:UIFont.systemFontOfSize(20),NSForegroundColorAttributeName:UIColor.whiteColor()]
    }

    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

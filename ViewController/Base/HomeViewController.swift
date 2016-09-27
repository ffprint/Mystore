//
//  HomeViewController.swift
//  TheHomeOfWatch
//
//  Created by qianfeng on 16/9/20.
//  Copyright © 2016年 ZQ. All rights reserved.
//

import UIKit
import Foundation

let SCREEN_W = UIScreen.mainScreen().bounds.size.width
let SCREEN_H = UIScreen.mainScreen().bounds.size.height

//获取滚动视图的接口
let kImage = "app/articleimage"
//获取资讯的接口
let kList = "app/articlelist"
//获取选品牌的接口
let kBrandList = "app/brandlist"
//主URL
let Base_URL = "http://www.xbiao.com/"
let kSearch = "app/productsearch/"
//获取城市列表
let kCity = "app/GetCityBybid/bid/"
//获取论坛上的导航数据
let kNav = "bbs2/nav/loginid/0/loginkey/0"
//全部表款 列表
let kProductList = "app/productList/"
let kProductDetail = "app/productDetail/"

let kShowMap = "app/shopMap/"
//登录
let kLogin = "mobile/login"
//发送建议
let kAdvise = "app/advise"




let SPACE = CGFloat(SCREEN_W - 320)/6

let barView = UIImageView.init(frame: CGRectMake(0, 0, 64, 49))

class HomeViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.barTintColor = UIColor.whiteColor()
        self.createVC()
        self.createTabbar()
    }
    
    func createVC() -> Void {
        let ne = NewsViewController()
        let br = BrandViewController()
        let dy = DynamicViewController()
        let my = MyViewController()
        let mo = MoreViewController()
        let vcArr = [ne,br,dy,my,mo]
        var i = 0
        var naviControllers = [UINavigationController]()
        for vc in vcArr {
            let nav = UINavigationController.init(rootViewController: vc)
            naviControllers.append(nav)
            i += 1
            
            
        }
        self.viewControllers = naviControllers
        
    }

    func createTabbar() -> Void{
        
        let image = UIImage.init(named: "zl")?.stretchableImageWithLeftCapWidth(15, topCapHeight: 15)
        self.tabBar.backgroundImage = image
        
        
        let array = self.tabBar.subviews
        for btnView in array {
            btnView.removeFromSuperview()
        }
        let btnArr = ["7_tab1","7_tab2","7_tab3","7_tab4","7_tab5"]
        let btnArr1 = ["7_tab1_s","7_tab2_s","7_tab3_s","7_tab4_s","7_tab5_s"]
        for i in 0...4 {
            let btn = UIButton.init(type: UIButtonType.Custom)
            btn.frame = CGRectMake(64*CGFloat(i)+SPACE*CGFloat(i+1), 0, 64, 49)
            btn.setBackgroundImage(UIImage.init(named: btnArr[i]), forState: UIControlState.Normal)
            
            
            
            btn.setBackgroundImage(UIImage.init(named: btnArr1[i]), forState: UIControlState.Selected)
            btn.tag = 200 + i
            btn.addTarget(self, action: #selector(self.btnClick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            self.tabBar.addSubview(btn)
            
            if i == 0 {
                barView.center = btn.center
            }
        }
        barView.userInteractionEnabled = true
        barView.image = UIImage.init(named: btnArr1[0])
        self.tabBar.addSubview(barView)
        
    }
    
    func  btnClick(sender:UIButton) -> Void {
        self.selectedIndex = sender.tag - 200
        let index = sender.tag - 200
        let btnArr1 = ["7_tab1_s","7_tab2_s","7_tab3_s","7_tab4_s","7_tab5_s"]
        barView.image = UIImage.init(named: btnArr1[index])
        barView.center = sender.center
    }
   
}

//
//  BrandViewController.swift
//  TheHomeOfWatch
//
//  Created by qianfeng on 16/9/20.
//  Copyright © 2016年 ZQ. All rights reserved.
//

import UIKit

class BrandViewController: UIViewController {

    //section
    var groupArr = [[brandModel]]()
    //每个section内表的信息
    var brandArr = [brandModel]()
    
    let tableView = UITableView()
    
    var keys = NSMutableArray()
    
    //?var???
    var varlues = NSMutableArray()
    
    var dic = NSDictionary()
    //装大写字母
    var charArr = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "腕表品牌大全"
        
        //设置导航栏内容
        let bar = self.navigationController?.navigationBar
        let image = UIImage.init(named: "navigationBg")?.stretchableImageWithLeftCapWidth(160, topCapHeight: 22)
        bar?.setBackgroundImage(image, forBarMetrics: .Default)
        bar?.titleTextAttributes = [NSFontAttributeName:UIFont.systemFontOfSize(20),NSForegroundColorAttributeName:UIColor.whiteColor()]
        //创建tableView
        self.createTableView()
        //加载tableView中的数据
        self.loadTableViewData()
        
//        tableView.sectionIndexBackgroundColor = UIColor.redColor()
//        tableView.sectionIndexColor = UIColor.darkGrayColor()
    }
    
    func createTableView() -> Void {
            tableView.frame = CGRectMake(0, 50, SCREEN_W, SCREEN_H-64)
            tableView.showsVerticalScrollIndicator = false
            tableView.delegate = self
            tableView.dataSource = self
            tableView.rowHeight = 80
            tableView.registerNib(UINib.init(nibName: "brandTableViewCell", bundle: nil), forCellReuseIdentifier: "brandTableViewCell")
            self.view.addSubview(tableView)
    }
    
    //MARK:A~Z字母与数字的转换
    func intFromChar(c:String) -> Int {
        return (c.unicodeScalars.last?.hashValue)!
    }
    func charFromInt(i:Int) -> String {
        return String.init(Character.init(UnicodeScalar.init(i)))
    }    
    
    func loadTableViewData() -> Void {
        //http://www.xbiao.com/app/brandlist
        let str = "http://www.xbiao.com/app/brandlist"
        
        let manager = AFHTTPSessionManager()
        manager.responseSerializer = AFHTTPResponseSerializer()
        manager.GET(str, parameters: nil, progress: nil, success: { (task, downloadData) in
            UIApplication.sharedApplication().networkActivityIndicatorVisible = true
            self.dic = try! NSJSONSerialization.JSONObjectWithData(downloadData as! NSData, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
            //print(downloadData)
            
            for i in self.intFromChar("A")...self.intFromChar("Z"){
                
                if self.dic[self.charFromInt(i)] == nil {
                    continue
                }
            
                self.charArr.addObject(self.charFromInt(i))
                
                let arr = self.dic[self.charFromInt(i)] as! NSMutableArray
                for i in 0...arr.count-1 {
                    let model = brandModel()
                    model.img = arr[i]["img"] as? String
                    model.Ename = arr[i]["ename"] as? String
                    model.Cname = arr[i]["name"] as? String
                    model.id = arr[i]["brandid"] as? NSNumber
                    print(model.id)
                   // print(model.img)
                    self.brandArr.append(model)
                }
                self.groupArr.append(self.brandArr)
                self.brandArr.removeAll()
            }
            
            self.tableView.reloadData()

            }) { (task, error) in
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                print("品牌tableView数据传输发生错误")
        }
    }

}

//MARK:品牌页面tableView
extension BrandViewController:UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.groupArr.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.groupArr[section].count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("brandTableViewCell", forIndexPath: indexPath) as! brandTableViewCell
        
        let model = groupArr[indexPath.section][indexPath.row]
        print(model.img)
        cell.ImageView!.sd_setImageWithURL(NSURL.init(string: model.img!))
        cell.brandname1L.text = model.Ename
        cell.brandname2L.text = model.Cname

        return cell
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.charArr[section] as? String
    }
    
    //点击品牌cell进入页面
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let brandDetailVC = BrandDetailViewController()
        let idModel = groupArr[indexPath.section][indexPath.row]
        brandDetailVC.upTitle = idModel.Cname
        brandDetailVC.brandId = idModel.id
        print(idModel.id)
        brandDetailVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(brandDetailVC, animated: true)
    }

}

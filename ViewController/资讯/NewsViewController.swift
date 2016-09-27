//
//  NewsViewController.swift
//  TheHomeOfWatch
//
//  Created by qianfeng on 16/9/20.
//  Copyright © 2016年 ZQ. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {

    @IBOutlet weak var hotPointBtn: UIButton!
    
    @IBOutlet weak var brandBtn: UIButton!
    
    @IBOutlet weak var newsBtn: UIButton!
    
//    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var LabelView: UIView!
    
    @IBOutlet weak var detailLabel: UILabel!
    
//    @IBOutlet weak var tableView: UITableView!
    
    var downData = NSMutableData()
    var downData1 = NSMutableData()
    let picArr = NSMutableArray()
    var tabModelArr = [Home1Model]()
    
    var i = 0

    //大的scrollView
    var bigScrollView = UIScrollView()
    var tableView = UITableView()
    var scrollView = UIScrollView()
    
    
    var hotPointTableView = UITableView()
    //装热点模型
    var  hotPointArr = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "腕表之家"
        let bar = self.navigationController?.navigationBar
        let image = UIImage.init(named: "navigationBg")?.stretchableImageWithLeftCapWidth(160, topCapHeight: 22)
        bar?.setBackgroundImage(image, forBarMetrics: .Default)
        bar?.titleTextAttributes = [NSFontAttributeName:UIFont.systemFontOfSize(20),NSForegroundColorAttributeName:UIColor.whiteColor()]
        self.view.backgroundColor = UIColor .whiteColor()
        
//        //大的scrollView
        bigScrollView.frame = CGRectMake(0,30, SCREEN_W, SCREEN_H)
        bigScrollView.contentSize = CGSizeMake(SCREEN_W*3, 0)
        bigScrollView.contentOffset = CGPointMake(0, 0)
        bigScrollView.pagingEnabled = true
        bigScrollView.bounces = false
        self.view.addSubview(bigScrollView)
        
        self.tableView.registerNib(UINib.init(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        
        tableView.frame = CGRectMake(0, 200, SCREEN_W, SCREEN_H-64-200-49-25)
        tableView.rowHeight = 80
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.loadScrollViewData()
        self.loadTableViewData()
        //http://www.xbiao.com/app/articleimage scrollView内显示的信息
        
        //scrollView的设置
        scrollView.frame = CGRectMake(0, 0, SCREEN_W, 200)
        scrollView.contentSize = CGSizeMake(CGFloat(SCREEN_W*5), 0)
        scrollView.contentOffset.x = 0
        scrollView.delegate = self
        scrollView.bounces = false
        scrollView.pagingEnabled = true
        
        scrollView.userInteractionEnabled = true
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(self.imageTouch(_:)))
        scrollView.addGestureRecognizer(tap)
        bigScrollView.addSubview(scrollView)
        bigScrollView.addSubview(tableView)
        
        
        hotPointTableView.frame = CGRectMake(SCREEN_W, 0, SCREEN_W, SCREEN_H-64-80)
        bigScrollView.addSubview(hotPointTableView)
        hotPointTableView.delegate = self
        hotPointTableView.dataSource = self
        hotPointTableView.rowHeight = 80
        self.hotPointTableView.registerNib(UINib.init(nibName: "HotPointTableViewCell", bundle: nil), forCellReuseIdentifier: "HotPointTableViewCell")
        
        //
        self.loadHotPointData()
    }

    //点击scrollView上的图片,进入下一个页面
    func imageTouch(sender:UIImageView) {
        
    }
    
    // 热点 按键
    @IBAction func hotPointBtn(sender: AnyObject) {
        print("111")
        
        //MARK:热点tableView
        //http://www.xbiao.com/app/articlelist?&page=0&type=2  热点页面
    
        bigScrollView.setContentOffset(CGPointMake(SCREEN_W, 0), animated: true)
        
    }
    // 品牌 按键
    @IBAction func brandBtn(sender: AnyObject) {
        bigScrollView.setContentOffset(CGPointMake(SCREEN_W*2, 0), animated: true)
        
    }
    // 资讯 按键
    @IBAction func newsBtn(sender: AnyObject) {
        bigScrollView.setContentOffset(CGPointMake(0, 0), animated: true)
    }
    
//    //MARK:开始请求scrollView的网络数据
    func loadScrollViewData() -> Void {
        let str = "http://www.xbiao.com/app/articleimage"
        let url = NSURL.init(string: str)
        let request = NSURLRequest.init(URL: url!)
        _ = NSURLConnection.init(request: request, delegate: self)
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    }
    //MARK:开始请求tableView的网络数据
    func loadTableViewData() -> Void {
        let str = "http://www.xbiao.com/app/articlelist?&pages=0&type=1"
        let manager = AFHTTPSessionManager()
        manager.responseSerializer = AFHTTPResponseSerializer()
        manager.GET(str, parameters: nil, progress: nil, success: { (task, downloadData) in
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            let dic = try! NSJSONSerialization.JSONObjectWithData(downloadData as! NSData, options: NSJSONReadingOptions.MutableContainers) as! [NSDictionary]
            for watchDic in dic {
                let model = Home1Model()
                model.title = watchDic["title"] as! String
                model.brand_name = watchDic["brand_name"] as? String
                model.inputtime = watchDic["inputtime"] as! String
                model.image = watchDic["img"] as! String
                model.url = watchDic["url"] as! String
                self.tabModelArr.append(model)
            }
            
            self.tableView.reloadData()
            
            }) { (task, error) in
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                print("解析发生错误")
        }       
    }
    
    func loadHotPointData()->Void {
        let str = "http://www.xbiao.com/app/articlelist?&page=0&type=2"
        let manager = AFHTTPSessionManager()
        manager.responseSerializer = AFHTTPResponseSerializer()
        manager.GET(str, parameters: nil, progress: nil, success: { (task, downloadData) in
            UIApplication.sharedApplication().networkActivityIndicatorVisible = true
            let arr = try! NSJSONSerialization.JSONObjectWithData(downloadData as! NSData, options: NSJSONReadingOptions.MutableContainers) as! [NSDictionary]
            for modelDic in arr {
                let model = hotModel()
                model.img = modelDic["img"] as! String
                model.title = modelDic["title"] as! String
                model.commentCount = modelDic["comment_count"] as! String
                model.readCount = modelDic["hits"] as! NSNumber
                model.url = modelDic["url"] as! String
                self.hotPointArr.addObject(model)
            }
            self.hotPointTableView.reloadData()
            }) { (task, error) in
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                print("热点页面tableView数据请求出错")
        }
    }
}

//MARK:处理scrollView的网络请求
extension NewsViewController:NSURLConnectionDataDelegate {
    
    func connection(connection: NSURLConnection, didReceiveResponse response: NSURLResponse) {
        downData.length = 0
    }
    func connection(connection: NSURLConnection, didReceiveData data: NSData) {
        downData.appendData(data)
//        print(downData)
    }
    func connectionDidFinishLoading(connection: NSURLConnection) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        let dataArr = try! NSJSONSerialization.JSONObjectWithData(downData, options: NSJSONReadingOptions.AllowFragments) as! NSArray
        for i in 0...dataArr.count-1 {
            let model = HomeModel()
            let adDic = dataArr[i] as! NSDictionary
            model.title = adDic["title"] as! String
            model.img = adDic["img"] as! String
//            model.url = adDic["url"] as! String
            picArr.addObject(model.img)
            
            let imageV = UIImageView.init(frame: CGRectMake(SCREEN_W*CGFloat(i), 0, SCREEN_W, scrollView.frame.size.height))
            
            let label = UILabel.init(frame: CGRectMake(0, 181, SCREEN_W, 20))
            label.text = model.title
            label.backgroundColor = UIColor.lightGrayColor()
            
            label.font = UIFont.systemFontOfSize(14)
            label.textColor = UIColor.whiteColor()
            label.textAlignment = .Center
            imageV.tag = 20 + i
            imageV.userInteractionEnabled = true
            imageV.addSubview(label)
            imageV.sd_setImageWithURL(NSURL.init(string: model.img))
            scrollView.addSubview(imageV)
            imageV.userInteractionEnabled = true
        }
    }
    func connection(connection: NSURLConnection, didFailWithError error: NSError) {
        print("出错")
    }
}

//MARK:设置tableView
extension NewsViewController:UITableViewDelegate,UITableViewDataSource {

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == self.tableView {
            return tabModelArr.count
        }else if tableView == hotPointTableView {
            return hotPointArr.count
        }
        
        return 1
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if tableView == self.tableView {
            let cell = tableView.dequeueReusableCellWithIdentifier("TableViewCell", forIndexPath: indexPath) as! TableViewCell
            
            let model = tabModelArr[indexPath.row]
            cell.titleL.text = model.title
            cell.imageV.sd_setImageWithURL(NSURL.init(string: model.image))
            cell.timeL.text = model.inputtime
            cell.brandL.text = model.brand_name
            
            return cell

        }else if tableView == hotPointTableView {
            let cell = tableView.dequeueReusableCellWithIdentifier("HotPointTableViewCell", forIndexPath: indexPath) as! HotPointTableViewCell
            let model = hotPointArr[indexPath.row] as! hotModel
            cell.hotImageView.sd_setImageWithURL(NSURL.init(string: model.img))
            cell.hotTitleL.text = model.title
            cell.hotReadL.text = String.init(format: "\(model.readCount)次阅读")
            cell.hotCommentL.text = String.init(format: "\(model.commentCount)条评论")
            return cell

        }
        
//        if bigScrollView.contentOffset.x == 0 {
//        let cell = tableView.dequeueReusableCellWithIdentifier("TableViewCell", forIndexPath: indexPath) as! TableViewCell
//        
//        let model = tabModelArr[indexPath.row] 
//        cell.titleL.text = model.title
//        cell.imageV.sd_setImageWithURL(NSURL.init(string: model.image))
//        cell.timeL.text = model.inputtime
//        cell.brandL.text = model.brand_name
//        
//        return cell
//        }else if bigScrollView.contentOffset.x == SCREEN_W {
//            let cell = tableView.dequeueReusableCellWithIdentifier("HotPointTableViewCell", forIndexPath: indexPath) as! HotPointTableViewCell
//            let model = hotPointArr[indexPath.row] as! hotModel
//            cell.hotImageView.sd_setImageWithURL(NSURL.init(string: model.img))
//            cell.hotTitleL.text = model.title
//            cell.hotReadL.text = String.init(format: "\(model.readCount)")
//            cell.hotCommentL.text = model.commentCount            
//            return cell
//        }
        let cell = UITableViewCell()
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
        if tableView == self.tableView {
            let cellDetail = cellDetailViewController()
            let model = self.tabModelArr[indexPath.row]
            cellDetail.str = model.url
            
            cellDetail.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(cellDetail, animated: true)

        }else if tableView == hotPointTableView {
            let cellHot = cellDetailViewController()
            let model = self.hotPointArr[indexPath.row] as! hotModel
            cellHot.str = model.url
            cellHot.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(cellHot, animated: true)
        }
        
//        if bigScrollView.contentOffset.x == 0 {
//        let cellDetail = cellDetailViewController()
//        let model = self.tabModelArr[indexPath.row] 
//        cellDetail.str = model.url
//        
//        cellDetail.hidesBottomBarWhenPushed = true
//        self.navigationController?.pushViewController(cellDetail, animated: true)
//            
//        }else if bigScrollView.contentOffset.x == SCREEN_W {
//            let cellHot = cellDetailViewController()
//            let model = self.hotPointArr[indexPath.row] as! hotModel
//            cellHot.str = model.url
//            cellHot.hidesBottomBarWhenPushed = true
//            self.navigationController?.pushViewController(cellHot, animated: true)
//        }
    }
}

//
extension NewsViewController:UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        //self.loadImg()
//        print(1111)
//        if scrollView.contentOffset.x == 0{
//            scrollView.contentOffset = CGPointMake(SCREEN_W*4, 0)
//        }else if scrollView.contentOffset.x == SCREEN_W*4 {
//            scrollView.contentOffset.x = SCREEN_W
//        }
//        
//        print("111111111")
    }
}
//
//  BrandDetailViewController.swift
//  TheHomeOfWatch
//
//  Created by qianfeng on 16/9/24.
//  Copyright © 2016年 ZQ. All rights reserved.
//

import UIKit


// 品牌 页面二级页面
class BrandDetailViewController: UIViewController {

//    @varutlet weak var buttonView: UIView!
//    //是个按钮
//    @IBOutlet weak var seriesBtn: UIButton!
//    @IBOutlet weak var allKindBtn: UIButton!
//    @IBOutlet weak var agencyBtn: UIButton!
//    @IBOutlet weak var introBtn: UIButton!
    let headerView = UIView()
    var selectView = UIImageView()
    var pickerHeaderView = UIView()
    
    var brandId:NSNumber?
    var URLString:String?
    var upTitle:String?
    let brandWebView = UIWebView()
    let WebView = UIWebView()
    
    var urlIndex = NSInteger()
    var strUrl = NSString()
    let homeUrl = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = upTitle
        
        WebView.frame = CGRectMake(0, 50, SCREEN_W, SCREEN_H-100)
        self.view.addSubview(WebView)
        
        URLString = String.init(format:"http://www.xbiao.com/app/seriesList/bid/%d", brandId as! Int)
        
        let url = NSURL.init(string: URLString!)
        let request = NSURLRequest.init(URL: url!)
        WebView.loadRequest(request)
        WebView.delegate = self
        
        urlIndex = 0
        
        self.creatView()
        
    }
    
    func creatView() -> Void {
        //
        headerView.frame = CGRectMake(0, 0, SCREEN_W, 50)
        headerView.backgroundColor = UIColor.init(patternImage: UIImage.init(named: "toolbg")!)
        self.view.addSubview(headerView)
        // _selectView是button背景图片
        selectView = UIImageView.init(frame: CGRectMake(0, 0, 85, 40))
        selectView.image = UIImage.init(named: "light")
        headerView.addSubview(selectView)
        let arr = ["系列","全部表款","经销商","简介"]
        for i in 0...3 {
            let btn = UIButton.init(type: UIButtonType.Custom)
            btn.frame = CGRectMake(SCREEN_W/4*CGFloat(i), 10, 80, 30)
            btn.setTitle(arr[i], forState: UIControlState.Normal)
            btn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
            btn.addTarget(self, action: #selector(self.selectViewAction), forControlEvents: UIControlEvents.TouchUpInside)
            btn.tag = 300 + i
            if i == 0 {
                selectView.center = btn.center
                btn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            }
            headerView.addSubview(btn)
        }
        //经销商页面的相关设置
        pickerHeaderView.frame = CGRectMake(0, 50, SCREEN_W, 40)
        let image = UIImage.init(named: "city")
        image?.stretchableImageWithLeftCapWidth(50, topCapHeight: 0)
        let pickImgView = UIImageView.init(frame: pickerHeaderView.bounds)
        pickImgView.image = image
        pickerHeaderView.addSubview(pickImgView)
        
        //pickerHeaderView 上有两个添加手势的label
        let label1 = UILabel.init(frame:  CGRectMake(5, 0, pickerHeaderView.frame.size.width-120, 40))
        label1.text = "不限城市"
        label1.userInteractionEnabled = true
        label1.textAlignment = .Left
        label1.tag = 1000
        pickerHeaderView.addSubview(label1)
        let tap1 = UITapGestureRecognizer.init(target: self, action: #selector(self.cityAction))
        label1.addGestureRecognizer(tap1)
        
        let label2 = UILabel.init(frame: CGRectMake(label1.frame.size.width+5, 0, SCREEN_W-pickerHeaderView.frame.size.width+120-5, 40))
        label2.textAlignment = .Left
        label2.text = "维修点"
        label2.userInteractionEnabled = true
        label2.tag = 1001
        pickerHeaderView.addSubview(label2)
        let tap2 = UITapGestureRecognizer.init(target: self, action: #selector(self.cityAction))
        label2.addGestureRecognizer(tap2)
        
        self.view.addSubview(pickerHeaderView)
        pickerHeaderView.hidden = true
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func selectViewAction(btn:UIButton) -> Void {
        selectView.center = btn.center
        let arr = headerView.subviews
        for btnView in arr {
            if btnView .isKindOfClass(UIButton) {
                let btn1 = btnView as! UIButton
                if btn1.tag != btn.tag {
                    btn1.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
                }
            }
        }
        btn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        // 系列 按钮
        if btn.tag == 300 {
            urlIndex = 0
            WebView.transform = CGAffineTransformIdentity
            
            WebView.frame = CGRectMake(0, 50, SCREEN_W, SCREEN_H-100)
            
            WebView.frame.size.height = SCREEN_H - 100
            pickerHeaderView.hidden = true
            self.loadData(String.init(format: "app/seriesList/bid/%d", self.brandId as! Int))
        }else if btn.tag == 301 {
            urlIndex = 1
            WebView.transform = CGAffineTransformIdentity
            
            WebView.frame = CGRectMake(0, 50, SCREEN_W, SCREEN_H-100)
            
            WebView.frame.size.height = SCREEN_H - 100
            pickerHeaderView.hidden = true
            self.loadData(String.init(format: "app/productList/bid/%d", self.brandId as! Int))
            //点击 经销商 按钮
        }else if btn.tag == 302 {
            urlIndex = 2
            WebView.transform = CGAffineTransformIdentity
            WebView.frame.size.height = SCREEN_H - 140
            WebView.frame.origin.y = 90
            pickerHeaderView.hidden = false
            self.loadData(String.init(format: "app/shopList/bid/%d", self.brandId as! Int))
        }else if btn.tag == 303 {
            WebView.transform = CGAffineTransformIdentity
            
            WebView.frame = CGRectMake(0, 50, SCREEN_W, SCREEN_H-100)
            
            WebView.frame.size.height = SCREEN_H - 100
            pickerHeaderView.hidden = true
            self.loadData(String.init(format: "app/BrandIntro/bid/%d", self.brandId as! Int))
        }
    }
    // pickView上面显示的内容
    func cityAction() -> Void {
        
    }
    
    func loadData(linkStr:String) -> Void {
        let str = Base_URL.stringByAppendingString(linkStr)
        let request = NSMutableURLRequest.init(URL: NSURL.init(string: str)!)
        WebView.loadRequest(request)
    }
}

extension BrandDetailViewController:UIWebViewDelegate {
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        let url = request.URL?.absoluteString
        let arr = url!.componentsSeparatedByString(":")
        var str = NSString()
        
        for i in 0...arr.count-1 {
            var str1 = NSString()
            if arr[i] == "http" {
                return true
            }else if arr[i] == "eq" || arr[i] == "and" {
                str1 = "/"
                str = str.stringByAppendingString(str1 as String)
                
            }else {
                str = str.stringByAppendingString(arr[i])
            }
        }
        var title = NSString()
        var idIndex = NSString()
        if urlIndex == 0 {
            strUrl = kProductList
        }else if urlIndex == 1 {
            strUrl = kProductDetail
            title = "腕表详情" //全部表款 页面 点击cell 进入页面title
            let inde:Int =  arr.indexOf("pid")!
            idIndex = arr[inde + 2]
            
        }else {
            strUrl = kShowMap
            title = "经销商详情" //经销商页面 点击cell 进入地图页面title
        }
        let a:NSInteger = arr.indexOf("title")!
//        let b:String = arr[a+2]
        if title.length == 0 && arr[a+2] != "" {
            title = arr[a+2]
            title = title.stringByReplacingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        }
        str = strUrl.stringByAppendingString(str as String)
        let brandContentVC = BrandContentViewController()
        brandContentVC.linkStr = Base_URL.stringByAppendingString(str as String)
        brandContentVC.title = title as String
        brandContentVC.watchId = idIndex
        self.navigationController?.pushViewController(brandContentVC, animated: true)
        return true
    }
}


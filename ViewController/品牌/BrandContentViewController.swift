//
//  BrandContentViewController.swift
//  TheHomeOfWatch
//
//  Created by qianfeng on 16/9/27.
//  Copyright © 2016年 ZQ. All rights reserved.
//

import UIKit

// 品牌页面   三级页面
class BrandContentViewController: UIViewController {

    var linkStr:String = ""
    var watchId = NSString()
    
    var shareView = UIView()
    var webView = UIWebView()
    var scrollView = UIScrollView()
    override func viewDidLoad() {
        super.viewDidLoad()

        scrollView.frame = self.view.bounds
        self.view.addSubview(scrollView)
        webView.frame = CGRectMake(0, 0, SCREEN_W, 0)
        webView.frame.size.height = SCREEN_H - 64 - 45
        webView.delegate = self
        webView.contentMode = UIViewContentMode.ScaleAspectFit
        scrollView.addSubview(webView)
        let request = NSMutableURLRequest.init(URL: NSURL.init(string: linkStr)!)
        webView.loadRequest(request)
        //let str = Base_URL.stringByAppendingString(linkStr)
//        let request = NSMutableURLRequest.init(URL: NSURL.init(string: str)!)
//        WebView.loadRequest(request)
        if self.title == "腕表详情" || self.title == "腕表咨询" {
            
        }
    
    }
    
    func initViews() -> Void {
        shareView.frame = CGRectMake(0, SCREEN_W-110, SCREEN_W, 49)
        shareView.backgroundColor = UIColor.lightGrayColor()
        //在一个父视图上两个子视图中插入一个新子视图
        self.view.insertSubview(shareView, aboveSubview: webView)
        let btnImg = ["inf_detail_pl.png","a_love.png","inf_detail_fx.png","goTop.png"]
        for i in 0...3 {
            let btn = UIButton.init(type: UIButtonType.Custom)
            btn.frame = CGRectMake((SCREEN_W/4 - 30)*CGFloat(i)+20 , 10, 30, 30)
            if i == 3 {
                btn.frame.origin.x = SCREEN_W - 60
            }
            btn.tag = i
            btn.addTarget(self, action: #selector(self.shareAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        }
    
    }

    func shareAction(btn:UIButton) -> Void {
        if btn.tag == 2 {
            let alertCtrl = UIAlertController.init(title: "'", message: "", preferredStyle: UIAlertControllerStyle.ActionSheet)
            let cancelAction = UIAlertAction.init(title: "取消", style: UIAlertActionStyle.Cancel, handler: nil)
            let sinaAction = UIAlertAction.init(title: "分享到新浪微博", style: UIAlertActionStyle.Default, handler: { (action) in
                
                let shareContentVC = ShareContentViewController()
                shareContentVC.title = "分享到新浪微博"
                shareContentVC.urlStr = String.init(format: "app/shareContent/type/2/id/%@/share/weibo", self.watchId)
                self.navigationController?.pushViewController(shareContentVC, animated: true)
            })
            //腾讯分享
            let tencentAction = UIAlertAction.init(title: "分享到腾讯微博", style: UIAlertActionStyle.Default, handler: { (action) in
                
            })
            //微信朋友圈
            let weixinAction = UIAlertAction.init(title: "分享到微信朋友圈", style: UIAlertActionStyle.Default, handler: { (action) in
                
            })
            alertCtrl.addAction(sinaAction)
            alertCtrl.addAction(tencentAction)
            alertCtrl.addAction(weixinAction)
            alertCtrl.addAction(cancelAction)
            self.presentViewController(alertCtrl, animated: true, completion:nil)
                
        }else if btn.tag == 3 {  //回到最上
            scrollView.setContentOffset(CGPointMake(0, 0), animated: true)
        }
    }
        
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension BrandContentViewController:UIWebViewDelegate {

}

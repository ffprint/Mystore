//
//  cellDetailViewController.swift
//  TheHomeOfWatch
//
//  Created by qianfeng on 16/9/23.
//  Copyright © 2016年 ZQ. All rights reserved.
//

import UIKit

class cellDetailViewController: UIViewController {
    
    var str:String? = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let WebView = UIWebView.init(frame: CGRectMake(0, 0, SCREEN_W, SCREEN_H-64))
        self.view.addSubview(WebView)
        let url = NSURL.init(string: str!)
        let request = NSURLRequest.init(URL: url!)
        WebView.loadRequest(request)
        WebView.delegate = self
        
        print(str)
    }
}
extension cellDetailViewController:UIWebViewDelegate {
    //开始加载
    override func animationDidStart(anim: CAAnimation) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    }
    //加载完成
    func webViewDidFinishLoad(webView: UIWebView) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        
        print("加载网页出现问题")
    }

}
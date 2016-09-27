//
//  Model.swift
//  TheHomeOfWatch
//
//  Created by qianfeng on 16/9/21.
//  Copyright © 2016年 ZQ. All rights reserved.
//

import UIKit

//资讯页面:scrollView模型
class HomeModel: JSONModel {
    
    var title:String!  //图片标题
    var imgID:String!  //图片ID
//    var url:String! //图片对应的链接
    var img:String!   //图片链接
    
    override class func propertyIsOptional(property:String)->Bool
    {
        return true
    }
    override class func keyMapper()->JSONKeyMapper
    {
        return JSONKeyMapper.mapperFromUnderscoreCaseToCamelCase()
    }
    
}

//资讯页面:tableView模型
class Home1Model: JSONModel {
    
    var title:String! //表的简介
    var inputtime:String! //时间
    var brand_name:String! //品牌名字
    var hits:String!  //点击数
    var  comment_count:String!  //评论数
    var author_name:String!  //作者
    var theme:Int!  //主题
    var post:Int!  //帖数
    var image:String!  //图片链接
    var name:String!  //品牌名
    var url:String!  //cell点击进去显示的页面
    
    override class func propertyIsOptional(property:String)->Bool
    {
        return true
    }
    override class func keyMapper()->JSONKeyMapper
    {
        return JSONKeyMapper.mapperFromUnderscoreCaseToCamelCase()
    }
}

class hotModel: JSONModel {
    var title:String!
    var readCount:NSNumber!
    var commentCount:String!
    var url:String!
    var img:String!
}

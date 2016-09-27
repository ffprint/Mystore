//
//  BrandModel.swift
//  TheHomeOfWatch
//
//  Created by qianfeng on 16/9/23.
//  Copyright © 2016年 ZQ. All rights reserved.
//

import Foundation

class brandGrounpModel: JSONModel {
    
    var grounp:brandModel?
    
    override class func propertyIsOptional(property:String)->Bool
    {
        return true
    }
    override class func keyMapper()->JSONKeyMapper
    {
        return JSONKeyMapper.mapperFromUnderscoreCaseToCamelCase()
    }
}

class brandModel: JSONModel {
    
    var img:String?
    var Ename:String?
    var Cname:String?
    var id:NSNumber?
//    override class func propertyIsOptional(property:String)->Bool
//    {
//        return true
//    }
//    override class func keyMapper()->JSONKeyMapper
//    {
//        return JSONKeyMapper.mapperFromUnderscoreCaseToCamelCase()
//    }
//
//    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
//        
//    }
//    required init(data: NSData!) throws {
//        try!super.init(data: data)
//        fatalError("init(data:) has not been implemented")
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    required init(dictionary dict: [NSObject : AnyObject]!) throws {
//        fatalError("init(dictionary:) has not been implemented")
//    }

    
    
}
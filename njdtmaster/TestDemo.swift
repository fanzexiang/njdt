//
//  TestDemo.swift
//  njdtmaster
//
//  Created by 尹浩 on 2018/1/15.
//  Copyright © 2018年 尹浩. All rights reserved.
//

import Foundation

var jsonString:NSString = "{\"names\":[\"James\",\"Jobs\",\"Tom\"]}" as NSString
let jsonData = jsonString.dataUsingEncoding(NSUTF8StringEncoding)

if let jsonObj:NSDictionary = NSJSONSerialization.JSONObjectWithData(jsonData!, options: NSJSONReadingOptions.MutableContainers, error: nil) as? NSDictionary {
    
    //操作之前
    print(jsonObj) //James, Jobs, Tom
    
    if let nameArray:NSMutableArray = jsonObj["names"] as? NSMutableArray {
        
        nameArray.addObject("Cook")
        
    }
    
    //操作之后
    print(jsonObj) //James, Jobs, Tom, Cook
    
}

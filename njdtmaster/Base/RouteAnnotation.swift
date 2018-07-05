//
//  RouteAnnotation.swift
//  njdtmaster
//
//  Created by ihoou on 2018/5/22.
//  Copyright © 2018年 尹浩. All rights reserved.
//

import UIKit
class RouteAnnotation: BMKPointAnnotation {
    
    var type: Int!///<0:起点 1：终点 2：公交 3：地铁 4:驾乘 5:途经点
    var degree: Int!
    
    override init() {
        super.init()
    }
    
    init(type: Int, degree: Int) {
        self.type = type
        self.degree = degree
    }
    
}


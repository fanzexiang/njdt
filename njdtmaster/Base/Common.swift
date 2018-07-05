//
//  Common.swift
//  njdtmaster
//
//  Created by 尹浩 on 2018/2/28.
//  Copyright © 2018年 尹浩. All rights reserved.
//

import UIKit

struct Common {
    // Swift 中， static let 才是真正可靠好用的单例模式
    static let screenWidth = UIScreen.main.bounds.maxX
    static let screenHeight = UIScreen.main.bounds.maxY
//    static let rootViewController = UIApplication.shared.keyWindow?.rootViewController as! ResuceTaskViewController
//    static let contactsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Contacts")
    
}


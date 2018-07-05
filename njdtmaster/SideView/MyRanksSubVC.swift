//
//  MyRanksSubViewController.swift
//  njdtmaster
//
//  Created by 尹浩 on 2018/3/14.
//  Copyright © 2018年 尹浩. All rights reserved.
//

import UIKit

class MyRanksSubVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.barTintColor = UIColor(red:0,green:0.58,blue:0.475,alpha:1.0)
        let item = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)//titile为空，只显示向左箭头
        item.tintColor = UIColor.white
        self.navigationItem.backBarButtonItem = item
        // 设置标题
        let titleL = UILabel()
        titleL.text = CommonData.TITLE_SIDE_MY_RANK
        titleL.textColor = UIColor.white
        titleL.textAlignment = NSTextAlignment.natural
        titleL.font=UIFont.boldSystemFont(ofSize: 17)
        titleL.sizeToFit()
        self.navigationItem.titleView = titleL
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
}

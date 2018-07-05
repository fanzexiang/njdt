//
//  SafeMyInfoVC.swift
//  njdtmaster
//
//  Created by ihoou on 2018/6/5.
//  Copyright © 2018年 尹浩. All rights reserved.
//

import UIKit

class SafeMyInfoVC: UIViewController {
    @IBOutlet weak var companyName: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var imei: UILabel!
    @IBOutlet weak var version: UILabel!
    @IBOutlet weak var lastLoginTime: UILabel!
    @IBOutlet weak var hotline: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.barTintColor = UIColor(red:0,green:0.58,blue:0.475,alpha:1.0)
        let item = UIBarButtonItem(image: UIImage(named: "list_left"), style: .plain, target: self, action: #selector(self.openSideMenu))
        item.tintColor = UIColor.white
        self.navigationItem.leftBarButtonItem = item
        // 设置标题
        let titleL = UILabel()
        titleL.text = CommonData.TITLE_APP_NAME
        titleL.textColor = UIColor.white
        titleL.textAlignment = NSTextAlignment.natural
        titleL.font=UIFont.boldSystemFont(ofSize: 18)
        titleL.sizeToFit()
        self.navigationItem.titleView = titleL
        companyName.text = CommonData.INSURE_NAME
        userName.text = CommonData.STAFF_NAME
        imei.text = CommonData.TERMINAL_IDENTIFICATION
        version.text = "1.0"
        lastLoginTime.text = CommonData.LAST_LOGIN_TIME
        hotline.text = "18963609523"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @objc func openSideMenu(){
        let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
        appDelegate.rootVC.openSideVC()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

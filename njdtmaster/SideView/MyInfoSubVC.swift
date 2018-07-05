//
//  MyInfoSubViewController.swift
//  njdtmaster
//
//  Created by 尹浩 on 2018/3/14.
//  Copyright © 2018年 尹浩. All rights reserved.
//
import UIKit

class MyInfoSubVC: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.title = "个人信息"
        self.navigationController?.navigationBar.tintColor = UIColor.white;
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        
        //带背景和边框
        let label1 = UILabel()
        label1.frame = CGRect(x:8, y:99 + CommonData.ADD_ADAPTATION_HEIGHT, width:CommonData.ADMIN_SRCEEN_WIDTH - 16, height:34)
        label1.backgroundColor = UIColor.white
        label1.textAlignment = NSTextAlignment.center
        //边框设置圆角
        label1.layer.cornerRadius = 4
        label1.layer.borderWidth = 1
        label1.layer.borderColor = UIColor.gray.cgColor
        view.addSubview(label1)
        //单位名称
        let companyNameIV = UIImageView(image: UIImage(named: "ic_setting_company"))
        let companyNameL = UILabel()
        let companyName = UILabel()
        companyNameL.text = CommonData.COMPANY_NAME_L
        companyName.text = CommonData.MAINT_NAME
        companyNameL.font = UIFont.systemFont(ofSize: 12)
        if CommonData.MAINT_NAME.count > 18 {
            companyName.font = UIFont.systemFont(ofSize: 11)
        }else{
            companyName.font = UIFont.systemFont(ofSize: 12)
        }
        companyNameIV.frame = CGRect(x:16 ,y:106 + CommonData.ADD_ADAPTATION_HEIGHT, width:20, height:20)
        companyNameL.frame = CGRect(x:46 ,y:106 + CommonData.ADD_ADAPTATION_HEIGHT, width:60, height:22)
        companyName.frame = CGRect(x:126 ,y:106 + CommonData.ADD_ADAPTATION_HEIGHT, width:260, height:22)
        companyNameL.textAlignment = NSTextAlignment.left
        companyName.textAlignment = NSTextAlignment.left
        companyName.textColor = UIColor.orange
        view.addSubview(companyNameIV)
        view.addSubview(companyNameL)
        view.addSubview(companyName)
        //带背景和边框
        let label2 = UILabel()
        label2.frame = CGRect(x:8, y:132 + CommonData.ADD_ADAPTATION_HEIGHT, width:CommonData.ADMIN_SRCEEN_WIDTH - 16, height:34)
        label2.backgroundColor = UIColor.white
        label2.textAlignment = NSTextAlignment.center
        //边框设置圆角
        label2.layer.cornerRadius = 4
        label2.layer.borderWidth = 1
        label2.layer.borderColor = UIColor.gray.cgColor
        view.addSubview(label2)
        //用户姓名
        let userNameIV = UIImageView(image: UIImage(named: "ic_setting_user"))
        let userNameL = UILabel()
        let userName = UILabel()
        userNameL.text = CommonData.USER_NAME_L
        userName.text = CommonData.STAFF_NAME
        userNameL.font = UIFont.systemFont(ofSize: 12)
        userName.font = UIFont.systemFont(ofSize: 12)
        userNameIV.frame = CGRect(x:16 ,y:139 + CommonData.ADD_ADAPTATION_HEIGHT, width:20, height:20)
        userNameL.frame = CGRect(x:46 ,y:139 + CommonData.ADD_ADAPTATION_HEIGHT, width:60, height:22)
        userName.frame = CGRect(x:126 ,y:139 + CommonData.ADD_ADAPTATION_HEIGHT, width:260, height:22)
        userNameL.textAlignment = NSTextAlignment.left
        userName.textAlignment = NSTextAlignment.left
        userName.textColor = UIColor.orange
        view.addSubview(userNameIV)
        view.addSubview(userNameL)
        view.addSubview(userName)
        //带背景和边框
        let label3 = UILabel()
        label3.frame = CGRect(x:8, y:165 + CommonData.ADD_ADAPTATION_HEIGHT, width:CommonData.ADMIN_SRCEEN_WIDTH - 16, height:34)
        label3.backgroundColor = UIColor.white
        label3.textAlignment = NSTextAlignment.center
        //边框设置圆角
        label3.layer.cornerRadius = 4
        label3.layer.borderWidth = 1
        label3.layer.borderColor = UIColor.gray.cgColor
        view.addSubview(label3)
        //终端标识
        let terminalIdentificationIV = UIImageView(image: UIImage(named: "ic_setting_client"))
        let terminalIdentificationL = UILabel()
        let terminalIdentification = UILabel()
        terminalIdentificationL.text = CommonData.TERMINAL_IDENTIFICATION_L
        terminalIdentification.text = CommonData.TERMINAL_IDENTIFICATION
        terminalIdentificationL.font = UIFont.systemFont(ofSize: 12)
        terminalIdentification.font = UIFont.systemFont(ofSize: 11)
        terminalIdentificationIV.frame = CGRect(x:16 ,y:172 + CommonData.ADD_ADAPTATION_HEIGHT, width:20, height:20)
        terminalIdentificationL.frame = CGRect(x:46 ,y:172 + CommonData.ADD_ADAPTATION_HEIGHT, width:60, height:22)
        terminalIdentification.frame = CGRect(x:126 ,y:172 + CommonData.ADD_ADAPTATION_HEIGHT, width:260, height:22)
        terminalIdentificationL.textAlignment = NSTextAlignment.left
        terminalIdentification.textAlignment = NSTextAlignment.left
        terminalIdentification.textColor = UIColor.orange
        view.addSubview(terminalIdentificationIV)
        view.addSubview(terminalIdentificationL)
        view.addSubview(terminalIdentification)
        //带背景和边框
        let label4 = UILabel()
        label4.frame = CGRect(x:8, y:221 + CommonData.ADD_ADAPTATION_HEIGHT, width:CommonData.ADMIN_SRCEEN_WIDTH - 16, height:34)
        label4.backgroundColor = UIColor.white
        label4.textAlignment = NSTextAlignment.center
        //边框设置圆角
        label4.layer.cornerRadius = 4
        label4.layer.borderWidth = 1
        label4.layer.borderColor = UIColor.gray.cgColor
        view.addSubview(label4)
        //软件版本
        let applicationVersionIV = UIImageView(image: UIImage(named: "ic_setting_version"))
        let applicationVersionL = UILabel()
        let applicationVersion = UILabel()
        applicationVersionL.text = CommonData.APPLICATION_VERSION_L
        applicationVersion.text = CommonData.APPLICATION_VERSION
        applicationVersionL.font = UIFont.systemFont(ofSize: 12)
        applicationVersion.font = UIFont.systemFont(ofSize: 12)
        applicationVersionIV.frame = CGRect(x:16 ,y:226 + CommonData.ADD_ADAPTATION_HEIGHT, width:20, height:20)
        applicationVersionL.frame = CGRect(x:46 ,y:226 + CommonData.ADD_ADAPTATION_HEIGHT, width:60, height:22)
        applicationVersion.frame = CGRect(x:126 ,y:226 + CommonData.ADD_ADAPTATION_HEIGHT, width:260, height:22)
        applicationVersionL.textAlignment = NSTextAlignment.left
        applicationVersion.textAlignment = NSTextAlignment.left
        applicationVersion.textColor = UIColor.orange
        view.addSubview(applicationVersionIV)
        view.addSubview(applicationVersionL)
        view.addSubview(applicationVersion)
        //带背景和边框
        let label5 = UILabel()
        label5.frame = CGRect(x:8, y:254 + CommonData.ADD_ADAPTATION_HEIGHT, width:CommonData.ADMIN_SRCEEN_WIDTH - 16, height:34)
        label5.backgroundColor = UIColor.white
        label5.textAlignment = NSTextAlignment.center
        //边框设置圆角
        label5.layer.cornerRadius = 4
        label5.layer.borderWidth = 1
        label5.layer.borderColor = UIColor.gray.cgColor
        view.addSubview(label5)
        //上次登陆时间
        let lastLoginTimeIV = UIImageView(image: UIImage(named: "ic_setting_lasttime"))
        let lastLoginTimeL = UILabel()
        let lastLoginTime = UILabel()
        lastLoginTimeL.text = CommonData.LAST_LOGIN_TIME_L
        lastLoginTime.text = CommonData.LAST_LOGIN_TIME
        lastLoginTimeL.font = UIFont.systemFont(ofSize: 12)
        lastLoginTime.font = UIFont.systemFont(ofSize: 12)
        lastLoginTimeIV.frame = CGRect(x:16 ,y:261 + CommonData.ADD_ADAPTATION_HEIGHT,width:20,height:20)
        lastLoginTimeL.frame = CGRect(x:46 ,y:261 + CommonData.ADD_ADAPTATION_HEIGHT,width:80,height:22)
        lastLoginTime.frame = CGRect(x:126 ,y:261 + CommonData.ADD_ADAPTATION_HEIGHT,width:260,height:22)
        lastLoginTimeL.textAlignment = NSTextAlignment.left
        lastLoginTime.textAlignment = NSTextAlignment.left
        lastLoginTime.textColor = UIColor.orange
        view.addSubview(lastLoginTimeIV)
        view.addSubview(lastLoginTimeL)
        view.addSubview(lastLoginTime)
        //带背景和边框
        let label6 = UILabel()
        label6.frame = CGRect(x:8, y:287 + CommonData.ADD_ADAPTATION_HEIGHT, width:CommonData.ADMIN_SRCEEN_WIDTH - 16, height:34)
        label6.backgroundColor = UIColor.white
        label6.textAlignment = NSTextAlignment.center
        //边框设置圆角
        label6.layer.cornerRadius = 4
        label6.layer.borderWidth = 1
        label6.layer.borderColor = UIColor.gray.cgColor
        view.addSubview(label6)
        //客服热线
        let customerHotlineIV = UIImageView(image: UIImage(named: "ic_setting_service"))
        let customerHotlineL = UILabel()
        let customerHotline = UILabel()
        customerHotlineL.text = CommonData.CUSTOMER_HOTLINE_L
        customerHotline.text = CommonData.CUSTOMER_HOTLINE
        customerHotlineL.font = UIFont.systemFont(ofSize: 12)
        customerHotline.font = UIFont.systemFont(ofSize: 12)
        customerHotlineIV.frame = CGRect(x:16 ,y:294 + CommonData.ADD_ADAPTATION_HEIGHT,width:20,height:20)
        customerHotlineL.frame = CGRect(x:46 ,y:294 + CommonData.ADD_ADAPTATION_HEIGHT,width:60,height:22)
        customerHotline.frame = CGRect(x:126 ,y:294 + CommonData.ADD_ADAPTATION_HEIGHT,width:260,height:22)
        customerHotlineL.textAlignment = NSTextAlignment.left
        customerHotline.textAlignment = NSTextAlignment.left
        customerHotline.textColor = UIColor.orange
        view.addSubview(customerHotlineIV)
        view.addSubview(customerHotlineL)
        view.addSubview(customerHotline)
        //带背景和边框
        let label7 = UILabel()
        label7.frame = CGRect(x:8, y:342 + CommonData.ADD_ADAPTATION_HEIGHT, width:CommonData.ADMIN_SRCEEN_WIDTH - 16, height:34)
        label7.backgroundColor = UIColor.white
        label7.textAlignment = NSTextAlignment.center
        //边框设置圆角
        label7.layer.cornerRadius = 4
        label7.layer.borderWidth = 1
        label7.layer.borderColor = UIColor.gray.cgColor
        view.addSubview(label7)
        //缓存清理
        let cacheCleanupIV = UIImageView(image: UIImage(named: "icon_safecheck_wbdw"))
        let cacheCleanupL = UILabel()
        let cacheCleanup = UILabel()
        cacheCleanupL.text = CommonData.CACHE_CLEANUP_L
        cacheCleanup.text = CommonData.CACHE_CLEANUP
        cacheCleanupL.font = UIFont.systemFont(ofSize: 12)
        cacheCleanup.font = UIFont.systemFont(ofSize: 12)
        cacheCleanupIV.frame = CGRect(x:16 ,y:348 + CommonData.ADD_ADAPTATION_HEIGHT,width:20,height:20)
        cacheCleanupL.frame = CGRect(x:46 ,y:348 + CommonData.ADD_ADAPTATION_HEIGHT,width:60,height:22)
        cacheCleanup.frame = CGRect(x:126 ,y:348 + CommonData.ADD_ADAPTATION_HEIGHT,width:260,height:22)
        cacheCleanupL.textAlignment = NSTextAlignment.left
        cacheCleanup.textAlignment = NSTextAlignment.left
        cacheCleanup.textColor = UIColor.orange
        view.addSubview(cacheCleanupIV)
        view.addSubview(cacheCleanupL)
        view.addSubview(cacheCleanup)
        //设置点击时间
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector(("doCleanupCache:")))
        cacheCleanup.addGestureRecognizer(tap)
    }
    func doCleanupCache(sender:UITapGestureRecognizer) {
        let toast = ToastView()
        print("并未进行清理，仅仅打印！后续实现")
        toast.showToast(text: "应用缓存已经清理", pos: .Bottom)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
}

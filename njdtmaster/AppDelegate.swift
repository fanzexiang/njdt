//
//  AppDelegate.swift
//  njdtmaster
//
//  Created by 尹浩 on 2018/1/12.
//  Copyright © 2018年 尹浩. All rights reserved.
//

import UIKit
import AdSupport

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, BMKGeneralDelegate,JPUSHRegisterDelegate{
  
    var window: UIWindow?
    var _mapManager: BMKMapManager?
    var rootVC :XYSideViewControllerSwift!
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // 要使用百度地图，请先启动BaiduMapManager
        _mapManager = BMKMapManager()
        /**
         *百度地图SDK所有接口均支持百度坐标（BD09）和国测局坐标（GCJ02），用此方法设置您使用的坐标类型.
         *默认是BD09（BMK_COORDTYPE_BD09LL）坐标.
         *如果需要使用GCJ02坐标，需要设置CoordinateType为：BMK_COORDTYPE_COMMON.
         */
        if BMKMapManager.setCoordinateTypeUsedInBaiduMapSDK(BMK_COORDTYPE_BD09LL) {
            NSLog("经纬度类型设置成功");
        } else {
            NSLog("经纬度类型设置失败");
        }
        // 如果要关注网络及授权验证事件，请设定generalDelegate参数
        let ret = _mapManager?.start("1YWVEflaeVgs67YoNijztRx8stzXlRCo", generalDelegate: self)
        if ret == false {
            NSLog("manager start failed!")
        }
        
        //
        let entity = JPUSHRegisterEntity();
        entity.types = Int(JPAuthorizationOptions.alert.rawValue) |  Int(JPAuthorizationOptions.sound.rawValue) | Int(JPAuthorizationOptions.badge.rawValue);
        JPUSHService.register(forRemoteNotificationConfig: entity, delegate: self);
        let advertisingId = ASIdentifierManager.shared().advertisingIdentifier.uuidString
        JPUSHService.setup(withOption: launchOptions, appKey: "f22997b15d456e1b6a16424c", channel: "App Store", apsForProduction: false, advertisingIdentifier: advertisingId)
         NotificationCenter.default.addObserver(self, selector: #selector(networkDidReceiveMessage(notification:)), name: NSNotification.Name.jpfNetworkDidReceiveMessage, object: nil)
        
        return true
    }
    func loadMainView(){
        
        let sideVC = SideViewController()
        
        let currentMainVC = UITabBarController.init()
        //设置标签页底部样式
        currentMainVC.self.tabBar.isTranslucent = false
        currentMainVC.self.tabBar.backgroundImage = UIImage(named:"bg_tabbar")
        currentMainVC.self.tabBar.tintColor = UIColor.white
        currentMainVC.self.view.backgroundColor = UIColor.white
        //维保单位
        let navResuceTask = UINavigationController(rootViewController: ResuceTaskVC())
        let navMyResuce = UINavigationController(rootViewController: MyResuceVC())
        let navMaintPlan = UINavigationController(rootViewController: MaintPlanVC())
        let navMyMaint = UINavigationController(rootViewController: MyMaintVC())
        navResuceTask.tabBarItem.title = "救援任务"
        navResuceTask.tabBarItem.image = UIImage(named:"icon_task_normal")
        navMyResuce.tabBarItem.title = "我的救援"
        navMyResuce.tabBarItem.image = UIImage(named:"icon_rescue_normal")
        navMaintPlan.tabBarItem.title = "维保计划"
        navMaintPlan.tabBarItem.image = UIImage(named:"icon_setting_normal")
        navMyMaint.tabBarItem.title = "我的维保"
        navMyMaint.tabBarItem.image = UIImage(named:"icon_rank_normal")
        //使用单位
        let navUserResuceRemind = UINavigationController(rootViewController: UserRescueRemindVC())
        navUserResuceRemind.tabBarItem.title = "困人提醒"
        navUserResuceRemind.tabBarItem.image = UIImage(named: "icon_task_press")
        let navUserResuceRecord = UINavigationController(rootViewController: UserRescueRecordVC())
        navUserResuceRecord.tabBarItem.title = "困人记录"
        navUserResuceRecord.tabBarItem.image = UIImage(named: "icon_setting_normal")
        let navMaintRemind = UINavigationController(rootViewController: UserMaintRemindVC())
        navMaintRemind.tabBarItem.title = "维保提醒"
        navMaintRemind.tabBarItem.image = UIImage(named: "icon_task_press")
        let navInspectRemind = UINavigationController(rootViewController: UserInspectRemindVC())
        navInspectRemind.tabBarItem.title = "检验提醒"
        navInspectRemind.tabBarItem.image = UIImage(named: "icon_rescue_normal")
        //保险公司
        let navSafeCheckPlan = UINavigationController(rootViewController: SafeCheckPlanVC())
        navSafeCheckPlan.tabBarItem.title = "维保抽查"
        navSafeCheckPlan.tabBarItem.image = UIImage(named: "icon_rescue_normal")
        let navMySafeCheck = UINavigationController(rootViewController: SafeMyCheckVC())
        navMySafeCheck.tabBarItem.title = "我的抽查"
        navMySafeCheck.tabBarItem.image = UIImage(named: "icon_task_press")
        let navSafeMyInfo = UINavigationController(rootViewController: SafeMyInfoVC())
        navSafeMyInfo.tabBarItem.title = "我的信息"
        navSafeMyInfo.tabBarItem.image = UIImage(named: "icon_setting_normal")
        
        let deptType = CommonData.DEPT_TYPE
        if deptType == "0"{
            print("维保单位角色")
            currentMainVC.viewControllers = [navResuceTask, navMyResuce, navMaintPlan, navMyMaint]
        }else if deptType == "1"{
            print("保险公司角色")
            currentMainVC.viewControllers = [navSafeCheckPlan, navMySafeCheck,navSafeMyInfo]
        }else {
            print("使用单位角色")
            currentMainVC.viewControllers = [navUserResuceRemind, navUserResuceRecord, navMaintRemind, navInspectRemind]
        }
        rootVC = XYSideViewControllerSwift(sideVC, currentMainVC)
        window?.rootViewController = rootVC
        window?.makeKeyAndVisible()
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this   is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    //MARK: - BMKGeneralDelegate
    func onGetNetworkState(_ iError: Int32) {
        if (0 == iError) {
            NSLog("联网成功");
        }
        else{
            NSLog("联网失败，错误代码：Error\(iError)");
        }
    }
    
    func onGetPermissionState(_ iError: Int32) {
        if (0 == iError) {
            NSLog("授权成功");
        }
        else{
            NSLog("授权失败，错误代码：Error\(iError)");
        }
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        JPUSHService.registerDeviceToken(deviceToken)
    }
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print(error)
    }
    
    
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, willPresent notification: UNNotification!, withCompletionHandler completionHandler: ((Int) -> Void)!) {
        let userInfo = notification.request.content.userInfo;
        if notification.request.trigger is UNPushNotificationTrigger {
            JPUSHService.handleRemoteNotification(userInfo);
        }
        completionHandler(Int(UNNotificationPresentationOptions.alert.rawValue))
    }
    
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, didReceive response: UNNotificationResponse!, withCompletionHandler completionHandler: (() -> Void)!) {
        let userInfo = response.notification.request.content.userInfo
        if response.notification.request.trigger is UNPushNotificationTrigger {
            JPUSHService.handleRemoteNotification(userInfo)
        }
        completionHandler()
      
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        JPUSHService.handleRemoteNotification(userInfo)
        completionHandler(UIBackgroundFetchResult.newData)
    }
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        JPUSHService.handleRemoteNotification(userInfo)
    }
    @objc func networkDidReceiveMessage(notification: Notification) {
       
        print("---------------");
    }

}


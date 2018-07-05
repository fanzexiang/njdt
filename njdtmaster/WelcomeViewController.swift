//
//  WelcomViewController.swift
//  njdtmaster
//
//  Created by 尹浩 on 2018/2/7.
//  Copyright © 2018年 尹浩. All rights reserved.
//

import UIKit
import AdSupport
import Alamofire
import SwiftyJSON


class WelcomeViewController: UIViewController{
    
    //在控制器定义全局的可变data，用户存储接收的数据
    var jsonData:NSMutableData = NSMutableData()
    var uuid:String!
    override func viewDidLoad(){
        super.viewDidLoad()
        uuid = ASIdentifierManager.shared().advertisingIdentifier.uuidString
        uuid = uuid.replacingOccurrences(of: "-", with: "")
        CommonData.TERMINAL_IDENTIFICATION = uuid
        if UIDevice.current.modelName.contains("Plus") {
            print("设备型号：\(UIDevice.current.modelName)")
            CommonData.ADD_ADAPTATION_HEIGHT = 20 //设置屏幕尺寸适配
            CommonData.ADD_ADADTATION_MAX_HEIGHT = 2
        }else if UIDevice.current.modelName.contains("X"){
            print("设备型号：\(UIDevice.current.modelName)")
            CommonData.ADD_ADAPTATION_HEIGHT = 30 //设置屏幕尺寸适配
            CommonData.ADD_ADADTATION_MAX_HEIGHT = 24
        }else{
            print("设备型号：\(UIDevice.current.modelName)")
        }
        //调用登陆接口
        Alamofire.request(CommonData.CONSTANT_PATH_POST_MAINT, method: .post, parameters: ["data":"{\"txcode\":\"\(CommonData.TXCODE_LOGIN)\",\"imei\":\"\(uuid as String)\"}"], encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result.isSuccess {
            case true:
                if let value = response.result.value {
                    let json = JSON(value)
                    let loginFlag = json["rescode"].string!
                    let time: TimeInterval = 2.3
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time) {
                        if loginFlag == "0" {
                            CommonData.MAINT_ID = json["data"]["maintId"].string!
                            CommonData.MAINT_NAME = json["data"]["maintName"].string!
                            CommonData.INSURE_ID = json["data"]["insureId"].string!
                            CommonData.INSURE_NAME = json["data"]["insureName"].string!
                            CommonData.COMPANY_ID = json["data"]["companyId"].string!
                            CommonData.COMPANY_NAME = json["data"]["companyName"].string!
                            CommonData.CLIENT_ID = json["data"]["clientId"].string!
                            CommonData.STAFF_NAME = json["data"]["staffName"].string!
                            CommonData.STAFF_ROLE = json["data"]["staffRole"].string!
                            CommonData.DEPT_TYPE = json["data"]["deptType"].string!
                            CommonData.LAST_LOGIN_TIME = json["data"]["lastTime"].string!
                            CommonData.CLIENT_ID_96333 = json["data"]["9clientId"].string!
                            CommonData.MAINT_ID_96333 = json["data"]["9maintId"].string!
                            if CommonData.STAFF_ROLE == "1" {
                                CommonData.SIDE_TITILE_ARRAY = [CommonData.TITLE_SIDE_PERSONNEL_CLAIM,CommonData.TITLE_SIDE_PERSONNEL_MANAGEMENT,CommonData.TITLE_SIDE_REAL_TIME_POSITION,CommonData.TITLE_SIDE_RESUCE_STATISTICS,CommonData.TITLE_SIDE_NOTICE_INFO, CommonData.TITLE_SIDE_MY_RANK, CommonData.TITLE_SIDE_MY_INFO, CommonData.TITLE_SIDE_MAINTENANCE_STATISTICS]
                                CommonData.SIDE_IMAGE_ARRAY = ["icon_side_ryrl","icon_side_rygl","icon_side_sswz","icon_side_jytj","icon_side_ggxx",
                                                               "icon_side_wdpm", "icon_side_wdxx", "icon_side_wbtj"]
                            }
                            (UIApplication.shared.delegate as! AppDelegate).loadMainView()
                        }else if loginFlag == "1"{
                            let toast = ToastView()
                            toast.showToast(text: CommonData.TOAST_REGISTER_DONE, pos: .Bottom)
                            let time: TimeInterval = 1//延迟
                            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time) {
                                exit(0)//使用该方法，上架苹果商店可能被拒。
                            }
                        }else if loginFlag == "2"{
                            self.performSegue(withIdentifier: "validatefaild", sender: nil)
                        }
                    }
                }else{
                    print(response.result.value!)
                }
            case false:
                print(CommonData.LOG_CALL_INTERFACE_ERROR)
            }
        }
    }
    
    func getDictionaryFromJSONString(jsonString:String) ->NSDictionary{
        
        let jsonData:Data = jsonString.data(using: .utf8)!
        
        let dict = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
        if dict != nil {
            return dict as! NSDictionary
        }
        return NSDictionary()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

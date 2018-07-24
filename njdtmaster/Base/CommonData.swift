//
//  CommonData.swift
//  njdtmaster
//
//  Created by 尹浩 on 2018/3/14.
//  Copyright © 2018年 尹浩. All rights reserved.
//

import Foundation
import UIKit

class CommonData {
    
    /*
        接口参数txcode
     */
    static let TXCODE_LOGIN = "login"//登陆验证接口
    static let TXCODE_REGISTER = "register"//注册接口
    static let TXCODE_PENDING_FORM = "pendingForm" //获取救援任务（维保单位）
    static let TXCODE_MY_FORM = "myForm"//获取我的待任务列表
    static let TXCODE_ALL_CLIENT = "getAllClient"//获取所有已注册维保人员列表
    static let TXCODE_CLAIM = "claim"//维保人员认领或注销
    static let TXCODE_MAINT_PLAN = "maintPlan"//维保计划列表
    static let TXCODE_GET_ALLMAINTER = "getAllMainter"//获取所有维保人员
    static let TXCODE_MAINT_CHECK = "maintCheck"//获取所有维保人员
    static let TXCODE_MY_MAINT = "myMaint"//获取我的维保历史记录
    static let TXCODE_GET_ALL_POSITION = "getAllPosition"//获取所有人员位置
    static let TXCODE_GET_ANNOUNCEMENT = "getAnnouncement"//获取公告信息
    static let TXCODE_USER_RESCUE_REMIND = "userrescueremind" //使用单位救援提醒
    static let TXCODE_USER_RESCUE_ORDERS = "userRescueOrders"//使用单位困人记录
    static let TXCODE_USERS_MAINT_REMIND = "usersMaintRemind" //使用单位维保提醒
    static let TXCODE_USER_INSPECT_REMIND = "userInspectRemind" //使用单位检验提醒
    static let TXCODE_SAFE_CHECK_PLAN = "checkPlan" //保险公司抽查计划
    static let TXCODE_MY_SAFE_CHECK = "mySafecheck" //保险公司我的抽查
    static let TXCODE_GET_CHECK_ITEMS = "getCheckItems" //保险公司获取抽查项
    static let TXCODE_FORM_CHECK = "formCheck"
    static let TXCODE_CHECK_LOGIN = "checkLogin"   //管理员账号
    
    
    /*
        屏幕尺寸
     */
    static let ADMIN_SRCEEN_WIDTH:CGFloat = UIScreen.main.bounds.size.width
    static let ADMIN_SRCEEN_HEIGHT:CGFloat = UIScreen.main.bounds.size.height
    static var ADD_ADAPTATION_HEIGHT:CGFloat = 5
    static var ADD_ADADTATION_MAX_HEIGHT:CGFloat = 5
    /*
        终端信息
     */
    static let COMPANY_NAME_L:String = "单位名称"
    static let USER_NAME_L:String = "用户名称"
    static let TERMINAL_IDENTIFICATION_L:String = "终端标识"
    static let APPLICATION_VERSION_L:String = "软件版本"
    static let LAST_LOGIN_TIME_L:String = "上次登陆时间"
    static let CUSTOMER_HOTLINE_L:String = "客服热线"
    static let CACHE_CLEANUP_L:String = "缓存清理"
    
    

    static var TERMINAL_IDENTIFICATION:String = "null"
    static let APPLICATION_VERSION:String = Bundle.main.infoDictionary! ["CFBundleShortVersionString"] as! String
    static let CUSTOMER_HOTLINE:String = "15366181339"
    static let CACHE_CLEANUP:String = "点击此处清理缓存"
    //注册信息
    static var MAINT_ID:String = ""
    static var MAINT_NAME:String = ""
    static var INSURE_ID:String = ""
    static var INSURE_NAME:String = ""
    static var COMPANY_ID:String = ""
    static var COMPANY_NAME:String = ""
    static var CLIENT_ID:String = ""
    static var STAFF_NAME:String = ""
    static var STAFF_ROLE:String = ""
    static var DEPT_TYPE:String = ""
    static var LAST_LOGIN_TIME:String = "1970-01-01 00:00:00"
    static var CLIENT_ID_96333:String = ""
    static var MAINT_ID_96333:String = ""
    
    //Title info
    static let NANJING:String = "南京"
    static let TITLE_APP_NAME:String = "南京电梯"
    static let TITLE_SIDE_PERSONNEL_CLAIM:String = "人员认领"
    static let TITLE_SIDE_PERSONNEL_MANAGEMENT:String = "人员管理"
    static let TITLE_SIDE_REAL_TIME_POSITION:String = "实时位置"
    static let TITLE_SIDE_RESUCE_STATISTICS:String = "救援统计"
    static let TITLE_SIDE_NOTICE_INFO:String = "公告信息"
    static let TITLE_SIDE_MY_RANK:String = "我的排名"
    static let TITLE_SIDE_MY_INFO:String = "我的信息"
    static let TITLE_SIDE_MAINTENANCE_STATISTICS:String = "维保统计"
    static let TITLE_NAVI_RESUCE_TASK:String = "救援任务"
    static let TITLE_NAVI_RESUCE_MAP:String = "救援路线"
    static let TITLE_NAVI_MY_RESUCE:String = "我的救援"
    static let TITLE_NAVI_MAINT_PLAN:String = "维保计划"
    static let TITLE_NAVI_MY_MAINT:String = "我的维保"
    
    //存储PersonnelClaim选中信息
    static var PERSONNEL_CLAIM_LIST:Dictionary<String,Dictionary<String, String>> = Dictionary<String, Dictionary<String, String>>()
    static var PERSONNEL_CLAIM_ARRAY:Array<String> = Array<String>()
    static var PERSONNEL_LOGOFF_ARRAY:Array<String> = Array<String>()
    
    //placeholder info
    static let PLACEHOLDER_PERSONNEL_CLAIM_SEARCH:String = "请输入人员姓名/联系方式";
    static let PLACEHOLDER_MAINT_PLAN_SEARCH:String = "维保工单编号/电梯地址/电梯96333编码"
    static let MAINT_PLAN_SEARCH:String = ""
    
    static let PLACEHOLDER_REGISTER_ROLE:String = "请选择角色"
    static let PLACEHOLDER_REGISTER_WORK_ID:String = "请输入作业证号"
    //log info  Tips
    static let LOG_LOGIN_SUCCESS = "登陆成功！原因是："
    static let LOG_LOGIN_FAILED = "登陆失败！原因是："
    static let LOG_CALL_SUCCESS = "调用成功！原因是："
    static let LOG_CALL_FAILED = "调用失败！原因是："
    static let LOG_PARAM_ERROR = "接口参数错误！"
    static let LOG_CALL_INTERFACE_ERROR = "调用接口发生错误!"
    //toast info
    static let TOAST_REGISTER_DONE = "已经注册！请联系公司管理员认领！"
    //侧边菜单信息
    static var SIDE_TITILE_ARRAY = ["公告信息", "我的排名", "我的信息", "维保统计"]
    static var SIDE_IMAGE_ARRAY = ["icon_side_ggxx", "icon_side_wdpm", "icon_side_wdxx", "icon_side_wbtj"]
    
    /** Picker Base Infomation */
    static let stateKey:String = "state"
    static let citiesKey:String = "cities"
    static let cityKey:String = "city"
    static let areasKey:String = "areas"
    static let AP_DEFAULT_BAR_TINT_COLOR:UIColor = UIColor(red: 60/255, green: 226/255, blue: 208/255, alpha: 1.0)
    
    enum PickerType: Int {
        case first
        case second
        case area
    }
    /*
        NetWork Address
     */
    static let WEATHER_PATH:String = "https://www.sojson.com/open/api/weather/json.shtml"//百度天气接口
    //96333服务器地址
    static let CONSTANT_PATH_GET_96333:String = "http://202.102.108.167:18082/njlift/android/process.action?data="
    static let CONSTANT_PATH_POST_96333:String = "http://202.102.108.167:18082/njlift/android/process.action?"
    
    //本地测试
    static let CONSTANT_PATH_POST_TEST:String = "http://192.168.199.191:10001/njlift/android/process.action?"
    
    //改革试点地址
    static let CONSTANT_PATH_GET_MAINT:String = "http://njdt.njtjy.org.cn:10011/njliftMaint/android/process.action?data="
    static let CONSTANT_PATH_POST_MAINT:String = "http://njdt.njtjy.org.cn:10011/njliftMaint/android/process.action?"
    
    

    
    //开始维保步骤
    static var kswbsj:String = "";
    static var jswbsj:String = "";
    static var regode:String = "";
    
    //抽查上报
    static var SAFE_CHECK_RESULT:Dictionary<String,String> = Dictionary<String, String>()
    static var SAFE_CHECK_REMARK:Dictionary<String,String> = Dictionary<String, String>()
    //维保类型
    static let MAINTTYPE:Dictionary<String,String> = ["00":"半月保","01":"月保","02":"季保","03":"半年保","04":"年保"]
}

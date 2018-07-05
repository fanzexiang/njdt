//
//  RegisterViewController.swift
//  njdtmaster
//
//  Created by 尹浩 on 2018/1/12.
//  Copyright © 2018年 尹浩. All rights reserved.
//

import UIKit
import AdSupport

class RegisterViewController: UIViewController  {

    @IBOutlet weak var userRole: UITextField!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var userPhone: UITextField!
    @IBOutlet weak var registerBtn: UIButton!
    
    var jsonData:NSMutableData = NSMutableData()
    
    //默认隐藏第三组，根据角色筛选显示改组
    @IBOutlet weak var thirdBackground: UIImageView!
    @IBOutlet weak var thirdLine: UIImageView!
    //此两组信息需要根据不同角色显示不同的内容
    @IBOutlet weak var thirdIcon: UIImageView!
    @IBOutlet weak var thirdTextField: UITextField!
    @IBOutlet weak var btn: UIButton!
    
    var rolePickerView: RolePickerView?
    var inspectionPickerView: InspectionPickerView?
    let toast = ToastView()
    
    @IBAction func userRegisterBtn(_ sender: UIButton) {
        if(userRole.text == "请选择角色"){
            toast.showToast(text: "请选择角色！", pos: .Bottom)
            return ;
        }
        if (userName.text?.isEmpty)!{
            toast.showToast(text: "请输入姓名！", pos: .Bottom)
            return ;
        }
        if(userPhone.text?.isEmpty)!{
            toast.showToast(text: "请输入手机号！", pos: .Bottom)
            return ;
        }
        //设置视图适配
        let users = User()
        users.userName = userName.text
        users.userPhone = userPhone.text
        users.userRole = userRole.text
        users.userJobnum = thirdTextField.text

        //调用注册接口
        let md = NSMutableDictionary()
        let network = BaseNetwork()
        var result:String = "Null"
        var registerURL:String!
        var uuid:String = ASIdentifierManager.shared().advertisingIdentifier.uuidString
        uuid = uuid.replacingOccurrences(of: "-", with: "")
        if users.userRole as String == "维保单位" {
            registerURL = "{\"txcode\":\"\(CommonData.TXCODE_LOGIN)\",\"imei\":\"\(uuid)\","
                            + "\"tel\":\"\(users.userPhone as String)\","
                            + "\"name\":\"\(users.userName as String)\","
                            + "\"jobnum\":\"\(users.userJobnum as String)\"}"
            md.setValue(registerURL, forKey: "data")
            network.post(url: "http://202.102.108.167:18082/njlift/android/process.action", params: md)
        }else if users.userRole as String == "使用单位" {
            registerURL = "{\"txcode\":\"register\",\"imei\":\"\(uuid)\","
                + "\"tel\":\"\(users.userPhone as String)\","
                + "\"name\":\"\(users.userName as String)\","
                + "\"deptType\":\"2\",\"roleType\":\"1\"}"
            md.setValue(registerURL, forKey: "data")
            network.post(url: "http://njdt.njtjy.org.cn:10011/njliftMaint/android/process.action", params: md)
        }else{
            if(thirdTextField.text as! String == "检验机构"){
                registerURL = "{\"txcode\":\"register\",\"imei\":\"\(uuid)\","
                    + "\"tel\":\"\(users.userPhone as String)\","
                    + "\"name\":\"\(users.userName as String)\","
                    + "\"deptType\":\"1\",\"roleType\":\"1\"}"
            }else{
                registerURL = "{\"txcode\":\"register\",\"imei\":\"\(uuid)\","
                    + "\"tel\":\"\(users.userPhone as String)\","
                    + "\"name\":\"\(users.userName as String)\","
                    + "\"deptType\":\"1\",\"roleType\":\"0\"}"
            }
            md.setValue(registerURL, forKey: "data")
            network.post(url: "http://njdt.njtjy.org.cn:10011/njliftMaint/android/process.action", params: md)
        }

        let time: TimeInterval = 1.0
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time) {
            result = network.getReturnValue()
            let dic:NSDictionary = self.getDictionaryFromJSONString(jsonString: result)
            for (key,value) in dic {
                print("键：\(key),值：\(value)")
            }
        }
        
        //注册按钮设置不可用
        registerBtn.isUserInteractionEnabled = false
        registerBtn.alpha = 0.4
       
        toast.showToast(text: "注册成功，请联系公司管理员认领！", pos: .Bottom)
    }
    
    //在这个方法中给新页面传递参数
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "login"{
            let controller = segue.destination as! LoginDoneViewController
            controller.users = (sender as? User)!
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userPhone.keyboardType = UIKeyboardType.namePhonePad
        thirdLine.isHidden = true
        thirdBackground.isHidden = true
        thirdIcon.isHidden = true
        thirdTextField.isHidden = true
        
        userRole.text = CommonData.PLACEHOLDER_REGISTER_ROLE
        userRole.allowsEditingTextAttributes = false
        
        rolePickerView = RolePickerView.rolepicker(for: self, textField: userRole)
        userRole.delegate = self
        
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(viewDidTap(tapGR:)))
        tapGR.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGR)
    }
    @objc func viewDidTap(tapGR: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - lazy
    lazy var myRole: Role = {
        return Role()
    }()
    
}

extension RegisterViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        rolePickerView?.shouldSelected(proName: myRole.first, cityName: myRole.second, areaName: myRole.area)
    }
}

extension RegisterViewController: RolePickerDelegate {
    
    
    internal func cancel(roleToolbar: RoleToolbar, textField: UITextField, role: Role, item: UIBarButtonItem) {
//        print("点击了取消")
        if(role.first.isEmpty){
            //do nothing
        }
    }
    
    internal func sure(roleToolbar: RoleToolbar, textField: UITextField, role: Role, item: UIBarButtonItem) {
        if(role.first.isEmpty){
            userRole.text = "维保单位"
            role.first = "维保单位"
            print("role.first is null, and role.first is already reset default value.")
        }else{
            userRole.text = role.first
        }
        switch role.first {
        case "维保单位":
            thirdLine.isHidden = false
            thirdBackground.isHidden = false
            thirdIcon.isHidden = false
            thirdTextField.isHidden = false
            thirdIcon.image = UIImage(named:"icon_register_zyz")
            thirdTextField.text = ""
            thirdTextField.placeholder = CommonData.PLACEHOLDER_REGISTER_WORK_ID
            thirdTextField.textColor = UIColor.white
        case "保险公司":
            thirdLine.isHidden = false
            thirdBackground.isHidden = false
            thirdIcon.isHidden = false
            thirdTextField.isHidden = false
            thirdIcon.image = UIImage(named:"icon_inspectper")
            thirdTextField.text = role.second
            thirdTextField.textColor = UIColor.white
            thirdTextField.isUserInteractionEnabled = false
            //print("\(role.first)的子项是：\(role.second)")
        case "非检验机构":
            thirdLine.isHidden = false
            thirdBackground.isHidden = false
            thirdIcon.isHidden = false
            thirdTextField.isHidden = false
            thirdIcon.image = UIImage(named:"icon_register_zyz")
            thirdTextField.text = "非检验机构"
            thirdTextField.placeholder = CommonData.PLACEHOLDER_REGISTER_WORK_ID
            thirdTextField.textColor = UIColor.white
        case "检验机构":
            thirdLine.isHidden = false
            thirdBackground.isHidden = false
            thirdIcon.isHidden = false
            thirdTextField.isHidden = false
            thirdIcon.image = UIImage(named:"icon_inspectper")
            thirdTextField.text = "检验机构"
            thirdTextField.textColor = UIColor.white
        case "使用单位":
            thirdTextField.adjustsFontSizeToFitWidth = true
            thirdLine.isHidden = true
            thirdBackground.isHidden = true
            thirdIcon.isHidden = true
            thirdTextField.isHidden = true
            
        default:
            break
        }
    }
    
    internal func statusChanged(rolePickerView: RolePickerView, pickerView: UIPickerView, textField: UITextField, role: Role) {

    }
    
}

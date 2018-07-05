//
//  StartMaintViewController.swift
//  njdtmaster
//
//  Created by 尹浩 on 2018/3/30.
//  Copyright © 2018年 尹浩. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import AdSupport

class StartMaintViewController: UIViewController,ScannerTimeDelegate,UIActionSheetDelegate,BMKLocationServiceDelegate{
   
    var locationService: BMKLocationService!
    func saveScannerTime(kssj: String, jssj: String) {
        print(kssj);
        print(jssj);
    }
    
    var dataDetail:Dictionary = Dictionary<String,String>()
    var cyname:String?;
    var step1:UIImageView?;
    var node1:UILabel?;
    var lineView1:UIImageView?; 
    var step2:UIImageView?;
    var node2:UILabel?;
    var lineView2:UIImageView?;
    var step3:UIImageView?;
    var node3:UILabel?;
    var btn:UIButton?;
    var label11:UITextField?;
    var kswbsj:UILabel?;
    var jswbsj:UILabel?;
    var scannerViewController:ScannerViewController?;
    
    var dataArray = [Dictionary<String, String>]()
    var scwbjh:UILabel?;
    var pickViewMaintPerson :UIPickerView?;
    var wbry2:UILabel?
    
    let ofsize:CGFloat = 15;
    var myLat:String = "";
    var myLon:String = "" ;
    var makeNextMaint:String = "0"
    var mainterId2 :String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.title = "开始维保"
        self.navigationController?.navigationBar.tintColor = UIColor.white;
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        let colorContent:UIColor = UIColor.white;
        
        locationService = BMKLocationService()
        locationService.allowsBackgroundLocationUpdates = true
        
         //工单编号
        let label1 = UILabel(frame: CGRect(x:8, y:109 + CommonData.ADD_ADAPTATION_HEIGHT, width:CommonData.ADMIN_SRCEEN_WIDTH - 16, height:34))
        label1.backgroundColor = colorContent;
        label1.textAlignment = NSTextAlignment.center
        let maskPath = UIBezierPath (roundedRect : label1.bounds, byRoundingCorners : [UIRectCorner.topLeft,UIRectCorner.topRight], cornerRadii: CGSize(width:5,height:5));
        let maskLayer = CAShapeLayer();
        maskLayer.frame = label1.bounds;
        maskLayer.path = maskPath.cgPath;
        label1.layer.mask = maskLayer;
        view.addSubview(label1)
        let gdbhIV = UIImageView(image: UIImage(named: "icon_maintplan_gdbh"))
        gdbhIV.frame=CGRect(x:16 ,y:116 + CommonData.ADD_ADAPTATION_HEIGHT, width:20, height:20);
        let gdbhL = UILabel(frame: CGRect(x:46 ,y:116 + CommonData.ADD_ADAPTATION_HEIGHT, width:80, height:20))
        let gdbh = UILabel(frame: CGRect(x:126 ,y:116 + CommonData.ADD_ADAPTATION_HEIGHT, width:260, height:20))
        gdbhL.text = "工单编号"
        gdbh.text = dataDetail["formcode"];
        gdbhL.font = UIFont.systemFont(ofSize: ofsize)
        gdbh.font = UIFont.systemFont(ofSize: ofsize)
        gdbhL.textAlignment = NSTextAlignment.left
        gdbh.textAlignment = NSTextAlignment.left
        gdbh.textColor = UIColor.orange
        view.addSubview(gdbhIV)
        view.addSubview(gdbhL)
        view.addSubview(gdbh)
         //电梯识别码
        let label2 = UILabel(frame: CGRect(x:8, y:142 + CommonData.ADD_ADAPTATION_HEIGHT, width:CommonData.ADMIN_SRCEEN_WIDTH - 16, height:34));
        label2.backgroundColor = colorContent;
        label2.textAlignment = NSTextAlignment.center
        view.addSubview(label2)
        let sbmIV = UIImageView(image: UIImage(named: "icon_maintplan_sbm"))
        sbmIV.frame=CGRect(x:16 ,y:149 + CommonData.ADD_ADAPTATION_HEIGHT, width:20, height:20);
        let sbmL = UILabel(frame: CGRect(x:46 ,y:149 + CommonData.ADD_ADAPTATION_HEIGHT, width:60, height:20))
        let sbm = UILabel(frame:CGRect(x:126 ,y:149 + CommonData.ADD_ADAPTATION_HEIGHT, width:260, height:20))
        sbmL.text = "识别码"
        sbm.text = dataDetail["liftcode"];
        sbmL.font = UIFont.systemFont(ofSize: ofsize)
        sbm.font = UIFont.systemFont(ofSize: ofsize)
        sbmL.textAlignment = NSTextAlignment.left
        sbm.textAlignment = NSTextAlignment.left
        sbm.textColor = UIColor.orange
        view.addSubview(sbmIV)
        view.addSubview(sbmL)
        view.addSubview(sbm)
        //使用单位
        let label3 = UILabel(frame: CGRect(x:8, y:175 + CommonData.ADD_ADAPTATION_HEIGHT, width:CommonData.ADMIN_SRCEEN_WIDTH - 16, height:34))
        label3.backgroundColor = colorContent;
        label3.textAlignment = NSTextAlignment.center
        view.addSubview(label3)
        let sydwIV = UIImageView(image: UIImage(named: "icon_maintplan_sydw"))
        sydwIV.frame = CGRect(x:16 ,y:182 + CommonData.ADD_ADAPTATION_HEIGHT, width:20, height:20)
        let sydwL = UILabel(frame:CGRect(x:46 ,y:182 + CommonData.ADD_ADAPTATION_HEIGHT, width:80, height:20))
        let sydw = UILabel(frame:CGRect(x:126 ,y:182 + CommonData.ADD_ADAPTATION_HEIGHT, width:260, height:20))
        sydwL.text = "使用单位"
        sydw.text = dataDetail["companyname"];
        sydwL.font = UIFont.systemFont(ofSize: ofsize)
        sydw.font = UIFont.systemFont(ofSize: ofsize)
        sydwL.textAlignment = NSTextAlignment.left
        sydw.textAlignment = NSTextAlignment.left
        sydw.textColor = UIColor.orange
        view.addSubview(sydwIV)
        view.addSubview(sydwL)
        view.addSubview(sydw)
        //电梯地址
        let label4 = UILabel(frame: CGRect(x:8, y:208 + CommonData.ADD_ADAPTATION_HEIGHT, width:CommonData.ADMIN_SRCEEN_WIDTH - 16, height:34))
        label4.backgroundColor = colorContent;
        label4.textAlignment = NSTextAlignment.center
        view.addSubview(label4)
        let dtdzIV = UIImageView(image: UIImage(named: "icon_maintplan_dtdz"))
        dtdzIV.frame = CGRect(x:16,y:215 + CommonData.ADD_ADAPTATION_HEIGHT, width:20, height:20);
        let dtdzL = UILabel(frame:CGRect(x:46 ,y:215 + CommonData.ADD_ADAPTATION_HEIGHT, width:80, height:20))
        let dtdz = UILabel(frame:CGRect(x:126 ,y:215 + CommonData.ADD_ADAPTATION_HEIGHT, width:260, height:20))
        dtdzL.text = "电梯地址"
        dtdz.text = dataDetail["liftaddress"];
        dtdzL.font = UIFont.systemFont(ofSize: ofsize)
        dtdz.font = UIFont.systemFont(ofSize: ofsize)
        dtdzL.textAlignment = NSTextAlignment.left
        dtdz.textAlignment = NSTextAlignment.left
        dtdz.textColor = UIColor.orange
        view.addSubview(dtdzIV)
        view.addSubview(dtdzL)
        view.addSubview(dtdz)
        //维保类型
        let label5 = UILabel(frame: CGRect(x:8, y:241 + CommonData.ADD_ADAPTATION_HEIGHT, width:CommonData.ADMIN_SRCEEN_WIDTH - 16, height:34))
        label5.backgroundColor = colorContent;
        label5.textAlignment = NSTextAlignment.center
        view.addSubview(label5)
        let wblxIV = UIImageView(image: UIImage(named: "icon_maintplan_wblx"))
        wblxIV.frame = CGRect(x:16 ,y:248 + CommonData.ADD_ADAPTATION_HEIGHT, width:20, height:20)
        let wblxL = UILabel(frame: CGRect(x:46 ,y:248 + CommonData.ADD_ADAPTATION_HEIGHT, width:80, height:22))
        let wblx = UILabel(frame: CGRect(x:126 ,y:248 + CommonData.ADD_ADAPTATION_HEIGHT, width:260, height:22))
        wblxL.text = "维保类型"
        var maintType:String = "";
        if dataDetail["mainttype"]=="00"{
            maintType = "半月保";
        }else if dataDetail["mainttype"]=="01"{
            maintType = "月保";
        }else if dataDetail["mainttype"]=="02"{
            maintType = "季保";
        }else if dataDetail["mainttype"]=="03"{
            maintType = "半年保";
        }else {
            maintType = "年保";
        }
        wblx.text = maintType;
        wblxL.font = UIFont.systemFont(ofSize: ofsize)
        wblx.font = UIFont.systemFont(ofSize: ofsize)
        wblxL.textAlignment = NSTextAlignment.left
        wblx.textAlignment = NSTextAlignment.left
        wblx.textColor = UIColor.orange
        view.addSubview(wblxIV)
        view.addSubview(wblxL)
        view.addSubview(wblx)
        //维保人员
        let label6 = UILabel(frame: CGRect(x:8, y:274 + CommonData.ADD_ADAPTATION_HEIGHT, width:CommonData.ADMIN_SRCEEN_WIDTH - 16, height:34))
        label6.backgroundColor = colorContent;
        label6.textAlignment = NSTextAlignment.center
        view.addSubview(label6)
        let wbryIV = UIImageView(image: UIImage(named: "icon_drawer_ryrl"))
        wbryIV.frame = CGRect(x:16 ,y:281 + CommonData.ADD_ADAPTATION_HEIGHT, width:20, height:20)
        let wbryL = UILabel(frame: CGRect(x:46 ,y:281 + CommonData.ADD_ADAPTATION_HEIGHT, width:80, height:20))
        let wbry = UILabel(frame: CGRect(x:126 ,y:281 + CommonData.ADD_ADAPTATION_HEIGHT, width:260, height:20))
        wbryL.text = "维保人员"
        wbry.text = CommonData.MAINT_NAME;
        wbryL.font = UIFont.systemFont(ofSize: ofsize)
        wbry.font = UIFont.systemFont(ofSize: ofsize)
        wbryL.textAlignment = NSTextAlignment.left
        wbry.textAlignment = NSTextAlignment.left
        wbry.textColor = UIColor.orange
        view.addSubview(wbryIV)
        view.addSubview(wbryL)
        view.addSubview(wbry)
        //维保人员2
        let label7 = UILabel(frame: CGRect(x:8, y:307 + CommonData.ADD_ADAPTATION_HEIGHT, width:CommonData.ADMIN_SRCEEN_WIDTH - 16, height:34))
        label7.backgroundColor = colorContent;
        label7.textAlignment = NSTextAlignment.center
        view.addSubview(label7)
        let wbry2IV = UIImageView(image: UIImage(named: "icon_drawer_rygl"))
        wbry2IV.frame = CGRect(x:16 ,y:314 + CommonData.ADD_ADAPTATION_HEIGHT, width:20, height:20)
        let wbry2L = UILabel(frame: CGRect(x:46 ,y:314 + CommonData.ADD_ADAPTATION_HEIGHT, width:100, height:20))
        wbry2 = UILabel(frame:CGRect(x:146 ,y:314 + CommonData.ADD_ADAPTATION_HEIGHT, width:260, height:20))
        wbry2L.text = "同组维保人员"
        wbry2?.text = "";
        wbry2L.font = UIFont.systemFont(ofSize: ofsize)
        wbry2?.font = UIFont.systemFont(ofSize: ofsize)
        wbry2L.textAlignment = NSTextAlignment.left
        wbry2?.textAlignment = NSTextAlignment.left
        wbry2?.textColor = UIColor.orange
        view.addSubview(wbry2IV)
        view.addSubview(wbry2L)
        view.addSubview(wbry2!)
        let arrowPerson = UIButton(frame: CGRect(x:346 ,y:314 + CommonData.ADD_ADAPTATION_HEIGHT, width:20, height:20));
        arrowPerson.setBackgroundImage(UIImage(named: "arrow_right"), for: .normal);
        arrowPerson.addTarget(self, action: #selector(getGroupPerson), for: .touchUpInside)
        view.addSubview(arrowPerson)
        
        //是否生成下次维保计划
        let label8 = UILabel(frame: CGRect(x:8, y:340 + CommonData.ADD_ADAPTATION_HEIGHT, width:CommonData.ADMIN_SRCEEN_WIDTH - 16, height:34))
        label8.backgroundColor = colorContent;
        label8.textAlignment = NSTextAlignment.center
        view.addSubview(label8)
        let scwbjhIV = UIImageView(image: UIImage(named: "icon_check_bz"))
        scwbjhIV.frame = CGRect(x:16 ,y:347 + CommonData.ADD_ADAPTATION_HEIGHT, width:20, height:20)
        let scwbjhL = UILabel(frame: CGRect(x:46 ,y:347 + CommonData.ADD_ADAPTATION_HEIGHT, width:180, height:20))
        scwbjh = UILabel(frame: CGRect(x:226 ,y:347 + CommonData.ADD_ADAPTATION_HEIGHT, width:100, height:20))
        scwbjhL.text = "是否生成下次维保计划"
        scwbjhL.font = UIFont.systemFont(ofSize: ofsize)
        scwbjh!.font = UIFont.systemFont(ofSize: ofsize)
        scwbjhL.textAlignment = NSTextAlignment.left
        scwbjh?.textAlignment = NSTextAlignment.left
        scwbjh?.textColor = UIColor.orange
        let arrowPlan = UIButton(frame: CGRect(x:346 ,y:347 + CommonData.ADD_ADAPTATION_HEIGHT, width:20, height:20));
        arrowPlan.setBackgroundImage(UIImage(named: "arrow_right"), for: .normal);
        arrowPlan.addTarget(self, action: #selector(nextPlan), for: .touchUpInside)
        
        view.addSubview(scwbjhIV)
        view.addSubview(scwbjhL)
        view.addSubview(scwbjh!)
        view.addSubview(arrowPlan)
        
        //开始维保时间
        let label9 = UILabel(frame: CGRect(x:8, y:373 + CommonData.ADD_ADAPTATION_HEIGHT, width:CommonData.ADMIN_SRCEEN_WIDTH - 16, height:34))
        label9.backgroundColor = colorContent;
        label9.textAlignment = NSTextAlignment.center
        view.addSubview(label9)
        let kswbsjIV = UIImageView(image: UIImage(named: "icon_maintplan_kssj"))
        kswbsjIV.frame = CGRect(x:16 ,y:380 + CommonData.ADD_ADAPTATION_HEIGHT, width:20, height:20)
        let kswbsjL = UILabel(frame: CGRect(x:46 ,y:380 + CommonData.ADD_ADAPTATION_HEIGHT, width:100, height:22))
        kswbsj = UILabel(frame: CGRect(x:146 ,y:380 + CommonData.ADD_ADAPTATION_HEIGHT, width:260, height:22))
        kswbsjL.text = "开始维保时间"
        kswbsj!.text = "";
        kswbsjL.font = UIFont.systemFont(ofSize: ofsize)
        kswbsj!.font = UIFont.systemFont(ofSize: ofsize)
        kswbsjL.textAlignment = NSTextAlignment.left
        kswbsj!.textAlignment = NSTextAlignment.left
        kswbsj!.textColor = UIColor.orange
        view.addSubview(kswbsjIV)
        view.addSubview(kswbsjL)
        view.addSubview(kswbsj!)
        //结束维保时间
        let label10 = UILabel(frame:CGRect(x:8, y:406 + CommonData.ADD_ADAPTATION_HEIGHT, width:CommonData.ADMIN_SRCEEN_WIDTH - 16, height:34))
        label10.backgroundColor = colorContent;
        label10.textAlignment = NSTextAlignment.center
        view.addSubview(label10)
        let jswbsjIV = UIImageView(image: UIImage(named: "icon_maintplan_jssj"))
        jswbsjIV.frame = CGRect(x:16 ,y:413 + CommonData.ADD_ADAPTATION_HEIGHT, width:20, height:20)
        let jswbsjL = UILabel(frame: CGRect(x:46 ,y:413 + CommonData.ADD_ADAPTATION_HEIGHT, width:100, height:20))
        jswbsj = UILabel(frame: CGRect(x:146 ,y:413 + CommonData.ADD_ADAPTATION_HEIGHT, width:260, height:20))
        jswbsjL.text = "结束维保时间"
        jswbsj!.text = "";
        jswbsjL.font = UIFont.systemFont(ofSize: ofsize)
        jswbsj!.font = UIFont.systemFont(ofSize: ofsize)
        jswbsjL.textAlignment = NSTextAlignment.left
        jswbsj!.textAlignment = NSTextAlignment.left
        jswbsj!.textColor = UIColor.orange
        view.addSubview(jswbsjIV)
        view.addSubview(jswbsjL)
        view.addSubview(jswbsj!)
        //维保备注
        label11 = UITextField(frame:CGRect(x:8, y:439+10 + CommonData.ADD_ADAPTATION_HEIGHT, width:CommonData.ADMIN_SRCEEN_WIDTH - 16, height:134));
        label11?.backgroundColor = colorContent;
        label11?.textAlignment = NSTextAlignment.left
        label11?.borderStyle = UITextBorderStyle.roundedRect;
        label11?.placeholder = "请输入维保备注";
        label11?.keyboardType = UIKeyboardType.default;
        view.addSubview(label11!)
        
        btn = UIButton(frame: CGRect(x:8, y:572+20 + CommonData.ADD_ADAPTATION_HEIGHT, width:CommonData.ADMIN_SRCEEN_WIDTH - 16, height:45));
        btn!.backgroundColor = UIColor.blue
        btn!.setBackgroundImage(UIImage(named:"submit_normal"), for: .normal);
        btn!.setBackgroundImage(UIImage(named:"submit_normal"), for: .selected);
        btn!.setTitleColor(UIColor.white, for: .normal)
        btn!.addTarget(self, action: #selector(StartMaintViewController.startStep),for: .touchUpInside);
        view.addSubview(btn!)
        
        addStepView()
        loadMaintPerson()
        locationService.startUserLocationService()
    }
    
     override func viewDidAppear(_ animated: Bool) {
        updateStepView() ;
        kswbsj?.text = CommonData.kswbsj;
        jswbsj?.text = CommonData.jswbsj;
        if CommonData.kswbsj == ""{
            btn!.setTitle("开始扫描", for: .normal);
        }else{
            if CommonData.jswbsj == ""{
                btn!.setTitle("结束扫描", for: .normal);
            }else{
                btn!.setTitle("提交", for: .normal);
            }
        }
    }
   
    
    @objc func  startStep() {
        if CommonData.kswbsj == "" {
            let result = ScannerViewController();
            result.scannerTimeDelegate = self;
            self.navigationController?.pushViewController(result, animated: true)
        }else{
            if CommonData.jswbsj == ""{
                let result = ScannerViewController()
                result.scannerTimeDelegate = self
                self.navigationController?.pushViewController(result, animated: true)
            }else{
                let myRemark:String = (label11?.text)!
                let uuid:String = ASIdentifierManager.shared().advertisingIdentifier.uuidString.replacingOccurrences(of: "-", with: "")
                
                if(myRemark.isEmpty){
                    let alert:UIAlertView = UIAlertView(title: "提示", message: "维保备注为空", delegate: nil, cancelButtonTitle: "确定")
                    alert.show();
                    return
                }
                if(mainterId2.isEmpty){
                    let alert:UIAlertView = UIAlertView(title: "提示", message: "维保人员空", delegate: nil, cancelButtonTitle: "确定")
                    alert.show();
                    return
                }
                CBToast.showToastAction();
                miantCheck(imei:uuid,clientId:CommonData.CLIENT_ID,maintId:CommonData.MAINT_ID,formId:dataDetail["formid"]!,
                           starttime:CommonData.kswbsj,endtime:CommonData.jswbsj,longitude: myLon,latitude: myLat,
                           remark:myRemark,clientId2:mainterId2,nextMaint: makeNextMaint)
            }
        }
    }
    
    func updateStepView()  {
        if CommonData.kswbsj == ""{
            step1?.image = UIImage(named:"attention");
            lineView1?.image = UIImage(named: "fullline")
            step2?.image = UIImage(named:"default_icon")
            lineView2?.image = UIImage(named: "dashline")
            step3?.image = UIImage(named:"default_icon")
        }else{
            if CommonData.jswbsj == ""{
                step1?.image  = UIImage(named:"complted")
                lineView1?.image = UIImage(named: "fullline")
                step2?.image = UIImage(named:"attention")
                lineView2?.image = UIImage(named: "dashline")
                step3?.image = UIImage(named:"default_icon")
            }else{
                step1?.image  = UIImage(named:"complted");
                lineView1?.image  = UIImage(named: "fullline")
                step2?.image  = UIImage(named:"complted")
                lineView2?.image  = UIImage(named: "fullline")
                step3?.image  = UIImage(named:"attention")
            }
        }
    }
    func addStepView() {
        let startpoint:Int = Int((CommonData.ADMIN_SRCEEN_WIDTH - 180)/2.0);
        let heightStep = 75;
        step1 = UIImageView();
        step1!.frame = CGRect(x:startpoint,y:heightStep,width:20,height:20);
        self.view.addSubview(step1!);
        
        node1 = UILabel(frame: CGRect(x:startpoint-20,y:heightStep+10,width:80,height:40));
        node1!.text = "开始维保";
        node1!.textColor = UIColor.orange;
        node1!.font = UIFont.systemFont(ofSize: 15)
        node1!.textAlignment = NSTextAlignment.left
        self.view.addSubview(node1!);
        
        lineView1 = UIImageView();
        lineView1!.frame = CGRect(x: startpoint+20 ,y: heightStep+9, width: 60, height: 2)
        self.view.addSubview(lineView1!);
        
        step2 = UIImageView();
        step2!.frame = CGRect(x:startpoint+20+60,y:heightStep,width:20,height:20);
        self.view.addSubview(step2!);
        
        node2 = UILabel(frame: CGRect(x:startpoint+60,y:heightStep+10,width:80,height:40));
        node2!.text = "结束维保";
        node2!.textColor = UIColor.orange;
        node2!.font = UIFont.systemFont(ofSize: 15)
        node2!.textAlignment = NSTextAlignment.center
        self.view.addSubview(node2!);
        
        lineView2 = UIImageView();
        lineView2!.frame = CGRect(x: startpoint+20+60+20 ,y: heightStep+9, width: 60, height: 2)
        self.view.addSubview(lineView2!);
        
        step3 = UIImageView();
        step3!.frame = CGRect(x:startpoint+20+60+20+60,y:heightStep,width:20,height:20);
        self.view.addSubview(step3!);
        
        node3 = UILabel(frame: CGRect(x:startpoint+60+20+60,y:heightStep+10,width:80,height:40));
        node3!.text = "提交";
        node3!.textColor = UIColor.orange;
        node3!.font = UIFont.systemFont(ofSize: 15)
        node3!.textAlignment = NSTextAlignment.center
        self.view.addSubview(node3!);
      
        
    }
    @objc func nextPlan(){
        let alertsheet = UIActionSheet();
        alertsheet.tag = 0;
        alertsheet.addButton(withTitle: "取消")
        alertsheet.addButton(withTitle: "是")
        alertsheet.addButton(withTitle: "否")
        alertsheet.cancelButtonIndex = 0;
        alertsheet.delegate = self;
        alertsheet.show(in: self.view);
    }
    
    @objc func getGroupPerson(){
        let alertsheet = UIActionSheet();
        alertsheet.addButton(withTitle: "取消")
        alertsheet.tag = 1;
        for  i in 0...self.dataArray.count-1{
             alertsheet.addButton(withTitle: self.dataArray[i]["mainterName"])
        }
        alertsheet.cancelButtonIndex = 0;
        alertsheet.delegate = self;
        alertsheet.show(in: self.view);
    }
    
    
    func actionSheet(_ actionSheet: UIActionSheet, clickedButtonAt buttonIndex: Int) {
        if(actionSheet.tag == 0){
            switch buttonIndex {
            case 2:
                scwbjh?.text = "否"
                makeNextMaint = "1"
                break;
            case 1 :
                scwbjh?.text = "是"
                makeNextMaint = "0"
                break;
            default:
                break;
            }
        }else{
            if (buttonIndex>0){
                let name = self.dataArray[buttonIndex-1]["mainterName"];
                wbry2?.text = name;
                mainterId2 = self.dataArray[buttonIndex-1]["mainterId"]!;
            }
        }
    }
    
    
    func loadMaintPerson(){
        Alamofire.request(CommonData.CONSTANT_PATH_POST_MAINT, method: .post, parameters: ["data":"{\"txcode\":\"\(CommonData.TXCODE_GET_ALLMAINTER)\",\"imei\":\"\(CommonData.TERMINAL_IDENTIFICATION)\",\"maintId\":\"\(CommonData.MAINT_ID)\",\"clientId\":\"\(CommonData.CLIENT_ID)\"}"], encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result.isSuccess {
            case true:
                if let value = response.result.value {
                    let json = JSON(value)
                    let rescode = json["rescode"].string!
                    let msg = json["msg"].string!
                    let time: TimeInterval = 0.3
                    
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time) {
                        if rescode == "0"{
                            for i in 0...(json["data"].count - 1) {
                                var resultData:Dictionary = Dictionary<String,String>()
                                resultData["mainterId"] = json["data"][i]["mainterId"].string!
                                resultData["mainterName"] = json["data"][i]["mainterName"].string!
                                self.dataArray.append(resultData)
                            }
                           
                        }else{
                            print(msg);
                        }
                    }
                }
            case false:
                print(CommonData.LOG_CALL_INTERFACE_ERROR)
            }
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
        locationService.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        locationService.delegate = self
        locationService.stopUserLocationService()
    }
    
    // MARK: - BMKMapViewDelegate
    
    
    // MARK: - BMKLocationServiceDelegate
    
    /**
     *在地图View将要启动定位时，会调用此函数
     *@param mapView 地图View
     */
    func willStartLocatingUser() {
        print("willStartLocatingUser");
    }
    
    /**
     *用户方向更新后，会调用此函数
     *@param userLocation 新的用户位置
     */
    func didUpdateUserHeading(_ userLocation: BMKUserLocation!) {
//        print("heading is \(userLocation.heading)")
        
    }
    
    /**
     *用户位置更新后，会调用此函数
     *@param userLocation 新的用户位置
     */
    func didUpdate(_ userLocation: BMKUserLocation!) {
        print("didUpdateUserLocation lat:\(userLocation.location.coordinate.latitude) lon:\(userLocation.location.coordinate.longitude)")
        myLat = String(userLocation.location.coordinate.latitude)
        myLon = String(userLocation.location.coordinate.longitude)
    }
    
    /**
     *在地图View停止定位后，会调用此函数
     *@param mapView 地图View
     */
    func didStopLocatingUser() {
        print("didStopLocatingUser")
    }
    func miantCheck(imei:String,clientId:String,maintId:String,formId:String,starttime:String,
                    endtime:String,longitude:String,latitude:String,remark:String,clientId2:String,nextMaint:String){
        
        let url = "{\"txcode\":\"\(CommonData.TXCODE_MAINT_CHECK)\","
            + "\"imei\":\"\(imei)\","
            + "\"clientId\":\"\(clientId)\","
            + "\"formId\":\"\(formId)\","
            + "\"maintId\":\"\(maintId)\","
            + "\"starttime\":\"\(starttime)\","
            + "\"endtime\":\"\(endtime)\","
            + "\"longitude\":\"\(longitude)\","
            + "\"latitude\":\"\(latitude)\","
            + "\"remark\":\"\(remark)\","
            + "\"clientId2\":\"\(clientId2)\","
            + "\"nextMaint\":\"\(nextMaint)\"}"
        print(url)
        Alamofire.request(CommonData.CONSTANT_PATH_POST_MAINT, method: .post, parameters: ["data":url], encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result.isSuccess {
            case true:
                if let value = response.result.value {
                    let json = JSON(value)
                    let rescode = json["rescode"].string!
                    let msg = json["msg"].string!
                    let time: TimeInterval = 0.3
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time) {
                        CBToast.hiddenToastAction();
                        if rescode == "0"{
                            CommonData.kswbsj = ""
                            CommonData.jswbsj = ""
                            let alert:UIAlertView = UIAlertView(title: "提示", message: "提交成功", delegate: nil, cancelButtonTitle: "确定")
                            alert.show();
                            return
                        }else{
                            print(msg);
                        }
                    }
                }
            case false:
                print(CommonData.LOG_CALL_INTERFACE_ERROR)
            }
        }
        
    }
    
    
}



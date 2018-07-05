//
//  SafeCheckItemsVC.swift
//  njdtmaster
//
//  Created by ihoou on 2018/6/4.
//  Copyright © 2018年 尹浩. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SafeCheckItemsVC: UIViewController ,UITableViewDataSource,UITableViewDelegate,UITextViewDelegate,CheckboxDelegate{
    @IBOutlet weak var itemsTableView: UITableView!
    @IBOutlet weak var summaryText: UITextView!
    @IBOutlet weak var sumbitButton: UIButton!
    
    var dataDetail:Dictionary = Dictionary<String,String>()
    var arrayItems = [[Dictionary<String, String>]]()
    var nullIV:UIImageView = UIImageView(image: UIImage(named: "icon_empty"))
    var desLabel:UILabel = UILabel()
    var placeholderLabel:UILabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationController?.navigationBar.tintColor = UIColor.white;
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        self.navigationController?.navigationBar.topItem?.title = "";
        
        self.itemsTableView.refreshControl = UIRefreshControl()
        self.itemsTableView.refreshControl!.addTarget(self, action: #selector(refreshData),for: .valueChanged)
        self.itemsTableView.refreshControl!.attributedTitle = NSAttributedString(string: "下拉刷新数据")
        self.itemsTableView.register(UINib(nibName:"SafeCheckItemsTableViewCell", bundle:nil),forCellReuseIdentifier:"safeCheckItems")
        self.itemsTableView.dataSource = self
        self.itemsTableView.delegate = self
        self.summaryText.delegate = self
        
        self.summaryText.layer.borderColor = UIColor(red: 211/255, green: 211/255, blue: 211/255, alpha: 1).cgColor;
        self.summaryText.layer.borderWidth = 1;
        self.summaryText.layer.cornerRadius = 8;
        
        
       
        self.placeholderLabel.frame = CGRect(x: 0, y: 5, width: 160, height: 20)
        self.placeholderLabel.text = "请输入抽查备注..."
        self.summaryText.addSubview(self.placeholderLabel)
        self.placeholderLabel.textColor = UIColor.init(red: 72/256, green: 82/256, blue: 93/256, alpha: 1)
        
        refreshData()
        drawNullView()
        showNullView()
    }
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        self.placeholderLabel.isHidden = true // 隐藏
        return true
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        UIView.animate(withDuration: 0.4, animations: {
            self.view.frame.origin.y = -150
        })
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        return true
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            self.placeholderLabel.isHidden = false  // 显示
        }
        else{
            self.placeholderLabel.isHidden = true  // 隐藏
        }
        UIView.animate(withDuration: 0.4, animations: {
            
            self.view.frame.origin.y = 0
            
        })
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n"{
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    @objc func refreshData() {
        CBToast.showToastAction()
        self.arrayItems.removeAll()
        let url:String = "{\"txcode\":\"\(CommonData.TXCODE_GET_CHECK_ITEMS)\","
            + "\"imei\":\"\(CommonData.TERMINAL_IDENTIFICATION)\","
            + "\"maintType\":\"\(dataDetail["maintType"] as! String)\","
            + "\"liftType\":\"\(dataDetail["liftType"] as! String)\"}"
        Alamofire.request(CommonData.CONSTANT_PATH_POST_MAINT, method: .post, parameters: ["data":url], encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result.isSuccess {
            case true:
                if let value = response.result.value {
                    let json = JSON(value)
                    let rescode = json["rescode"].string!
                    let msg = json["msg"].string!
                    if rescode == "0" {
                        if(json["data"].count>0){
                            self.hiddenNullView();
                            var resultData:Dictionary = Dictionary<String,[Dictionary<String,String>]>()
                            for i in 0...(json["data"].count - 1) {
                                var data:Dictionary = Dictionary<String,String>()
                                data["itemsId"] = json["data"][i]["itemsId"].string!
                                data["itemsName"] = json["data"][i]["itemsName"].string!
                                data["checkCode"] = json["data"][i]["checkCode"].string!
                                data["checkContent"] = json["data"][i]["checkContent"].string!
                                let checkType = json["data"][i]["checkType"].string!
                                var dataArray = resultData[checkType]
                                if dataArray == nil{
                                    dataArray = [Dictionary<String,String>]()
                                }
                                dataArray?.append(data)
                                resultData[checkType] = dataArray
                            }
                            for key in resultData.keys.sorted(){
                                self.arrayItems.append(resultData[key]!)
                            }
                        }else{
                            self.showNullView();
                        }
                        self.itemsTableView.reloadData()
                        self.itemsTableView.refreshControl!.endRefreshing()
                    }else {
                        print("获取失败，原因是：\(msg)")
                    }
                }else{
                    print(response.result.value!)
                }
            case false:
                print(CommonData.LOG_CALL_INTERFACE_ERROR)
            }
            CBToast.hiddenToastAction()
        }
    }
    
    @objc func openSideMenu(){
        let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
        appDelegate.rootVC.openSideVC()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrayItems.count
    }
    
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if arrayItems.count > 0{
            return arrayItems[section].count
        }
        return 0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return String(section)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:SafeCheckItemsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "safeCheckItems") as! SafeCheckItemsTableViewCell
        if arrayItems.count>0 {
            if arrayItems[indexPath.section].count > 0{
                cell.itemContent.text = self.arrayItems[indexPath.section][indexPath.row]["checkContent"]
                let selectedPath:String = String(indexPath.section) + String(indexPath.row)
                cell.remark.tag = Int(selectedPath)!
                let remarkTapGesture = UITapGestureRecognizer(target: self, action: #selector(imageViewClick))
                cell.remark.addGestureRecognizer(remarkTapGesture)
                cell.remark.isUserInteractionEnabled = true
                
                
                cell.checkBox.tag = Int(selectedPath)!
                if CommonData.SAFE_CHECK_RESULT.keys.contains(selectedPath){
                     print(selectedPath + ":" + CommonData.SAFE_CHECK_RESULT[selectedPath]! )
                    if CommonData.SAFE_CHECK_RESULT[selectedPath] == "合格"{
                        cell.checkBox.isCheckboxSelected = true
                    }
                }else{
                    cell.checkBox.isCheckboxSelected = false
                }
                cell.checkBox.delegate = self as CheckboxDelegate
            }
        }
        return cell
    }
    
    @objc func imageViewClick(sender:UITapGestureRecognizer) {
        let tag:String = String(format: "%02d", (sender.view?.tag)!)
        let alertController = UIAlertController(title: "请检查备注",message: "", preferredStyle: .alert)
        var remark :String = ""
        if CommonData.SAFE_CHECK_REMARK.keys.contains(tag){
           remark = CommonData.SAFE_CHECK_REMARK[tag]!
        }
        alertController.addTextField {
            (textField: UITextField!) -> Void in
            textField.placeholder = "详情"
            textField.text = remark
        }
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "确定", style: .default, handler: { action in
            let remark = alertController.textFields?.first?.text
            if remark != ""{
                CommonData.SAFE_CHECK_REMARK[String(tag)] = remark
            }
        })
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func drawNullView(){
        nullIV.frame = CGRect(x:CommonData.ADMIN_SRCEEN_WIDTH / 2 - 40, y:CommonData.ADMIN_SRCEEN_HEIGHT / 2-90 , width:80,height:80)
        desLabel.text = "当前没有抽查项..."
        desLabel.frame = CGRect(x:CommonData.ADMIN_SRCEEN_WIDTH / 2 - 60, y:CommonData.ADMIN_SRCEEN_HEIGHT / 2 , width:120, height: 20)
        desLabel.adjustsFontSizeToFitWidth = true
        desLabel.textColor = UIColor.gray
        desLabel.font = UIFont.systemFont(ofSize: 13)
        self.view.addSubview(nullIV)
        self.view.addSubview(desLabel)
    }
    func showNullView(){
        nullIV.isHidden = false
        desLabel.isHidden = false
    }
    func hiddenNullView(){
        nullIV.isHidden = true
        desLabel.isHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func didSelect(_ checkbox1: CCheckbox) {
        CommonData.SAFE_CHECK_RESULT[String(format: "%02d",checkbox1.tag)] = "合格"
    }
    
    func didDeselect(_ checkbox1: CCheckbox) {
       CommonData.SAFE_CHECK_RESULT[String(format: "%02d",checkbox1.tag)] = "不合格"
    }
    
    @IBAction func safeSubmit(_ sender: Any) {
        let remark:String = summaryText.text
        if remark.isEmpty{
            let alert:UIAlertView = UIAlertView(title: "提示", message: "维保备注为空", delegate: nil, cancelButtonTitle: "确定")
            alert.show();
            return
        }
        
        var str :String = ""
        var hgCount:Int = 0
        var bhgCount:Int = 0
        for i in 0...arrayItems.count-1{
            for j in 0...arrayItems[i].count-1{
                let itemsId:String = arrayItems[i][j]["itemsId"]!
                let key:String = String(i)+String(j)
                var result:String = ""
                if CommonData.SAFE_CHECK_RESULT.keys.contains(key){
                    result = CommonData.SAFE_CHECK_RESULT[key]!
                }else{
                    result = "不合格"
                }
                if result=="合格"{
                    hgCount = hgCount + 1
                }else{
                    bhgCount = bhgCount + 1
                }
                var ramark:String = ""
                if CommonData.SAFE_CHECK_REMARK.keys.contains(key){
                    ramark = CommonData.SAFE_CHECK_REMARK[key]!
                }
                str = str + "{"+"\"itemsId\":\""+itemsId+"\",\"checkResult\":\""+result+"\",\"checkRemark\":\""+ramark+"\"},"
            }
        }
        str = String(str.prefix(str.count-1))
        str = "[" + str + "]"
        
        let result :String = "合格项：" + "\(hgCount)"+",不合格项：" + "\(bhgCount)"
        let alertController = UIAlertController(title: "提示",message: result + ",确定提交吗？", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "确定", style: .default, handler: { action in
            CBToast.showToastAction()
            let url:String = "{\"txcode\":\"\(CommonData.TXCODE_FORM_CHECK)\","
                + "\"imei\":\"\(CommonData.TERMINAL_IDENTIFICATION)\","
                + "\"clientId\":\"\(CommonData.CLIENT_ID)\","
                + "\"safeId\":\"\(CommonData.INSURE_ID)\","
                + "\"checkId\":\"\(self.dataDetail["checkId"] as! String)\","
                + "\"remark\":\"\(self.summaryText.text as! String)\","
                + "\"checkResult\":\"\(result)\","
                + "\"reason\":\"\("")\","
                + "\"resultList\":\(str)}"
            Alamofire.request(CommonData.CONSTANT_PATH_POST_MAINT, method: .post, parameters: ["data":url], encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
                switch response.result.isSuccess {
                case true:
                    if let value = response.result.value {
                        let json = JSON(value)
                        let rescode = json["rescode"].string!
                        let msg = json["msg"].string!
                        if rescode == "0" {
                            let alert:UIAlertView = UIAlertView(title: "提示", message: "提交成功", delegate: nil, cancelButtonTitle: "确定")
                            alert.show();
                            CBToast.hiddenToastAction()
                            return
                        }else {
                            print("获取失败，原因是：\(msg)")
                        }
                    }else{
                        print(response.result.value!)
                    }
                case false:
                    print(CommonData.LOG_CALL_INTERFACE_ERROR)
                }
                CBToast.hiddenToastAction()
            }
        })
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}


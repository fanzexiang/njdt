//
//  PersonnelManagementVC.swift
//  njdtmaster
//
//  Created by 尹浩 on 2018/3/20.
//  Copyright © 2018年 尹浩. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class PersonnelManagementVC: UIViewController,UITableViewDataSource,UITableViewDelegate {
    var dataArray = [Dictionary<String, String>]()
    var nullIV:UIImageView = UIImageView(image: UIImage(named: "icon_empty"))
    var desLabel:UILabel = UILabel()
    
    let titleL = UILabel()
    let searchIV = UIImageView(image: UIImage(named: "search"))
    let submitB = UIButton(frame: CGRect(x: 2, y: CommonData.ADMIN_SRCEEN_HEIGHT - 45, width: CommonData.ADMIN_SRCEEN_WIDTH - 5, height: 40))
    var personClaimTableview:UITableView = UITableView()
    var refreshControl = UIRefreshControl()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.title = "人员管理"
        self.navigationController?.navigationBar.tintColor = UIColor.white;
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        submitB.setBackgroundImage(UIImage(named: "submit_normal"), for: UIControlState.normal)
        submitB.setBackgroundImage(UIImage(named: "submit_normal_1"), for: UIControlState.selected)
        submitB.setTitle("提交", for:.normal)
        submitB.addTarget(self, action: #selector(submitClaim), for: UIControlEvents.touchUpInside)
        
        personClaimTableview.dataSource = self
        personClaimTableview.delegate = self
        personClaimTableview.frame = CGRect(x: 0,y: 5,width: CommonData.ADMIN_SRCEEN_WIDTH,height: CommonData.ADMIN_SRCEEN_HEIGHT)
        personClaimTableview.register(UINib(nibName:"PersonnelClaimTableViewCell", bundle:nil),forCellReuseIdentifier:"myCell")
        refreshControl.addTarget(self, action: #selector(refreshData),for: .valueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: "下拉刷新数据")
        personClaimTableview.addSubview(refreshControl)
        self.view.addSubview(personClaimTableview);
        refreshData()
        drawNullView()
        showNullView()
    }
    
    @objc func refreshData() {
        CBToast.showToastAction()
        self.dataArray.removeAll()
        Alamofire.request(CommonData.CONSTANT_PATH_POST_96333, method: .post, parameters: ["data":"{\"txcode\":\"\(CommonData.TXCODE_ALL_CLIENT)\",\"imei\":\"\(CommonData.TERMINAL_IDENTIFICATION)\",\"maintId\":\"\(CommonData.MAINT_ID_96333)\"}"], encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result.isSuccess {
            case true:
                if let value = response.result.value {
                    let json = JSON(value)
                    let rescode = json["rescode"].string!
                    let msg = json["msg"].string!
                    if  rescode == "0" {
                        if(json["data"].count>0){
                            self.hiddenNullView();
                            for i in 0...(json["data"].count - 1) {
                                let staffstatus = json["data"][i]["staffStatus"].string!
                                let maintId = json["data"][i]["maintId"].string!
                                if(maintId != "" && staffstatus != "2"){
                                    var personnelData:Dictionary = Dictionary<String,String>()
                                    personnelData["username"] = json["data"][i]["staffName"].string!
                                    personnelData["userphone"] = json["data"][i]["staffPhone"].string!
                                    personnelData["id_hidden"] = json["data"][i]["id"].string!
                                    self.dataArray.append(personnelData)
                                }
                            }
                            self.personClaimTableview.tableFooterView = self.submitB
                        }else{
                            self.showNullView();
                        }
                        self.personClaimTableview.reloadData()
                        self.refreshControl.endRefreshing()
                        CBToast.hiddenToastAction()
                    }else{
                        print("获取失败，原因是：\(msg)")
                    }
                }else{
                    print(response.result.value!)
                }
            case false:
                print(CommonData.LOG_CALL_INTERFACE_ERROR)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:PersonnelClaimTableViewCell = tableView.dequeueReusableCell(withIdentifier: "myCell") as! PersonnelClaimTableViewCell
        if(dataArray.count>0){
            let item = self.dataArray[indexPath.row]
            cell.userImage.image = UIImage(named: "icon_checkbox_xm")
            cell.phoneImage.image = UIImage(named: "icon_checkbox_dh")
            cell.userLabel.text = item["username"]
            cell.phoneLabel.text = item["userphone"]
            cell.checkbox.isCheckboxSelected = true
            cell.checkbox.delegate = self as CheckboxDelegate
            cell.checkbox.animation = .showHideTransitionViews
            cell.checkbox.tag = indexPath.row
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    @objc func submitClaim (sender: UIButton){
        Alamofire.request(CommonData.CONSTANT_PATH_POST_96333, method: .post, parameters: ["data":"{\"claim\":\"\",\"logoff\":\"\(CommonData.PERSONNEL_LOGOFF_ARRAY)\",\"txcode\":\"\(CommonData.TXCODE_CLAIM)\",\"maintId\":\"\(CommonData.MAINT_ID)\",\"imei\":\"\(CommonData.TERMINAL_IDENTIFICATION)\"}"], encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result.isSuccess {
            case true:
                if let value = response.result.value {
                    let json = JSON(value)
                    let rescodeTmp = json["rescode"].string!
                    let msgTmp = json["msg"].string!
                    print("获取成功，原因是：\(msgTmp)")
                }else{
                    print(response.result.value!)
                }
            case false:
                print(CommonData.LOG_CALL_INTERFACE_ERROR)
            }
        }
    }
    func drawNullView(){
        nullIV.frame = CGRect(x:CommonData.ADMIN_SRCEEN_WIDTH / 2 - 40, y:CommonData.ADMIN_SRCEEN_HEIGHT / 2-90 , width:80,height:80)
        desLabel.text = "当前没有记录..."
        desLabel.frame = CGRect(x:CommonData.ADMIN_SRCEEN_WIDTH / 2 - 40, y:CommonData.ADMIN_SRCEEN_HEIGHT / 2 , width:120, height: 20)
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
}
extension PersonnelManagementVC: CheckboxDelegate {
    func didSelect(_ checkbox1: CCheckbox) {
        print("当前取消选中编号：\(checkbox1.tag)")
        if CommonData.PERSONNEL_LOGOFF_ARRAY.count > 0 {
            CommonData.PERSONNEL_LOGOFF_ARRAY.remove(at: CommonData.PERSONNEL_LOGOFF_ARRAY.index(of: self.dataArray[checkbox1.tag]["id_hidden"]!)!)
        }else{
            print("待认领人员数组为空！")
        }
    }
    
    func didDeselect(_ checkbox1: CCheckbox) {
        print("当前选中编号：\(checkbox1.tag)")
        CommonData.PERSONNEL_LOGOFF_ARRAY.append(self.dataArray[checkbox1.tag]["id_hidden"]!)
        for value in CommonData.PERSONNEL_LOGOFF_ARRAY{
            print(value)
        }
    }
}

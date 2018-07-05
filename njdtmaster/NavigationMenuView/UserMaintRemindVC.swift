//
//  UserMaintRemindVC.swift
//  njdtmaster
//
//  Created by ihoou on 2018/5/25.
//  Copyright © 2018年 尹浩. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class UserMaintRemindVC : UITableViewController{
    var dataArray = [Dictionary<String, String>]()
    var nullIV:UIImageView = UIImageView(image: UIImage(named: "icon_empty"))
    var desLabel:UILabel = UILabel()
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
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl!.addTarget(self, action: #selector(refreshData),for: .valueChanged)
        self.refreshControl!.attributedTitle = NSAttributedString(string: "下拉刷新数据")
        self.tableView.register(UINib(nibName:"UserMaintRemindTableViewCell", bundle:nil),forCellReuseIdentifier:"userMaintRemind")
        refreshData()
        drawNullView()
        showNullView()
    }
    
    @objc func refreshData() {
        CBToast.showToastAction()
        self.dataArray.removeAll()
        let url:String = "{\"txcode\":\"\(CommonData.TXCODE_USERS_MAINT_REMIND)\","
            + "\"imei\":\"\(CommonData.TERMINAL_IDENTIFICATION)\","
            + "\"companyId\":\"\(CommonData.COMPANY_ID)\","
            + "\"clientId\":\"\(CommonData.CLIENT_ID)\"}"
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
                            for i in 0...(json["data"].count - 1) {
                                var resultData:Dictionary = Dictionary<String,String>()
                                resultData["formId"] = json["data"][i]["formId"].string!
                                resultData["formcode"] = json["data"][i]["formcode"].string!
                                resultData["liftcode"] = json["data"][i]["liftcode"].string!
                                resultData["regode"] = json["data"][i]["regode"].string!
                                resultData["liftaddress"] = json["data"][i]["liftaddress"].string!
                                resultData["companyName"] = json["data"][i]["companyName"].string!
                                resultData["planDate"] = json["data"][i]["planDate"].string!
                                resultData["maintainName"] = json["data"][i]["maintainName"].string!
                                resultData["checkTimes"] = json["data"][i]["checkTimes"].string!
                                resultData["maintainlevel"] = json["data"][i]["maintainlevel"].string!
                                resultData["formStatus"] = json["data"][i]["formStatus"].string!
                                resultData["maintType"] = json["data"][i]["maintType"].string!
                                self.dataArray.append(resultData)
                            }
                        }else{
                            self.showNullView();
                        }
                        self.tableView.reloadData()
                        self.refreshControl!.endRefreshing()
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
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UserMaintRemindTableViewCell = tableView.dequeueReusableCell(withIdentifier: "userMaintRemind") as! UserMaintRemindTableViewCell
        if dataArray.count>0 {
            let item = self.dataArray[indexPath.row]
            cell.formCode.text = item["formcode"]
            cell.planDate.text = item["planDate"]
            cell.liftIdCode.text = item["liftcode"]
            cell.checkTimes.text = item["checkTimes"]! + "次"
            cell.maintName.text = item["maintainName"]
        }
        return cell
    }
    
    func drawNullView(){
        nullIV.frame = CGRect(x:CommonData.ADMIN_SRCEEN_WIDTH / 2 - 40, y:CommonData.ADMIN_SRCEEN_HEIGHT / 2-90 , width:80,height:80)
        desLabel.text = "当前没有维保计划..."
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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }

}

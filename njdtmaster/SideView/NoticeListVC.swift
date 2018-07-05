//
//  NoticeInfoSubViewController.swift
//  njdtmaster
//
//  Created by 尹浩 on 2018/3/14.
//  Copyright © 2018年 尹浩. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class NoticeListVC:UITableViewController  {
    var dataArray = [Dictionary<String, String>]()
    var nullIV:UIImageView = UIImageView(image: UIImage(named: "icon_empty"))
    var desLabel:UILabel = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.title = "公告列表"
        self.navigationController?.navigationBar.tintColor = UIColor.white;
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl!.addTarget(self, action: #selector(refreshData),for: .valueChanged)
        self.refreshControl!.attributedTitle = NSAttributedString(string: "下拉刷新数据")
//        self.tableView.register(UINib(nibName:"MaintPlanTableViewCell", bundle:nil),forCellReuseIdentifier:"maintPlanCell")
        refreshData()
        drawNullView()
        showNullView()
    }
    
    @objc func refreshData() {
        self.dataArray.removeAll()
        Alamofire.request(CommonData.CONSTANT_PATH_POST_96333, method: .post, parameters: ["data":"{\"txcode\":\"\(CommonData.TXCODE_GET_ANNOUNCEMENT)\",\"imei\":\"\(CommonData.TERMINAL_IDENTIFICATION)\",\"maintId\":\"\(CommonData.MAINT_ID_96333)\"}"], encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
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
                                resultData["title"] = json["data"][i]["title"].string!
                                resultData["announcer"] = json["data"][i]["announcer"].string!
                                resultData["announcTime"] = json["data"][i]["announcTime"].string!
                                self.dataArray.append(resultData)
                            }
                        }else{
                            self.showNullView()
                        }
                        self.tableView.reloadData()
                        self.refreshControl!.endRefreshing()
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
    @objc func openSideMenu(){
        print("展开侧边菜单")
        //TODO
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
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "noticeCell")!
        if dataArray.count>0 {
            let item = self.dataArray[indexPath.row]
            cell.textLabel?.text = item["title"]
            cell.detailTextLabel?.text = item["announcTime"]
        }
        return cell
    }
    
    func drawNullView(){
        nullIV.frame = CGRect(x:CommonData.ADMIN_SRCEEN_WIDTH / 2 - 40, y:CommonData.ADMIN_SRCEEN_HEIGHT / 2-90 , width:80,height:80)
        desLabel.text = "当前没有公告信息..."
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
        tabBarController?.tabBar.isHidden = true
    }
}

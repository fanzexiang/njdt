//
//  ResuceTaskViewController.swift
//  XYSideViewControllerSwiftDemo
//
//  Created by 尹浩 on 2018/3/12.
//  Copyright © 2018年 FireHsia. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ResuceTaskVC: UITableViewController {
    
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
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        
        
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
        self.tableView.register(UINib(nibName:"ResuceTaskTableViewCell", bundle:nil),forCellReuseIdentifier:"resuceTaskCell")
    
        refreshData()
        drawNullView()
        showNullView()
    }
    @objc func refreshData() {
        CBToast.showToastAction()
        self.dataArray.removeAll()
        Alamofire.request(CommonData.CONSTANT_PATH_POST_96333, method: .post, parameters: ["data":"{\"txcode\":\"\(CommonData.TXCODE_PENDING_FORM)\",\"maintId\":\"\(CommonData.MAINT_ID_96333)\",\"imei\":\"\(CommonData.TERMINAL_IDENTIFICATION)\"}"], encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
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
                                var resuceData:Dictionary = Dictionary<String,String>()
                                resuceData["title"] = json["data"][i]["LIFTIDCODE"].string!
                                resuceData["date"] = json["data"][i]["FORMCREATETIME"].string!
                                resuceData["company"] = json["data"][i]["LIFTUSER"].string!
                                resuceData["address"] = json["data"][i]["LIFTADD"].string!
                                resuceData["lat"] = "\(json["data"][i]["LATITUDE"].double!)"
                                resuceData["lng"] = "\(json["data"][i]["LONGITUDE"].double!)"
                                resuceData["formid"] = json["data"][i]["FORMID"].string!
                                self.dataArray.append(resuceData)
                            }
                        }else{
                            self.showNullView();
                        }
                        
                        self.tableView.reloadData()
                        self.refreshControl!.endRefreshing()
                        CBToast.hiddenToastAction()
                    }else{
                        print("获取成功，原因是：\(msg)")
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
        let cell:ResuceTaskTableViewCell = tableView.dequeueReusableCell(withIdentifier: "resuceTaskCell") as! ResuceTaskTableViewCell
        if(dataArray.count>0){
            let item = self.dataArray[indexPath.row]
            cell.customTitleLabel.text = item["title"]
            cell.customDateLabel.text = item["date"]
            cell.customCompanyLabel.text = item["company"]
            cell.customAddressLabel.text = item["address"]
            cell.customImage.image = UIImage(named: "icon_callout")
            let singleTapGesture = UITapGestureRecognizer(target: self, action: #selector(imageViewClick))
            cell.customImage?.addGestureRecognizer(singleTapGesture)
            cell.customImage?.isUserInteractionEnabled = true
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let resuceMapVC = ResuceMapViewController()
        resuceMapVC.title = CommonData.TITLE_NAVI_RESUCE_MAP
        resuceMapVC.dataDetail = self.dataArray[indexPath.row]
        self.navigationController?.pushViewController(resuceMapVC, animated: true)
    }
    
    @objc func imageViewClick(sender:UITapGestureRecognizer) {
        let urlString = "tel://96333"
        if let url = URL(string: urlString) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:],
                                          completionHandler: {
                                            (success) in
                })
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    func drawNullView(){
        nullIV.frame = CGRect(x:CommonData.ADMIN_SRCEEN_WIDTH / 2 - 40, y:CommonData.ADMIN_SRCEEN_HEIGHT / 2-90 , width:80,height:80)
        desLabel.text = "当前没有救援任务..."
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


    
   
    






//
//  SafeCheckDetailVC.swift
//  njdtmaster
//
//  Created by ihoou on 2018/5/31.
//  Copyright © 2018年 尹浩. All rights reserved.
//

import UIKit

class SafeCheckDetailVC: UIViewController {
    @IBOutlet weak var formcode: UILabel!
    @IBOutlet weak var liftcode: UILabel!
    @IBOutlet weak var companyname: UILabel!
    @IBOutlet weak var liftAdd: UILabel!
    @IBOutlet weak var maintName: UILabel!
    @IBOutlet weak var maintTel: UILabel!
    @IBOutlet weak var maintType: UILabel!
    @IBOutlet weak var checkTime: UILabel!
    @IBOutlet weak var checkResult: UILabel!
    @IBOutlet weak var checkReason: UILabel!
    
   var dataDetail:Dictionary = Dictionary<String,String>()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.title = "抽查详情"
        self.navigationController?.navigationBar.tintColor = UIColor.white;
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        self.navigationController?.navigationBar.topItem?.title = "";  
        formcode.text = dataDetail["formcode"]
        liftcode.text = dataDetail["liftcode"]
        companyname.text = dataDetail["companyName"]
        liftAdd.text = dataDetail["liftaddress"]
        maintName.text = dataDetail["maintainName"]
        maintTel.text = dataDetail["maintTel"]
        maintType.text = CommonData.MAINTTYPE[dataDetail["maintType"]!]
        checkTime.text = dataDetail["checkTime"]
        checkResult.text = dataDetail["checkResult"]
        checkReason.text = dataDetail["reason"]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

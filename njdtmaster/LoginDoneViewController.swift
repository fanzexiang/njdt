//
//  LoginDoneViewController.swift
//  njdtmaster
//
//  Created by 尹浩 on 2018/1/31.
//  Copyright © 2018年 尹浩. All rights reserved.
//

import UIKit

class LoginDoneViewController: UIViewController {
    var users = User()
    
    @IBOutlet weak var logRole: UILabel!
    @IBOutlet weak var logUser: UILabel!
    @IBOutlet weak var logPhone: UILabel!
    
    @IBAction func toBack(_ sender: AnyObject) {
        
        self.presentingViewController!.dismiss(animated: true, completion: nil)
    }
    @IBAction func loadTest(_ sender: Any) {
        
        let toast = ToastView()
        toast.showLoadingDlg()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logRole.text = users.userRole
        logUser.text = users.userName
        logPhone.text = users.userPhone
        
    }
    
    @objc func viewDidTap(tapGR: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
         super.didReceiveMemoryWarning()
    }
}

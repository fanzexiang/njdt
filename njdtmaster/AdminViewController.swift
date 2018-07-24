//
//  AdminViewController.swift
//  njdtmaster
//
//  Created by zexiang on 7/18/18.
//  Copyright © 2018 尹浩. All rights reserved.
//

import UIKit

class AdminViewController: UIViewController {
    var admins = User()
    
    
    @IBOutlet weak var adminRole: UILabel!
    @IBOutlet weak var adminUser: UILabel!
    @IBOutlet weak var adminPhone: UILabel!
    
    
    
    @IBAction func toBack(_ sender: AnyObject) {
        
        self.presentingViewController!.dismiss(animated: true, completion: nil)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
        adminRole.text = admins.userRole
        adminUser.text = admins.userName
        adminPhone.text = admins.userPhone
        
        
        // Do any additional setup after loading the view.
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

//
//  UserRescueRemindTableViewCell.swift
//  njdtmaster
//
//  Created by ihoou on 2018/5/24.
//  Copyright © 2018年 尹浩. All rights reserved.
//

import UIKit
class UserRescueRemindTableViewCell:UITableViewCell{
    @IBOutlet weak var liftIdCode: UILabel!
    @IBOutlet weak var formTime: UILabel!
    @IBOutlet weak var liftRescueProgressCode: UILabel!
    @IBOutlet weak var liftMaintName: UILabel!
    @IBOutlet weak var liftRecourseTel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }    
    
}

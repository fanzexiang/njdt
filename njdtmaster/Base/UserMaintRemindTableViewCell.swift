//
//  UserMaintRemindTableViewCell.swift
//  njdtmaster
//
//  Created by ihoou on 2018/5/25.
//  Copyright © 2018年 尹浩. All rights reserved.
//

import UIKit
class UserMaintRemindTableViewCell:UITableViewCell{
    @IBOutlet weak var formCode: UILabel!
    @IBOutlet weak var planDate: UILabel!
    @IBOutlet weak var liftIdCode: UILabel!

    @IBOutlet weak var checkTimes: UILabel!
    
    @IBOutlet weak var maintName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

//
//  UserInspectRemindTableViewCell.swift
//  njdtmaster
//
//  Created by ihoou on 2018/5/25.
//  Copyright © 2018年 尹浩. All rights reserved.
//

import UIKit

class UserInspectRemindTableViewCell:UITableViewCell{
    @IBOutlet weak var liftIdCode: UILabel!
    
    @IBOutlet weak var nextInspect: UILabel!
    
    @IBOutlet weak var maintName: UILabel!
    @IBOutlet weak var liftAddress: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

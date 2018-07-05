//
//  UserRescueRecordTableViewCell.swift
//  njdtmaster
//
//  Created by ihoou on 2018/5/28.
//  Copyright © 2018年 尹浩. All rights reserved.
//

import UIKit
class UserRescueRecordTableViewCell:UITableViewCell{
    
    @IBOutlet weak var liftIdCode: UILabel!
    @IBOutlet weak var maintName: UILabel!
    @IBOutlet weak var startTime: UILabel!
    @IBOutlet weak var contact: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

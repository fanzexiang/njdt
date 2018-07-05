//
//  SafeCheckPlanTableViewCell.swift
//  njdtmaster
//
//  Created by ihoou on 2018/5/30.
//  Copyright © 2018年 尹浩. All rights reserved.
//

import Foundation
class SafeCheckPlanTableViewCell: UITableViewCell {
    @IBOutlet weak var formcode: UILabel!
    @IBOutlet weak var planDate: UILabel!
    @IBOutlet weak var liftcode: UILabel!
    @IBOutlet weak var liftType: UILabel!
    @IBOutlet weak var checkTimes: UILabel!
    @IBOutlet weak var maintName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

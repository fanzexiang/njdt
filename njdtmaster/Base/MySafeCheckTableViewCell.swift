//
//  MySafeCheckTableViewCell.swift
//  njdtmaster
//
//  Created by ihoou on 2018/5/31.
//  Copyright © 2018年 尹浩. All rights reserved.
//

import Foundation
class MySafeCheckTableViewCell: UITableViewCell {
    
    @IBOutlet weak var formcode: UILabel!
    @IBOutlet weak var liftcode: UILabel!
    @IBOutlet weak var maintName: UILabel!
    @IBOutlet weak var checkType: UILabel!
    @IBOutlet weak var liftType: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

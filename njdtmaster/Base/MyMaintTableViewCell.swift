//
//  MyMaintTableViewCell.swift
//  njdtmaster
//
//  Created by ihoou on 2018/5/17.
//  Copyright © 2018年 尹浩. All rights reserved.
//

import Foundation
import UIKit
class MyMaintTableViewCell: UITableViewCell {
    
    @IBOutlet weak var formcode: UILabel!
    @IBOutlet weak var plandate: UILabel!
    @IBOutlet weak var liftcode: UILabel!
    @IBOutlet weak var maintstarttime: UILabel!
    @IBOutlet weak var maintendtime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

//
//  MyRescueTableViewCell.swift
//  njdtmaster
//
//  Created by ihoou on 2018/5/18.
//  Copyright © 2018年 尹浩. All rights reserved.
//

import Foundation
import UIKit

class MyRescueTableViewCell:UITableViewCell{
    @IBOutlet weak var liftuser: UILabel!
    @IBOutlet weak var liftidcode: UILabel!
    @IBOutlet weak var protime: UILabel!    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

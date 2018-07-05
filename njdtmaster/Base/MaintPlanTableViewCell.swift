//
//  MaintPlanTableViewCell.swift
//  njdtmaster
//
//  Created by 尹浩 on 2018/3/30.
//  Copyright © 2018年 尹浩. All rights reserved.
//

import UIKit

class MaintPlanTableViewCell: UITableViewCell {
    
    @IBOutlet weak var customView: UIView!
    
    @IBOutlet weak var orderId: UILabel!
    @IBOutlet weak var codeId: UILabel!
    @IBOutlet weak var dateTime: UILabel!
    @IBOutlet weak var address: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //设置cell是有圆角边框显示
        //customView.layer.cornerRadius = 9
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

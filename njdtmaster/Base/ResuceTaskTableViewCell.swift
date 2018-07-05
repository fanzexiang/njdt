//
//  ResuceTaskTableViewCell.swift
//  njdtmaster
//
//  Created by 尹浩 on 2018/3/23.
//  Copyright © 2018年 FireHsia. All rights reserved.
//

import UIKit

class ResuceTaskTableViewCell: UITableViewCell {

    @IBOutlet weak var customView: UIView!
    
    @IBOutlet weak var customTitleLabel: UILabel!
    @IBOutlet weak var customDateLabel: UILabel!
    @IBOutlet weak var customCompanyLabel: UILabel!
    @IBOutlet weak var customAddressLabel: UILabel!
    
    @IBOutlet weak var customImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }    
}

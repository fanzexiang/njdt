//
//  ResuceTaskTableViewCell.swift
//  njdtmaster
//
//  Created by 尹浩 on 2018/3/23.
//  Copyright © 2018年 FireHsia. All rights reserved.
//

import UIKit

class PersonnelClaimTableViewCell: UITableViewCell {

    @IBOutlet weak var customView: SearchTableView!
    
    @IBOutlet weak var checkbox: CCheckbox!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var phoneImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        //设置cell是有圆角边框显示
//        customView.layer.cornerRadius = 9
//        checkbox.delegate = self
//        checkbox.animation = .showHideTransitionViews
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }    
}







//
//  SafeCheckItemsTableViewCell.swift
//  njdtmaster
//
//  Created by ihoou on 2018/6/4.
//  Copyright © 2018年 尹浩. All rights reserved.
//

import UIKit
class SafeCheckItemsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var itemContent: UILabel!
    @IBOutlet weak var checkBox: CCheckbox!
    @IBOutlet weak var remark: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

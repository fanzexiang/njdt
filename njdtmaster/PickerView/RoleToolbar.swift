//
//  RoleToolbar.swift
//  njdtmaster
//
//  Created by 尹浩 on 2018/1/17.
//  Copyright © 2018年 尹浩. All rights reserved.
//

import UIKit

protocol RoleToolbarDelegate: class {
    

    func sure(roleToolbar: RoleToolbar, textField: UITextField, role: Role, item: UIBarButtonItem)
    func cancel(roleToolbar: RoleToolbar, textField: UITextField, role: Role, item: UIBarButtonItem)
}


class RoleToolbar: UIToolbar {
    
    weak var barDelegate: RoleToolbarDelegate?
    var textField: UITextField!
    
    static func bar<T: UIViewController>(for controller: T, textField: UITextField, barTintColor: UIColor, tintColor: UIColor) -> RoleToolbar where T: RoleToolbarDelegate {
        let toolBar = RoleToolbar()
        toolBar.textField = textField
        toolBar.barDelegate = controller
        
        let cancelItem = UIBarButtonItem(title: "取消", style: .plain, target: toolBar, action: #selector(rolePickerCancel(_:)))
        let flexibleItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let sureItem = UIBarButtonItem(title: "确定", style: .plain, target: toolBar, action: #selector(rolePickerSure(_:)))
        toolBar.items = [cancelItem, flexibleItem, sureItem]
                
        toolBar.barTintColor = barTintColor
        toolBar.tintColor = tintColor
        return toolBar
    }
    
    private init(){
        super.init(frame: CGRect(x: 0, y: 0, width: CommonData.ADMIN_SRCEEN_WIDTH, height: 44))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func rolePickerCancel(_ item: UIBarButtonItem) {
        textField.resignFirstResponder()
        barDelegate?.cancel(roleToolbar: self, textField: textField, role: role, item: item)
    }
    
    @objc func rolePickerSure(_ item: UIBarButtonItem) {
        textField.resignFirstResponder()
        barDelegate?.sure(roleToolbar: self, textField: textField, role: role, item: item)
    }
    
    
    // MARK: - lazy
    lazy var role: Role = {
        return Role()
    }()
}

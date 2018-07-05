//
//  FaultTypeToolbar.swift
//  njdtmaster
//
//  Created by 尹浩 on 2018/3/19.
//  Copyright © 2018年 尹浩. All rights reserved.
//

import UIKit

protocol FaultTypeToolbarDelegate: class {
    
    
    func sure(roleToolbar: FaultTypeToolbar, textField: UITextField, faultType: FaultType, item: UIBarButtonItem)
    func cancel(roleToolbar: FaultTypeToolbar, textField: UITextField, faultType: FaultType, item: UIBarButtonItem)
}


class FaultTypeToolbar: UIToolbar {
    
    weak var barDelegate: FaultTypeToolbarDelegate?
    var textField: UITextField!
    
    static func bar<T: UIViewController>(for controller: T, textField: UITextField, barTintColor: UIColor, tintColor: UIColor) -> FaultTypeToolbar where T: FaultTypeToolbarDelegate {
        let toolBar = FaultTypeToolbar()
        toolBar.textField = textField
        toolBar.barDelegate = controller
        
        let cancelItem = UIBarButtonItem(title: "取消", style: .plain, target: toolBar, action: #selector(faultTypePickerCancel(_:)))
        let flexibleItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let sureItem = UIBarButtonItem(title: "确定", style: .plain, target: toolBar, action: #selector(faultTypePickerSure(_:)))
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
    
    @objc func faultTypePickerCancel(_ item: UIBarButtonItem) {
        textField.resignFirstResponder()
        barDelegate?.cancel(roleToolbar: self, textField: textField, faultType: faultType, item: item)
    }
    
    @objc func faultTypePickerSure(_ item: UIBarButtonItem) {
        textField.resignFirstResponder()
        barDelegate?.sure(roleToolbar: self, textField: textField, faultType: faultType, item: item)
    }
    
    
    // MARK: - lazy
    lazy var faultType: FaultType = {
        return FaultType()
    }()
}


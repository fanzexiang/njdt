//
//  InspectionToolbar.swift
//  njdtmaster
//
//  Created by 尹浩 on 2018/1/29.
//  Copyright © 2018年 尹浩. All rights reserved.
//

import UIKit

protocol InspectionToolbarDelegate: class {
    func sure(inspectionToolbar: InspectionToolbar, textField: UITextField, inspection: Inspection, item: UIBarButtonItem)
    func cancel(inspectionToolbar: InspectionToolbar, textField: UITextField, inspection: Inspection, item: UIBarButtonItem)
}

class InspectionToolbar: UIToolbar {
    weak var barDelegate: InspectionToolbarDelegate?
    var textField: UITextField!
    
    static func bar <T: UIViewController> (for controller: T, textField: UITextField, barTintColor: UIColor, tintColor: UIColor ) -> InspectionToolbar where T: InspectionToolbarDelegate{
        let toolBar = InspectionToolbar()
        toolBar.textField = textField
        toolBar.barDelegate = controller
        let cancelItem = UIBarButtonItem(title: "取消", style: .plain, target: toolBar, action: #selector(inspectionPickerCancel(_:)))
        let flexibleItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let sureItem = UIBarButtonItem(title: "确定", style: .plain, target: toolBar, action: #selector(inspectionPickerSure(_:)))
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
    
    
    @objc func inspectionPickerCancel(_ item: UIBarButtonItem) {
        textField.resignFirstResponder()
        barDelegate?.cancel(inspectionToolbar: self, textField: textField, inspection: inspection, item: item)
    }
    
    @objc func inspectionPickerSure(_ item: UIBarButtonItem) {
        textField.resignFirstResponder()
        barDelegate?.sure(inspectionToolbar: self, textField: textField, inspection: inspection, item: item)
    }
    
    
    // MARK: - lazy
    lazy var inspection: Inspection = {
        return Inspection()
    }()
}

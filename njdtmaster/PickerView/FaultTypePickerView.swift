//
//  FaultTypePickerView.swift
//  njdtmaster
//
//  Created by 尹浩 on 2018/3/19.
//  Copyright © 2018年 尹浩. All rights reserved.
//

import UIKit

protocol FaultTypePickerViewDelegate: class {
    func statusChanged(faultTypePickerView: FaultTypePickerView, pickerView: UIPickerView, textField: UITextField, faultType: FaultType)
}

protocol FaultTypePickerDelegate: FaultTypePickerViewDelegate, FaultTypeToolbarDelegate {}

class FaultTypePickerView: UIView {
    
    var cities = [[String: AnyObject]]()
    var areas = [String]()
    var textField: UITextField!
    var pickerView:UIPickerView!
    var toolbar: FaultTypeToolbar!
    
    
    weak var delegate: FaultTypePickerViewDelegate?
    
    static func faultTypepicker<FTcontroller: UIViewController>(for controller: FTcontroller, textField: UITextField, barTintColor: UIColor = CommonData.AP_DEFAULT_BAR_TINT_COLOR, tintColor: UIColor = UIColor.white) -> FaultTypePickerView where FTcontroller: FaultTypePickerDelegate {
        //        print("the vaule is \(String(describing: textField.text))")
        
        
        let faultTypePickerView = FaultTypePickerView()
        faultTypePickerView.delegate = controller
        faultTypePickerView.textField = textField
        
        let pickerView = UIPickerView()
        pickerView.backgroundColor = UIColor.white
        faultTypePickerView.pickerView = pickerView
        
        pickerView.delegate = faultTypePickerView
        pickerView.dataSource = faultTypePickerView
        
        faultTypePickerView.cities = faultTypePickerView.rolelists[0][CommonData.citiesKey] as! [[String : AnyObject]]!
        if let province = faultTypePickerView.rolelists[0][CommonData.stateKey] as? String {
            faultTypePickerView.faulttypesource.first = province
        }
        
        if let second = faultTypePickerView.cities[0][CommonData.cityKey] as? String {
            faultTypePickerView.faulttypesource.second = second
        }
        
        
        faultTypePickerView.areas = faultTypePickerView.cities[0][CommonData.areasKey] as! [String]!
        
        if faultTypePickerView.areas.count > 0 {
            faultTypePickerView.faulttypesource.area = faultTypePickerView.areas[0]
        } else {
            faultTypePickerView.faulttypesource.area = ""
        }
        
        textField.inputView = pickerView
        faultTypePickerView.toolbar = FaultTypeToolbar.bar(for: controller, textField: textField, barTintColor: CommonData.AP_DEFAULT_BAR_TINT_COLOR, tintColor: UIColor.white)
        textField.inputAccessoryView = faultTypePickerView.toolbar
        
        
        return faultTypePickerView
    }
    
    private init(){
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //    deinit {
    //        print("地址选择器被销毁")
    //    }
    
    func shouldSelected(proName: String, cityName: String, areaName: String?) {
        
        for index in 0..<rolelists.count {
            let pro = rolelists[index]
            if pro[CommonData.stateKey] as! String == proName {
                cities = rolelists[index][CommonData.citiesKey] as! [[String : AnyObject]]!
                if let first = rolelists[index][CommonData.stateKey] as? String {
                    faulttypesource.first = first
                }
                pickerView.selectRow(index, inComponent: CommonData.PickerType.first.rawValue, animated: false)
                break
            }
        }
        
        for index in 0..<cities.count {
            let second = cities[index]
            if second[CommonData.cityKey] as! String == cityName {
                if let second = cities[index][CommonData.cityKey] as? String {
                    faulttypesource.second = second
                }
                
                areas = cities[index][CommonData.areasKey] as! [String]!
                pickerView.selectRow(index, inComponent: CommonData.PickerType.second.rawValue, animated: false)
                break
            }
        }
        
        if areaName != nil {
            
            for (index, name) in areas.enumerated() {
                if name == areaName! {
                    faulttypesource.area = areas[index]
                    pickerView.selectRow(index, inComponent: CommonData.PickerType.area.rawValue, animated: false)
                    break
                }
            }
        }
        
    }
    
    
    // MARK: - lazy
    lazy var rolelists: [[String: AnyObject]] = {
        let path = Bundle.main.path(forResource: "faultType", ofType: "plist")
        return NSArray(contentsOfFile: path!) as! [[String: AnyObject]]
    }()
    
    lazy var faulttypesource: FaultType = {
        return FaultType()
    }()
    
    func taylorSwift(){
        print("Taylor Swift")
    }
    
}

extension FaultTypePickerView: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        let pickerType = CommonData.PickerType(rawValue: component)!
        switch pickerType {
        case .first:
            return rolelists.count
        case .second:
            return cities.count
        case .area:
            return areas.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let pickerType = CommonData.PickerType(rawValue: component)!
        switch pickerType {
        case .first:
            return rolelists[row][CommonData.stateKey] as! String?
        case .second:
            return cities[row][CommonData.cityKey] as! String?
        case .area:
            if areas.count > 0 {
                return areas[row]
            } else {
                return ""
            }
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //        print("选中了某一行")
        let pickerType = CommonData.PickerType(rawValue: component)!
        switch pickerType {
        case .first:
            
            cities = rolelists[row][CommonData.citiesKey] as! [[String : AnyObject]]!
            pickerView.reloadComponent(CommonData.PickerType.second.rawValue)
            pickerView.selectRow(0, inComponent: CommonData.PickerType.second.rawValue, animated: true)
            reloadAreaComponent(pickerView: pickerView, row: 0)
            if let first = rolelists[row][CommonData.stateKey] as? String {
                faulttypesource.first = first
            }
            //            print("当前选中的是：\(rolesource.first)")
            
        case .second:
            reloadAreaComponent(pickerView: pickerView, row: row)
        case .area:
            if areas.count > 0 {
                faulttypesource.area = areas[row]
            } else {
                faulttypesource.area = ""
            }
        }
        
        toolbar.faultType = faulttypesource
        delegate?.statusChanged(faultTypePickerView: self, pickerView: pickerView, textField: textField, faultType: faulttypesource)
        
    }
    
    func reloadAreaComponent(pickerView: UIPickerView, row: Int) {
        
        
        guard row <= cities.count - 1 else {
            return
        }
        
        areas = cities[row][CommonData.areasKey] as! [String]!
        pickerView.reloadComponent(CommonData.PickerType.area.rawValue)
        pickerView.selectRow(0, inComponent: CommonData.PickerType.area.rawValue, animated: true)
        
        if let second = cities[row][CommonData.cityKey] as? String {
            faulttypesource.second = second
        }
        if areas.count > 0 {
            faulttypesource.area = areas[0]
        } else {
            faulttypesource.area = ""
        }
        
    }
}


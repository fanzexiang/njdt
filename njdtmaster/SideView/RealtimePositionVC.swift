//
//  RealtimePositionVC.swift
//  njdtmaster
//
//  Created by 尹浩 on 2018/3/20.
//  Copyright © 2018年 尹浩. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class RealtimePositionVC: UIViewController,BMKMapViewDelegate{
    var _mapView: BMKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.title = "实时位置"
        self.navigationController?.navigationBar.tintColor = UIColor.white;
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        _mapView = BMKMapView.init(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        _mapView.zoomLevel = 12
        _mapView.centerCoordinate = CLLocationCoordinate2D.init(latitude: 32.067428, longitude: 118.802316);
        _mapView.isTrafficEnabled = false
        _mapView.isBuildingsEnabled = true
        _mapView.showMapPoi = true
        self.view.addSubview(_mapView)
        CBToast.showToastAction();
        addPointAnnotation()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
        _mapView.viewWillAppear()
        _mapView.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        _mapView.viewWillDisappear()
        _mapView.delegate = nil
    }
    
    //添加标注
    func addPointAnnotation() {
        _mapView.removeAnnotations(_mapView.annotations)
        Alamofire.request(CommonData.CONSTANT_PATH_POST_96333, method: .post, parameters: ["data":"{\"txcode\":\"\(CommonData.TXCODE_GET_ALL_POSITION)\",\"imei\":\"\(CommonData.TERMINAL_IDENTIFICATION)\",\"maintId\":\"\(CommonData.MAINT_ID_96333)\"}"], encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result.isSuccess {
            case true:
                if let value = response.result.value {
                    let json = JSON(value)
                    let rescode = json["rescode"].string!
                    let msg = json["msg"].string!
                    if  rescode == "0" {
                        if(json["data"].count>0){
                            for i in 0...(json["data"].count - 1) {
                                let pointAnnotation = BMKPointAnnotation()
                                pointAnnotation.title = json["data"][i]["staffName"].string!
                                let lat:String = json["data"][i]["latitude"].string!
                                let lng:String = json["data"][i]["longitude"].string!
                                if(lat != "" && lng != ""){
                                    pointAnnotation.coordinate = CLLocationCoordinate2DMake((lat as NSString).doubleValue,(lng as NSString).doubleValue)
                                    self._mapView.addAnnotation(pointAnnotation)
                                }
                            }
                        }
                    }else{
                        print("获取成功，原因是：\(msg)")
                    }
                    CBToast.hiddenToastAction()
                }else{
                    print(response.result.value!)
                }
            case false:
                print(CommonData.LOG_CALL_INTERFACE_ERROR)
            }
        }
    }
    
    func mapView(_ mapView: BMKMapView!, viewFor annotation: BMKAnnotation!) -> BMKAnnotationView! {
        // 动画标注
//        if (annotation as! BMKPointAnnotation) == animatedAnnotation {
//            let AnnotationViewID = "AnimatedAnnotation"
//            let annotationView = AnimatedAnnotationView(annotation: annotation, reuseIdentifier: AnnotationViewID)
//
//            var images = Array(repeating: UIImage(), count: 3)
//            for i in 1...3 {
//                let image = UIImage(named: "poi_\(i).png")
//                images[i-1] = image!
//            }
//            annotationView.setImages(images)
//            return annotationView
//        }
//        // 普通标注
        let AnnotationViewID = "renameMark"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: AnnotationViewID) as! BMKPinAnnotationView?
//        if annotationView == nil {
//            annotationView = BMKPinAnnotationView(annotation: annotation, reuseIdentifier: AnnotationViewID)
//            if (annotation as! BMKPointAnnotation) == lockedScreenAnnotation {
//                // 设置颜色
//                annotationView!.pinColor = UInt(BMKPinAnnotationColorPurple)
//                // 设置可拖拽
//                annotationView!.isDraggable = false
//            } else {
//                annotationView!.isDraggable = true
//            }
//            // 从天上掉下的动画
//            annotationView!.animatesDrop = true
//        }
        annotationView?.annotation = annotation
        return annotationView
    }
    
    /**
     *当mapView新添加annotation views时，调用此接口
     *@param mapView 地图View
     *@param views 新添加的annotation views
     */
    func mapView(_ mapView: BMKMapView!, didAddAnnotationViews views: [Any]!) {
        NSLog("didAddAnnotationViews")
    }
    
    /**
     *当选中一个annotation views时，调用此接口
     *@param mapView 地图View
     *@param views 选中的annotation views
     */
    func mapView(_ mapView: BMKMapView!, didSelect view: BMKAnnotationView!) {
        NSLog("选中了标注")
    }
    
    /**
     *当取消选中一个annotation views时，调用此接口
     *@param mapView 地图View
     *@param views 取消选中的annotation views
     */
    func mapView(_ mapView: BMKMapView!, didDeselect view: BMKAnnotationView!) {
        NSLog("取消选中标注")
    }
    
    /**
     *拖动annotation view时，若view的状态发生变化，会调用此函数。ios3.2以后支持
     *@param mapView 地图View
     *@param view annotation view
     *@param newState 新状态
     *@param oldState 旧状态
     */
    func mapView(_ mapView: BMKMapView!, annotationView view: BMKAnnotationView!, didChangeDragState newState: UInt, fromOldState oldState: UInt) {
        NSLog("annotation view state change : \(oldState) : \(newState)")
    }
    
    /**
     *当点击annotation view弹出的泡泡时，调用此接口
     *@param mapView 地图View
     *@param view 泡泡所属的annotation view
     */
    func mapView(_ mapView: BMKMapView!, annotationViewForBubble view: BMKAnnotationView!) {
        NSLog("点击了泡泡")
    }
}

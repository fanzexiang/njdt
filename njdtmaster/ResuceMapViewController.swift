//
//  ResuceMapViewController.swift
//  njdtmaster
//
//  Created by 尹浩 on 2018/3/27.
//  Copyright © 2018年 尹浩. All rights reserved.
//  救援路线地图

import UIKit
var _mapView: BMKMapView!
class ResuceMapViewController: UIViewController, BMKMapViewDelegate, BMKRouteSearchDelegate, BMKLocationServiceDelegate{
    var dataDetail:Dictionary = Dictionary<String,String>()
    var routeSearch: BMKRouteSearch!
    var locationService: BMKLocationService!
    var myLat:Double = 32.064773;
    var myLon:Double = 118.803221;
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.title = "实时位置"
        self.navigationController?.navigationBar.tintColor = UIColor.white;
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        
        
        locationService = BMKLocationService()
        locationService.allowsBackgroundLocationUpdates = true
        locationService.startUserLocationService()
        routeSearch = BMKRouteSearch()
        _mapView = BMKMapView.init(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        _mapView.zoomLevel = 12
        _mapView.centerCoordinate = CLLocationCoordinate2D.init(latitude: 32.067428, longitude: 118.802316);
        _mapView.isTrafficEnabled = false
        _mapView.isBuildingsEnabled = true
        _mapView.showMapPoi = true
        self.view.addSubview(_mapView)
        
        let time:TimeInterval = 2
        CBToast.showToastAction()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time){
            self.rideRouteSearch()
            CBToast.hiddenToastAction();
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
        _mapView.viewWillAppear()
        _mapView.delegate = self
        routeSearch.delegate = self
        locationService.delegate = self
    }
    func rideRouteSearch() {
        
        let from = BMKPlanNode()
        from.pt = CLLocationCoordinate2DMake(myLat,myLon)
        let to = BMKPlanNode()
        to.pt = CLLocationCoordinate2DMake((dataDetail["lat"]! as NSString).doubleValue, (dataDetail["lng"]! as NSString).doubleValue)
        let option = BMKRidingRoutePlanOption()
        option.from = from
        option.to = to
        let flag = routeSearch.ridingSearch(option)
        if flag {
            print("骑行检索发送成功")
        }else {
            print("骑行检索发送失败")
        }
    }
    /**
     *返回骑行搜索结果
     *@param searcher 搜索对象
     *@param result 搜索结果，类型为BMKRidingRouteResult
     *@param error 错误号，@see BMKSearchErrorCode
     */
    func onGetRidingRouteResult(_ searcher: BMKRouteSearch!, result: BMKRidingRouteResult!, errorCode error: BMKSearchErrorCode) {
        print("onGetRidingRouteResult: \(error)")
        _mapView.removeAnnotations(_mapView.annotations)
        _mapView.removeOverlays(_mapView.overlays)
        
        if error == BMK_SEARCH_NO_ERROR {
            let plan = result.routes[0] as! BMKRidingRouteLine
            
            let size = plan.steps.count
            var planPointCounts = 0
            for i in 0..<size {
                let transitStep = plan.steps[i] as! BMKRidingStep
                if i == 0 {
                    let item = RouteAnnotation()
                    item.coordinate = plan.starting.location
                    item.title = "起点"
                    item.type = 0
                    _mapView.addAnnotation(item)  // 添加起点标注
                }
                if i == size - 1 {
                    let item = RouteAnnotation()
                    item.coordinate = plan.terminal.location
                    item.title = "终点"
                    item.type = 1
                    _mapView.addAnnotation(item)  // 添加终点标注
                }
                // 添加 annotation 节点
                let item = RouteAnnotation()
                item.coordinate = transitStep.entrace.location
                item.title = transitStep.entraceInstruction
                item.degree = Int(transitStep.direction) * 30
                item.type = 4
                _mapView.addAnnotation(item)
                
                // 轨迹点总数累计
                planPointCounts = Int(transitStep.pointsCount) + planPointCounts
            }
            
            // 轨迹点
            var tempPoints = Array(repeating: BMKMapPoint(x: 0, y: 0), count: planPointCounts)
            var i = 0
            for j in 0..<size {
                let transitStep = plan.steps[j] as! BMKRidingStep
                for k in 0..<Int(transitStep.pointsCount) {
                    tempPoints[i].x = transitStep.points[k].x
                    tempPoints[i].y = transitStep.points[k].y
                    i += 1
                }
            }
            
            // 通过 points 构建 BMKPolyline
            let polyLine = BMKPolyline(points: &tempPoints, count: UInt(planPointCounts))
            _mapView.add(polyLine)  // 添加路线 overlay
            mapViewFitPolyLine(polyLine)
        } else if error == BMK_SEARCH_AMBIGUOUS_ROURE_ADDR {
           
        }
    }
    // MARK: - BMKMapViewDelegate
    
    /**
     *根据anntation生成对应的View
     *@param mapView 地图View
     *@param annotation 指定的标注
     *@return 生成的标注View
     */
    func mapView(_ mapView: BMKMapView!, viewFor annotation: BMKAnnotation!) -> BMKAnnotationView! {
        if let routeAnnotation = annotation as! RouteAnnotation? {
            return getViewForRouteAnnotation(routeAnnotation)
        }
        return nil
    }
    
    /**
     *根据overlay生成对应的View
     *@param mapView 地图View
     *@param overlay 指定的overlay
     *@return 生成的覆盖物View
     */
    func mapView(_ mapView: BMKMapView!, viewFor overlay: BMKOverlay!) -> BMKOverlayView! {
        if overlay as! BMKPolyline? != nil {
            let polylineView = BMKPolylineView(overlay: overlay as! BMKPolyline)
            polylineView?.strokeColor = UIColor(red: 0, green: 0, blue: 1, alpha: 0.7)
            polylineView?.lineWidth = 3
            return polylineView
        }
        return nil
    }
    
    // MARK: -
    
    func getViewForRouteAnnotation(_ routeAnnotation: RouteAnnotation!) -> BMKAnnotationView? {
        var view: BMKAnnotationView?
        
        var imageName: String?
        switch routeAnnotation.type {
        case 0:
            imageName = "nav_start"
        case 1:
            imageName = "nav_end"
        case 2:
            imageName = "nav_bus"
        case 3:
            imageName = "nav_rail"
        case 4:
            imageName = "direction"
        case 5:
            imageName = "nav_waypoint"
        default:
            return nil
        }
        let identifier = "\(String(describing: imageName))_annotation"
        view = _mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        if view == nil {
            view = BMKAnnotationView(annotation: routeAnnotation, reuseIdentifier: identifier)
            view?.centerOffset = CGPoint(x: 0, y: -(view!.frame.size.height * 0.5))
            view?.canShowCallout = true
        }
        
        view?.annotation = routeAnnotation
        
        let bundlePath = (Bundle.main.resourcePath)! + "/mapapi.bundle/"
        let bundle = Bundle(path: bundlePath)
        var tmpBundle : String?
        tmpBundle = (bundle?.resourcePath)! + "/images/icon_\(imageName!).png"
        if let imagePath = tmpBundle {
            var image = UIImage(contentsOfFile: imagePath)
            if routeAnnotation.type == 4 {
                image = imageRotated(image, degrees: routeAnnotation.degree)
            }
            if image != nil {
                view?.image = image
            }
        }
        
        return view
    }
    
    
    
    
    //根据polyline设置地图范围
    func mapViewFitPolyLine(_ polyline: BMKPolyline!) {
        if polyline.pointCount < 1 {
            return
        }
        
        let pt = polyline.points[0]
        var leftTopX = pt.x
        var leftTopY = pt.y
        var rightBottomX = pt.x
        var rightBottomY = pt.y
        
        for i in 1..<polyline.pointCount {
            let pt = polyline.points[Int(i)]
            leftTopX = pt.x < leftTopX ? pt.x : leftTopX;
            leftTopY = pt.y < leftTopY ? pt.y : leftTopY;
            rightBottomX = pt.x > rightBottomX ? pt.x : rightBottomX;
            rightBottomY = pt.y > rightBottomY ? pt.y : rightBottomY;
        }
        
        let rect = BMKMapRectMake(leftTopX, leftTopY, rightBottomX - leftTopX, rightBottomY - leftTopY)
        _mapView.visibleMapRect = rect
    }
    
    //旋转图片
    func imageRotated(_ image: UIImage!, degrees: Int!) -> UIImage {
        let width = image.cgImage?.width
        let height = image.cgImage?.height
        let rotatedSize = CGSize(width: width!, height: height!)
        UIGraphicsBeginImageContext(rotatedSize);
        let bitmap = UIGraphicsGetCurrentContext();
        bitmap?.translateBy(x: rotatedSize.width/2, y: rotatedSize.height/2);
        bitmap?.rotate(by: CGFloat(Double(degrees) * Double.pi / 180.0));
        bitmap?.rotate(by: CGFloat(Double.pi));
        bitmap?.scaleBy(x: -1.0, y: 1.0);
        bitmap?.draw(image.cgImage!, in: CGRect(x: -rotatedSize.width/2, y: -rotatedSize.height/2, width: rotatedSize.width, height: rotatedSize.height));
        let newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return newImage!;
    }
   
    // MARK: - BMKMapViewDelegate
    
    
    // MARK: - BMKLocationServiceDelegate
    
    /**
     *在地图View将要启动定位时，会调用此函数
     *@param mapView 地图View
     */
    func willStartLocatingUser() {
        print("willStartLocatingUser");
    }
    
    /**
     *用户方向更新后，会调用此函数
     *@param userLocation 新的用户位置
     */
    func didUpdateUserHeading(_ userLocation: BMKUserLocation!) {
        //        print("heading is \(userLocation.heading)")
        
    }
    
    
    /**
     *用户位置更新后，会调用此函数
     *@param userLocation 新的用户位置
     */
    func didUpdate(_ userLocation: BMKUserLocation!) {
        print("didUpdateUserLocation lat:\(userLocation.location.coordinate.latitude) lon:\(userLocation.location.coordinate.longitude)")
        myLat = userLocation.location.coordinate.latitude
        myLon = userLocation.location.coordinate.longitude
    }
    
    /**
     *在地图View停止定位后，会调用此函数
     *@param mapView 地图View
     */
    func didStopLocatingUser() {
        print("didStopLocatingUser")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        _mapView.viewWillDisappear()
        _mapView.delegate = nil
        routeSearch.delegate = nil
        locationService.delegate = nil
        locationService.stopUserLocationService()
    }
    
}

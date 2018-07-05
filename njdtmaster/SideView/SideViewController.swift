//
//  SideViewController.swift
//  njdtmaster
//
//  Created by 尹浩 on 2018/3/13.
//  Copyright © 2018年 尹浩. All rights reserved.
//  侧边菜单视图
//

import UIKit
import Alamofire
import SwiftyJSON

class SideViewController: UIViewController {
    
    static let TABLEVIEWCELLIDENTIFIER = "TABLEVIEWCELLIDENTIFIER"
    
    var weatherDic:NSMutableDictionary = ["weatherDate":"","weatherInfo":"","weatherTemperature":"","weatherImgURL":"http://api.map.baidu.com/images/weather/day/duoyun.png"]
    var weatherDATE:String = ""
    var weatherINFO:String = ""
    var weatherTEMPERATURE:String = ""
    var imgURL:String = "http://api.map.baidu.com/images/weather/day/duoyun.png"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(backImage)
        view.addSubview(rootTableView)
    }
    
    lazy var backImage : UIImageView = { [unowned self] in
        var image = UIImageView(image: UIImage(named: "bg_register"))
        image.frame = self.view.bounds
        image.alpha = 0.85
        return image
        }()
    
    lazy var rootTableView : UITableView = { [unowned self] in
        var tableView : UITableView = UITableView(frame: self.view.bounds, style: .plain)
        tableView.backgroundColor = .clear
        tableView.isScrollEnabled = false
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: SideViewController.TABLEVIEWCELLIDENTIFIER)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
        }()
    
}

extension SideViewController : UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if CommonData.DEPT_TYPE == "0"{
            return CommonData.SIDE_TITILE_ARRAY.count
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SideViewController.TABLEVIEWCELLIDENTIFIER, for: indexPath)
        cell.backgroundColor = .clear
        cell.textLabel?.textColor = .white
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.imageView?.image = UIImage(named: CommonData.SIDE_IMAGE_ARRAY[indexPath.row])
        cell.textLabel?.text = CommonData.SIDE_TITILE_ARRAY[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headView = UIView()
        headView.backgroundColor = .clear
        headView.alpha = 1
        //调用天气接口
        getWeatherData()
        let time: TimeInterval = 1
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time) {
            let dateLabel = UILabel()
            let weatherLabel = UILabel()
            let temperatureLabel = UILabel()
            for (key,value) in self.weatherDic{
                if "weatherDate".contains(key as! String) {
                    dateLabel.text = value as? String
                }else{
                    
                }
                if "weatherInfo".contains(key as! String) {
                    weatherLabel.text = value as? String
                }else{
                    
                }
                if "weatherTemperature".contains(key as! String) {
                    temperatureLabel.text = value as? String
                }else{
                    
                }
                if "weatherImgURL".contains(key as! String) {
                    self.imgURL = value as! String
                }else{
                    
                }
            }
            let authorImage = UIImageView(image: UIImage(named: "11"))
            authorImage.frame = CGRect(x:12,y:56,width:64,height:64)
            headView.addSubview(authorImage)
            let url = URL(string: self.imgURL)
            let data = try! Data(contentsOf: url!)
            let weatherImageView = UIImageView(image: UIImage(data: data))
            dateLabel.frame = CGRect(x: 90, y: 60, width: 170, height: 30)
            weatherLabel.frame = CGRect(x: 112, y: 90, width: 100, height: 30)
            temperatureLabel.frame = CGRect(x: 180, y: 90, width: 60, height: 30)
            weatherImageView.frame = CGRect(x: 90, y:94, width: 20,height: 20)
            dateLabel.textAlignment = NSTextAlignment.left
            weatherLabel.textAlignment = NSTextAlignment.left
            temperatureLabel.textAlignment = NSTextAlignment.left
            dateLabel.font = UIFont.systemFont(ofSize: 13)
            weatherLabel.font = UIFont.systemFont(ofSize: 12)
            temperatureLabel.font = UIFont.systemFont(ofSize: 12)
            let str:String = weatherLabel.text!
            if str.count > 7 {//判断天气信息字符串过长时，缩小字体以及调整温度Label水平位置
                weatherLabel.font = UIFont.systemFont(ofSize:10)
                temperatureLabel.frame = CGRect(x: 200, y: 90, width: 60, height: 30)
            }
            dateLabel.numberOfLines = 0
            weatherLabel.numberOfLines = 0
            temperatureLabel.numberOfLines = 0
            dateLabel.textColor = .white
            weatherLabel.textColor = .white
            temperatureLabel.textColor = .white
            dateLabel.backgroundColor = .clear
            weatherLabel.backgroundColor = .clear
            temperatureLabel.backgroundColor = .clear
            headView.addSubview(dateLabel)
            headView.addSubview(weatherLabel)
            headView.addSubview(temperatureLabel)
            headView.addSubview(weatherImageView)
    
        }
        return headView
    }
    //调用天气接口
    func getWeatherData(){
        Alamofire.request(CommonData.WEATHER_PATH, method: .get, parameters: ["location":CommonData.NANJING,"output":"json","ak":"6tYzTvGZSOpYB5Oc2YGGOKt8"], encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result.isSuccess {
            case true:
                if let value = response.result.value {
                    let json = JSON(value)
                    if (json["status"].string! == "success"){
                        self.weatherDic["weatherDate"] = json["results"][0]["weather_data"][0]["date"].string!
                        self.weatherDic["weatherInfo"] = json["results"][0]["weather_data"][0]["weather"].string!
                        self.weatherDic["weatherTemperature"] = json["results"][0]["weather_data"][0]["temperature"].string!
                        self.weatherDic["weatherImgURL"] = json["results"][0]["weather_data"][0]["dayPictureUrl"].string!
                    }
                }
            case false:
                print("\(CommonData.LOG_CALL_INTERFACE_ERROR)\(response.result.error as Any)")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 170
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let delegate  = UIApplication.shared.delegate! as! AppDelegate
        let rootVC = delegate.window?.rootViewController as! XYSideViewControllerSwift
        rootVC.closeSideVC()
        if(CommonData.DEPT_TYPE == "0"){
            if CommonData.STAFF_ROLE == "1" {
                //“1”表示维保单位管理员
                switch indexPath.row {
                case 0:
                    let personnelClaimVC = PersonnelClaimVC()
                    personnelClaimVC.title = CommonData.SIDE_TITILE_ARRAY[indexPath.row]
                    rootVC.currentNavController?.pushViewController(personnelClaimVC, animated: true)
                    print("侧边页面：\(String(describing: personnelClaimVC.title!))")
                case 1:
                    let personnelManagementVC = PersonnelManagementVC()
                    personnelManagementVC.title = CommonData.SIDE_TITILE_ARRAY[indexPath.row]
                    rootVC.currentNavController?.pushViewController(personnelManagementVC, animated: true)
                    print("侧边页面：\(String(describing: personnelManagementVC.title!))")
                case 2:
                    let realtimePositionVC = RealtimePositionVC()
                    realtimePositionVC.title = CommonData.SIDE_TITILE_ARRAY[indexPath.row]
                    rootVC.currentNavController?.pushViewController(realtimePositionVC, animated: true)
                    print("侧边页面：\(String(describing: realtimePositionVC.title!))")
                case 3:
                    let resuceStatisticsVC = ResuceStatisticsVC()
                    resuceStatisticsVC.title = CommonData.SIDE_TITILE_ARRAY[indexPath.row]
                    rootVC.currentNavController?.pushViewController(resuceStatisticsVC, animated: true)
                    print("侧边页面：\(String(describing: resuceStatisticsVC.title!))")
                case 4:
                    let noticsListVC = NoticeListVC()
                    noticsListVC.title = CommonData.SIDE_TITILE_ARRAY[indexPath.row]
                    rootVC.currentNavController?.pushViewController(noticsListVC, animated: true)
                    print("侧边页面：\(String(describing: noticsListVC.title!))")
                case 5:
                    let myRanksVC = MyRanksSubVC()
                    myRanksVC.title = CommonData.SIDE_TITILE_ARRAY[indexPath.row]
                    rootVC.currentNavController?.pushViewController(myRanksVC, animated: true)
                    print("侧边页面：\(String(describing: myRanksVC.title!))")
                case 6:
                    let myInfoVC = MyInfoSubVC()
                    myInfoVC.title = CommonData.SIDE_TITILE_ARRAY[indexPath.row]
                    rootVC.currentNavController?.pushViewController(myInfoVC, animated: true)
                    print("侧边页面：\(String(describing: myInfoVC.title!))")
                case 7:
                    let maintenanceStatisticsVC = MaintenanceStatisticsSubVC()
                    maintenanceStatisticsVC.title = CommonData.SIDE_TITILE_ARRAY[indexPath.row]
                    rootVC.currentNavController?.pushViewController(maintenanceStatisticsVC, animated: true)
                    print("侧边页面：\(String(describing: maintenanceStatisticsVC.title!))")
                default:
                    print("错误菜单选项")
                }
            }else{
                switch indexPath.row {
                case 0:
                    let noticsListVC = NoticeListVC()
                    noticsListVC.title = CommonData.SIDE_TITILE_ARRAY[indexPath.row]
                    rootVC.currentNavController?.pushViewController(noticsListVC, animated: true)
                    print("侧边页面：\(String(describing: noticsListVC.title!))")
                case 1:
                    let myRanksVC = MyRanksSubVC()
                    myRanksVC.title = CommonData.SIDE_TITILE_ARRAY[indexPath.row]
                    rootVC.currentNavController?.pushViewController(myRanksVC, animated: true)
                    print("侧边页面：\(String(describing: myRanksVC.title!))")
                case 2:
                    let myInfoVC = MyInfoSubVC()
                    myInfoVC.title = CommonData.SIDE_TITILE_ARRAY[indexPath.row]
                    rootVC.currentNavController?.pushViewController(myInfoVC, animated: true)
                    print("侧边页面：\(String(describing: myInfoVC.title!))")
                case 3:
                    let maintenanceStatisticsVC = MaintenanceStatisticsSubVC()
                    maintenanceStatisticsVC.title = CommonData.SIDE_TITILE_ARRAY[indexPath.row]
                    rootVC.currentNavController?.pushViewController(maintenanceStatisticsVC, animated: true)
                    print("侧边页面：\(String(describing: maintenanceStatisticsVC.title!))")
                default:
                    print("错误菜单选项")
                }
            }
        }
    }
}


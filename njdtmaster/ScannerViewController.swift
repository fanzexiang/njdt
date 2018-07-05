//
//  ScannerViewController.swift
//  QRCode
//
//  Created by Erwin on 16/5/5.
//  Copyright © 2016年 Erwin. All rights reserved.
//

import UIKit
import AVFoundation

protocol ScannerTimeDelegate {
    func saveScannerTime(kssj:String,jssj:String) ;
}

class ScannerViewController: UIViewController,AVCaptureMetadataOutputObjectsDelegate,UINavigationControllerDelegate {
    
    var scannerTimeDelegate:ScannerTimeDelegate?;
    //相机显示视图
    @objc let cameraView = ScannerBackgroundView(frame: UIScreen.main.bounds)
    
    
    @objc let captureSession = AVCaptureSession()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black
        self.title = "扫一扫"
        self.navigationController?.navigationBar.tintColor = UIColor.white;
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        self.view.addSubview(cameraView)
        
        //初始化捕捉设备（AVCaptureDevice），类型AVMdeiaTypeVideo
        let captureDevice = AVCaptureDevice.default(for: AVMediaType.video)
        
        let input :AVCaptureDeviceInput
        
        //创建媒体数据输出流
        let output = AVCaptureMetadataOutput()
        
        //捕捉异常
        do{
            //创建输入流
            input = try AVCaptureDeviceInput(device: captureDevice!)
            
            //把输入流添加到会话
            captureSession.addInput(input)
            
            //把输出流添加到会话
            captureSession.addOutput(output)
        }catch {
            print("异常")
        }
        
        //创建串行队列
        let dispatchQueue = DispatchQueue(label: "queue", attributes: [])
        
        //设置输出流的代理
        output.setMetadataObjectsDelegate(self, queue: dispatchQueue)
        
        //设置输出媒体的数据类型
        output.metadataObjectTypes = NSArray(array: [AVMetadataObject.ObjectType.qr,AVMetadataObject.ObjectType.ean13,AVMetadataObject.ObjectType.ean8, AVMetadataObject.ObjectType.code128]) as [AnyObject] as! [AVMetadataObject.ObjectType]
        
        //创建预览图层
        let videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        
        //设置预览图层的填充方式
        videoPreviewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        
        //设置预览图层的frame
        videoPreviewLayer.frame = cameraView.bounds
        
        //将预览图层添加到预览视图上
        cameraView.layer.insertSublayer(videoPreviewLayer, at: 0)
        
        //设置扫描范围
        output.rectOfInterest = CGRect(x: 0.2, y: 0.2, width: 0.6, height: 0.6)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.scannerStart()
    }
    
    @objc func scannerStart(){
        captureSession.startRunning()
        cameraView.scanning = "start"
    }
    
    @objc func scannerStop() {
        captureSession.stopRunning()
        cameraView.scanning = "stop"
    }
    
    
    //扫描代理方法
    func metadataOutput(_ captureOutput: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if metadataObjects != nil && metadataObjects.count > 0 {
            let metaData : AVMetadataMachineReadableCodeObject = metadataObjects.first as! AVMetadataMachineReadableCodeObject
            var resultScan:String = metaData.stringValue!;
            print(resultScan)
            let lastIndex = resultScan.range(of: "liftInfo/");
            let regode:String = String(resultScan.suffix(from: lastIndex!.upperBound));
            DispatchQueue.main.async(execute: {
//                if regode==CommonData.regode{
//                    let dformatter = DateFormatter();
//                    dformatter.dateFormat = "yyyy-MM-dd HH:mm:ss";
//                    if CommonData.kswbsj == ""{
//                         CommonData.kswbsj = dformatter.string(from: Date());
//                    }else{
//                        CommonData.jswbsj = dformatter.string(from: Date());
//                    }
//                    self.scannerTimeDelegate?.saveScannerTime(kssj: CommonData.kswbsj, jssj: CommonData.jswbsj);
//                    self.navigationController?.popViewController(animated: true);
//                }else{
//                    var alert = UIAlertView(title: "提示", message: "扫描电梯不匹配", delegate: self, cancelButtonTitle: "确定");
//                    alert.alertViewStyle = UIAlertViewStyle.default;
//                    alert.show();
//                }
                let dformatter = DateFormatter();
                dformatter.dateFormat = "yyyy-MM-dd HH:mm:ss";
                if CommonData.kswbsj == ""{
                    CommonData.kswbsj = dformatter.string(from: Date());
                }else{
                    CommonData.jswbsj = dformatter.string(from: Date());
                }
                self.scannerTimeDelegate?.saveScannerTime(kssj: CommonData.kswbsj, jssj: CommonData.jswbsj);
                self.navigationController?.popViewController(animated: true);
            })
            self.captureSession.stopRunning();
        }
    }
}

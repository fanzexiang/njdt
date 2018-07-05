//
//  BaseNetwork.swift
//  njdtmaster
//
//  Created by 尹浩 on 2018/2/23.
//  Copyright © 2018年 尹浩. All rights reserved.
//  网络请求组件
//

import UIKit

class BaseNetwork:NSObject {
    
    var str:String! = "未初始化"
    /// Post 访问
    ///
    /// - Parameters:
    ///   - url: 服务器链接
    ///   - params: POST参数
    func post(url:String, params:NSMutableDictionary) {
        
        //创建会话对象
        let session     = URLSession.shared
        let serUrl      = URL(string:url)
        var request     = URLRequest(url: serUrl!)
        
        //设置访问方式为POST
        request.httpMethod = "POST"
        
        //设置POST 内容
        request.httpBody = getBody(params: params).data(using: String.Encoding.utf8)
        
        //开始访问
        let dataTask : URLSessionDataTask = session.dataTask(with: request) { (data, respones, error)  -> Void  in
            
            //访问结束
            if(error != nil) {
                //返回出错
                //print(error.debugDescription)
                self.str = "返回出错!错误提示：" + error.debugDescription
            } else {
                
                //返回成功
                self.str = String(data: data!, encoding: String.Encoding.utf8)
                //print(self.str ?? "error")
            }
            
        }
        dataTask.resume()
    }
    
    /// 获取返回内容
    ///
    func getReturnValue() -> String {
        return self.str
    }
    
    
    /// 获取post内容
    ///
    /// - Parameter params: 参数
    /// - Returns: Body
    func getBody(params:NSMutableDictionary) -> String {
        
        var body : String = "";
        
        for (key, value) in params {
            
            let str = "\(key)=\(value)&"
            
            body = body + str
        }
        
        if(body.count > 1) {
            body = (body as NSString).substring(to: body.count-1)
        }
        
        return body
    }
}

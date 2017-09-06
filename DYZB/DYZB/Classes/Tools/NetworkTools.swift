//
//  NetworkTools.swift
//  Alamofire的测试
//
//  Created by 张起哲 on 2017/9/2.
//  Copyright © 2017年 张起哲. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType {
    case get
    case post
}

class NetworkTools {
    class func requestData(_ type : MethodType, URLString : String, parameters : [String : Any]? = nil, finishedCallback :  @escaping (_ result : Any) -> ()) {
        
        // 1.获取类型
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        
        // 2.发送网络请求
        Alamofire.request(URLString, method: method, parameters: parameters).responseJSON { (response) in
            
            // 3.获取结果
            guard let result = response.result.value else {
                print(response.result.error ?? "error")
                return
            }
            
            // 4.将结果回调出去
            finishedCallback(result)
        }
    }
}

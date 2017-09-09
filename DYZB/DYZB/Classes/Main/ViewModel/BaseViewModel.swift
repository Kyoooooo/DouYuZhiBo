//
//  BaseViewModel.swift
//  DYZB
//
//  Created by 张起哲 on 2017/9/9.
//  Copyright © 2017年 张起哲. All rights reserved.
//

import UIKit

class BaseViewModel {
    lazy var anchorGroups : [AnchorGroup] = [AnchorGroup]()
}

extension BaseViewModel {
    func loadAnchorData(URLString : String, parameters : [String : Any]? = nil, finishedCallback : @escaping () -> ()) {
        NetworkTools.requestData(.get, URLString: URLString, parameters: parameters) { (result) in
            //1.对数据进行处理
            guard let resultDict = result as? [String : Any] else {return}
            guard let dataArray = resultDict["data"] as? [[String :Any]] else {return}
            
            //2.便利数组中的字典
            for dict in dataArray {
                self.anchorGroups.append(AnchorGroup(dict: dict))
            }
            //3.完成回调
            finishedCallback()
        }
    }
}

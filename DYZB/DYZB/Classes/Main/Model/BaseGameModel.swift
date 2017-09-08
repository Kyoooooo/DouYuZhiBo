//
//  BaseGameModel.swift
//  DYZB
//
//  Created by 张起哲 on 2017/9/8.
//  Copyright © 2017年 张起哲. All rights reserved.
//

import UIKit

class BaseGameModel: NSObject {
    // MARK:- 定义属性
    ///组显示的图标
    var tag_name : String = ""
    /// 游戏对应的图标
    var icon_url : String = ""
    
    // MARK:- 自定义构造函数
    override init() {
        
    }
    
    init(dict : [String : Any]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}

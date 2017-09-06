//
//  AnchorGroup.swift
//  DYZB
//
//  Created by 张起哲 on 2017/9/5.
//  Copyright © 2017年 张起哲. All rights reserved.
//

import UIKit

class AnchorGroup: NSObject {
    /// 该组中对应的房间信息
    var room_list : [[String : NSObject]]? {
        didSet {
            guard let room_list = room_list else { return }
            for dict in room_list {
                anchors.append(AnchorModel(dict: dict))
            }
        }
    }
    ///组显示的图标
    var tag_name : String = ""
    /// 组显示的图标
    var icon_name : String = "home_header_normal"
    /// 定义主播的模型对象数组
    lazy var anchors : [AnchorModel] = [AnchorModel]()
    
    //构造函数
    override init() {
        
    }
    
    init(dic : [String : AnyObject]) {
        super.init()
        
        setValuesForKeys(dic)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}

//
//  CollectionPrettyCell.swift
//  DYZB
//
//  Created by 张起哲 on 2017/9/5.
//  Copyright © 2017年 张起哲. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionPrettyCell: CollectionBaseCell {

    //控件属性
    @IBOutlet weak var cityBtn: UIButton!
    
    //定义模型属性
    override var anchor : AnchorModel? {
        didSet {
            //1.将属性传递给父类
            super.anchor = anchor
            
            // 2.所在城市
            cityBtn.setTitle(anchor?.anchor_city, for: .normal)
            
        }
    }
}

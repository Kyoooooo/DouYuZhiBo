//
//  CollectionHeadView.swift
//  DYZB
//
//  Created by 张起哲 on 2017/9/5.
//  Copyright © 2017年 张起哲. All rights reserved.
//

import UIKit

class CollectionHeadView: UICollectionReusableView {

    // MARK:- 定义模型属性
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    // MARK:- 定义模型属性
    var group : AnchorGroup? {
        didSet {
            titleLabel.text = group?.tag_name
            iconImageView.image = UIImage(named: group?.icon_name ?? "home_header_normal")
        }
    }
    
}

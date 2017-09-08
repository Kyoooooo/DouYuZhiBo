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
    @IBOutlet weak var moreBtn: UIButton!
    
    // MARK:- 定义模型属性
    var group : AnchorGroup? {
        didSet {
            titleLabel.text = group?.tag_name
            iconImageView.image = UIImage(named: group?.icon_name ?? "home_header_normal")
        }
    }
}

// MARK:- 从Xib中快速创建的类方法
extension CollectionHeadView {
    class func collectionHeaderView() -> CollectionHeadView {
        return Bundle.main.loadNibNamed("CollectionHeadView", owner: nil, options: nil)?.first as! CollectionHeadView
    }
}

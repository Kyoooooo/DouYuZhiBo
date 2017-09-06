//
//  CollectionBaseCell.swift
//  DYZB
//
//  Created by 张起哲 on 2017/9/6.
//  Copyright © 2017年 张起哲. All rights reserved.
//

import UIKit

class CollectionBaseCell: UICollectionViewCell {
    //控件属性
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var onlineBtn: UIButton!
    @IBOutlet weak var nickNameLabel: UILabel!
    
    //定义模型属性
    var anchor : AnchorModel? {
        didSet {
            // 0.校验模型是否有值
            guard let anchor = anchor else { return }
            
            // 1.取出在线人数显示的文字
            var onlineStr : String = ""
            if anchor.online >= 10000 {
                onlineStr = "\(Int(anchor.online / 10000))万在线"
            } else {
                onlineStr = "\(anchor.online)在线"
            }
            onlineBtn.setTitle(onlineStr, for: UIControlState())
            
            // 2.昵称的显示
            nickNameLabel.text = anchor.nickname
            
            // 3.设置封面图片
            guard let iconURL = URL(string: anchor.vertical_src) else { return }
            iconImageView.kf.setImage(with: iconURL)
        }
    }
}

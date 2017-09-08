//
//  CollectionGameCell.swift
//  DYZB
//
//  Created by 张起哲 on 2017/9/7.
//  Copyright © 2017年 张起哲. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionGameCell: UICollectionViewCell {

    // 控件属性
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    // 定义模型属性
    var baseGame : BaseGameModel? {
        didSet {
            titleLabel.text = baseGame?.tag_name
            
            if let iconURL = URL(string: baseGame?.icon_url ?? "") {
//                iconImageView.kf.setImage(with: iconURL)
                let resource : ImageResource = ImageResource(downloadURL: iconURL as URL)
                iconImageView.kf.setImage(with: resource, placeholder: UIImage(named:"Img_default"), options: nil, progressBlock: nil, completionHandler: nil)
            } else {
                iconImageView.image = UIImage(named: "home_more_btn")
            }
        }
    }
    
}

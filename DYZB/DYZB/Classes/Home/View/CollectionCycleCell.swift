//
//  CollectionCycleCell.swift
//  DYZB
//
//  Created by 张起哲 on 2017/9/6.
//  Copyright © 2017年 张起哲. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionCycleCell: UICollectionViewCell {
    
    //
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    //定义模型属性
    var cycleModel : CycleModel? {
        didSet {
            titleLabel.text = cycleModel?.title
            let iconURL = NSURL(string: cycleModel?.pic_url ?? "")!
            
            let resource : ImageResource = ImageResource(downloadURL: iconURL as URL)
            iconImageView.kf.setImage(with: resource)
        }
    }

}

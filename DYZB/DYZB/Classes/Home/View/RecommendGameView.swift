//
//  RecommendGameView.swift
//  DYZB
//
//  Created by 张起哲 on 2017/9/7.
//  Copyright © 2017年 张起哲. All rights reserved.
//

import UIKit

private let kGameCellID = "kGameCellID"
private let kEdgeInsetMargin : CGFloat = 10

class RecommendGameView: UIView {
    
    // 定义数据的属性
    var groups : [AnchorGroup]? {
        didSet {
            //1.移除前两组数据
            groups?.removeFirst()
            groups?.removeFirst()
            
            //2.添加一个名为更多的组
            let moreGroup = AnchorGroup()
            moreGroup.tag_name = "更多"
            moreGroup.icon_name = ""
            groups?.append(moreGroup)
            
            // 刷新表格
            collectionView.reloadData()
        }
    }
    
    //控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    
    //系统回调
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //设置该控件不随着父控件拉伸而拉伸
        autoresizingMask = UIViewAutoresizing()
        
        //注册cell
        
        collectionView.register(UINib(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
        
        // 给collectionView添加内边距
        collectionView.contentInset = UIEdgeInsets(top: 0, left: kEdgeInsetMargin, bottom: 0, right: kEdgeInsetMargin)
    }
}

//提供快速创建的类方法
extension RecommendGameView {
    class func recommendGameView() -> RecommendGameView {
        return Bundle.main.loadNibNamed("RecommendGameView", owner: nil, options: nil)?.first as! RecommendGameView
    }
}

//遵守UICollectionView数据源协议
extension RecommendGameView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! CollectionGameCell
        
        cell.group = groups![indexPath.item]
        
        return cell
    }
}




//
//  FunnyViewController.swift
//  DYZB
//
//  Created by 张起哲 on 2017/9/9.
//  Copyright © 2017年 张起哲. All rights reserved.
//

import UIKit

private let kTopMargin : CGFloat = 8

class FunnyViewController: BaseAnchorViewController {
    //懒加载viewModel对象
    fileprivate lazy var funnyVM : FunnyViewModel = FunnyViewModel()
}

//调整collectionView
extension FunnyViewController {
    override func setupUI() {
        super.setupUI()
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.headerReferenceSize = CGSize.zero
        
        collectionView.contentInset = UIEdgeInsets(top: kTopMargin, left: 0, bottom: 0, right: 0)
    }
}

extension FunnyViewController {
    override func loadData() {
        //1.给父类的viewmodel赋值
        baseVM = self.funnyVM
        
        //2.请求数据
        funnyVM.loadFunnyData {
            // 2.1.刷新表格
            self.collectionView.reloadData()
            
            // 2.2.数据请求完成
            self.loadDataFinished()
        }
    }
}



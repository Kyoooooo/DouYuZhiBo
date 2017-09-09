//
//  AmuseViewController.swift
//  DYZB
//
//  Created by 张起哲 on 2017/9/9.
//  Copyright © 2017年 张起哲. All rights reserved.
//

import UIKit

class AmuseViewController: BaseAnchorViewController {

    //懒加载属性
    fileprivate lazy var amuseVM : AmuseViewModel = AmuseViewModel()
    
    //系统回调
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
    }
}

//请求数据
extension AmuseViewController {
    override func loadData() {
        //1.给父类中viewModel赋值
        baseVM = amuseVM
        
        //2.请求数据
        amuseVM.loadAmuseData { 
            self.collectionView.reloadData()
        }
    }
}





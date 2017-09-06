//
//  RecommendViewController.swift
//  DYZB
//
//  Created by 张起哲 on 2017/9/3.
//  Copyright © 2017年 张起哲. All rights reserved.
//

import UIKit

private let kItemMargin : CGFloat = 10
private let kHeaderViewH : CGFloat = 50

private let kNormalCellID = "kNormalCellID"
private let kHeaderViewID = "kHeaderViewID"

let kPrettyCellID = "kPrettyCellID"
let kNormalItemW = (kScreenW - 3 * kItemMargin) / 2
let kNormalItemH = kNormalItemW * 3 / 4
let kPrettyItemH = kNormalItemW * 4 / 3

class RecommendViewController: UIViewController {

    //懒加载属性
    lazy var recomendVM : RecommendViewModel = RecommendViewModel()
    lazy var collectionView : UICollectionView = {[weak self] in
        //1.创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kNormalItemW, height: kNormalItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        
        //2.创建UICollectionView
        let collectionView = UICollectionView(frame: (self?.view.bounds)!, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        collectionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        collectionView.register(UINib(nibName: "CollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellID)
        collectionView.register(UINib(nibName: "CollectionHeadView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        
        return collectionView
    }()
    
    
    //系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置UI
        setupUI()
        
        //发送网络请求
        loadData()
    }

}

//设置UI
extension RecommendViewController {
    fileprivate func setupUI() {
        //添加collectionView
        view.addSubview(collectionView)
    }
}

extension RecommendViewController {
    fileprivate func loadData() {
        recomendVM.requestData { 
            self.collectionView.reloadData()
        }
    }
}

// MARK:- 遵守UICollectionView的数据源
extension RecommendViewController : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return recomendVM.anchorGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let group = recomendVM.anchorGroups[section]
        
        return group.anchors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 1.取出模型对象
        let group = recomendVM.anchorGroups[indexPath.section]
        let anchor = group.anchors[indexPath.item]
        
        // 2.定义Cell
        var baseCell : CollectionBaseCell!
        
        // 3.取出Cell
        if indexPath.section == 1 {
            baseCell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath) as! CollectionPrettyCell
        } else {
            baseCell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! CollectionNormalCell
        }
        // 3.赋值给Cell
        baseCell.anchor = anchor
        
        return baseCell
        
        // 2.给cell设置数据
//        cell.anchor = baseVM.anchorGroups[indexPath.section].anchors[indexPath.item]
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        // 1.取出HeaderView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionHeadView
        
        // 2.给HeaderView设置数据
//        headerView.group = baseVM.anchorGroups[indexPath.section]
        
        headerView.group = recomendVM.anchorGroups[indexPath.section]
        
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: kNormalItemW, height: kPrettyItemH)
        }
        
        return CGSize(width: kNormalItemW, height: kNormalItemH)
    }
}


// MARK:- 遵守UICollectionView的代理协议
//extension RecommendViewController : UICollectionViewDelegate {
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        // 1.取出对应的主播信息
//        let anchor = baseVM.anchorGroups[indexPath.section].anchors[indexPath.item]
//        
//        // 2.判断是秀场房间&普通房间
//        anchor.isVertical == 0 ? pushNormalRoomVc() : presentShowRoomVc()
//    }
//    
//    private func presentShowRoomVc() {
//        // 1.创建ShowRoomVc
//        let showRoomVc = RoomShowViewController()
//        
//        // 2.以Modal方式弹出
//        present(showRoomVc, animated: true, completion: nil)
//    }
//    
//    private func pushNormalRoomVc() {
//        // 1.创建NormalRoomVc
//        let normalRoomVc = RoomNormalViewController()
//        
//        // 2.以Push方式弹出
//        navigationController?.pushViewController(normalRoomVc, animated: true)
//    }
//}

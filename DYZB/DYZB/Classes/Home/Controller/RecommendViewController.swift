//
//  RecommendViewController.swift
//  DYZB
//
//  Created by 张起哲 on 2017/9/3.
//  Copyright © 2017年 张起哲. All rights reserved.
//

import UIKit

//private let kItemMargin : CGFloat = 10
//private let kNormalItemW = (kScreenW - 3 * kItemMargin) / 2
//private let kNormalItemH = kNormalItemW * 3 / 4
//private let kPrettyItemH = kNormalItemW * 4 / 3
//private let kHeaderViewH : CGFloat = 50

private let kCycleViewH = kScreenW * 3 / 8
private let kGameViewH : CGFloat = 90

//private let kNormalCellID = "kNormalCellID"
//private let kHeaderViewID = "kHeaderViewID"
//private let kPrettyCellID = "kPrettyCellID"


class RecommendViewController: BaseAnchorViewController {

    //懒加载属性
    fileprivate lazy var recomendVM : RecommendViewModel = RecommendViewModel()
    
    fileprivate lazy var cycleView : RecommendCycleView = {
        let cycleView = RecommendCycleView.recomendCycleView()
        cycleView.frame = CGRect(x: 0, y: -(kCycleViewH + kGameViewH), width: kScreenW, height: kCycleViewH)
        return cycleView
    }()
    
    fileprivate lazy var gameView : RecommendGameView = {
        let gameView = RecommendGameView.recommendGameView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
        return gameView
    }()
    
//    //系统回调函数
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        //设置UI
//        setupUI()
//        
//        //发送网络请求
//        loadData()
//    }

}

//设置UI
extension RecommendViewController {
    override func setupUI() {
        //1.先调用super.setupUI(即：添加collectionView)
        super.setupUI()
        
        //2.将cycleView添加到CollectionView中
        collectionView.addSubview(cycleView)
        
        //3.将gameView添加collectionView中
        collectionView.addSubview(gameView)
        
        //4.设置collectionView的内边距
        collectionView.contentInset = UIEdgeInsets(top: kCycleViewH + kGameViewH, left: 0, bottom: 0, right: 0)
    }
}

extension RecommendViewController {
    override func loadData() {
        //0.给父类中的viewModel赋值
        baseVM = recomendVM
        
        //1.请求推荐数据
        recomendVM.requestData {
            //展示推荐数据
            self.collectionView.reloadData()
            
            // 2.将数据传递给GameView
            var groups = self.recomendVM.anchorGroups
            
            // 2.1.移除前两组数据
            groups.removeFirst()
            groups.removeFirst()
            
            // 2.2.添加更多组
            let moreGroup = AnchorGroup()
            moreGroup.tag_name = "更多"
            groups.append(moreGroup)
            
            self.gameView.groups = groups
            
            // 3.数据请求完成
            self.loadDataFinished()
        }
        
        //2.请求轮播数据
        recomendVM.requestCycleData {
            self.cycleView.cycleModels = self.recomendVM.cycleModels
        }
    }
}

//因为父类的方法不满足要求，所以重写该方法
extension RecommendViewController : UICollectionViewDelegateFlowLayout {
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 1 {
            // 1.取出PrettyCell
            let prettyCell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath) as! CollectionPrettyCell
            
            // 2.设置数据
            prettyCell.anchor = recomendVM.anchorGroups[indexPath.section].anchors[indexPath.item]
            
            return prettyCell
        } else {
            return super.collectionView(collectionView, cellForItemAt: indexPath)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: kNormalItemW, height: kPrettyItemH)
        }
        
        return CGSize(width: kNormalItemW, height: kNormalItemH)
    }
}


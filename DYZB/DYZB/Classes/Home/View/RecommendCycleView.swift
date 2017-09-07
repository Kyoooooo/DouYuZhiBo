//
//  RecommendCycleView.swift
//  DYZB
//
//  Created by 张起哲 on 2017/9/6.
//  Copyright © 2017年 张起哲. All rights reserved.
//

import UIKit

private let kCycleCellID = "kCycleCellID"

class RecommendCycleView: UIView {
    
    //定义属性
    var cycleTimer : Timer?
    var cycleModels : [CycleModel]? {
        didSet {
            //1.刷新
            collectionView.reloadData()
            
            //2.设置pageControl
            pageControl.numberOfPages = cycleModels?.count ?? 0
            
            //3.默认滚动到中间某一个位置(是为了让一开始滚动时就可以向左滚动)
            let indexPath = NSIndexPath(item: (cycleModels?.count ?? 0) * 10, section: 0)//大概是60的位置
            collectionView.scrollToItem(at: indexPath as IndexPath, at: .left, animated: false)
            
            //4.添加定时器(添加之前先移除，防止出现问题)
            removeCycleTimer()
            addCycleTimer()
            
        }
    }
    
    //控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    
    //系统回掉
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //设置该控件不随着父控件拉伸而拉伸
        autoresizingMask = UIViewAutoresizing()
        
        //注册cell
        collectionView.register(UINib(nibName: "CollectionCycleCell", bundle: nil), forCellWithReuseIdentifier: kCycleCellID)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // 设置collectionView的layout
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
    }

}

//提供一个快速创建View的类方法
extension RecommendCycleView {
    class func recomendCycleView() ->RecommendCycleView {
        return Bundle.main.loadNibNamed("RecommendCycleView", owner: nil, options: nil)?.first as! RecommendCycleView
    }
}

//遵守UICollectionView数据源协议
extension RecommendCycleView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //*10000时实现无限轮播，其实你一直滚也是可以滚完的（深井冰你就去滚一天吧）
        return (cycleModels?.count ?? 0) * 10000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView .dequeueReusableCell(withReuseIdentifier: kCycleCellID, for: indexPath) as! CollectionCycleCell
        
        //这里加上取模操作，是因为上面*10000，不然数组会越界
        cell.cycleModel = cycleModels![indexPath.item % cycleModels!.count]
        
        return cell
    }
}

//遵守UICollectionView代理协议
extension RecommendCycleView : UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //1.获取滚动的偏移量
        let offsetX = scrollView.contentOffset.x + scrollView.bounds.width * 0.5
        //+ scrollView.bounds.width * 0.5是让滚动到一半时让pageControl变化
        
        //2.计算pageControl的currentIndex
        //这里取模也是因为上面实现无限轮播*10000
        pageControl.currentPage = Int(offsetX / scrollView.bounds.width) % (cycleModels?.count ?? 1)
    }
    
    ///用户滚动时候，取消定时器的滚动
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeCycleTimer()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addCycleTimer()
    }
    
}

//对定时器的操作
extension RecommendCycleView {
    fileprivate func addCycleTimer() {
        cycleTimer = Timer(timeInterval: 3.0, target: self, selector: #selector(self.scrollToNext), userInfo: nil, repeats: true)
        RunLoop.main.add(cycleTimer!, forMode: .commonModes)
    }
    
    fileprivate func removeCycleTimer() {
        //从runloop中移除定时器
        cycleTimer?.invalidate()
        cycleTimer = nil
    }
    
    @objc private func scrollToNext() {
        //1.获取滚动的偏移量
        let currentOffsetX = collectionView.contentOffset.x
        let offSetX = currentOffsetX + collectionView.bounds.width
        
        //2.滚动到该位置
        collectionView.setContentOffset(CGPoint(x: offSetX, y: 0), animated: true)
    }
}



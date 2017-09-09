//
//  RecommendViewModel.swift
//  DYZB
//
//  Created by 张起哲 on 2017/9/5.
//  Copyright © 2017年 张起哲. All rights reserved.
//

import UIKit

class RecommendViewModel : BaseViewModel {
    
    //懒加载属性
    lazy var cycleModels : [CycleModel] = [CycleModel]()
    fileprivate lazy var bigDataGroup : AnchorGroup = AnchorGroup()
    fileprivate lazy var prettyGroup : AnchorGroup = AnchorGroup()
}

//发送网络请求
extension RecommendViewModel {
    //请求推荐数据
    func requestData(finishCallBack : @escaping () -> ()) {
        //0.定义参数
        let parameters = ["limit" : "4","offset" : "o", "time" : NSDate.getCurrentTime()]
        
        let dGroup = DispatchGroup()
        
        //1.请求第一部分推荐数据
        dGroup.enter()
        NetworkTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: ["time" : NSDate.getCurrentTime()]) { (result) in
            // 1.将result转成字典类型
            guard let resultDict = result as? [String : NSObject] else { return }
            
            // 2.根据data该key,获取数组
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            
            // 3.遍历字典,并且转成模型对象
            // 3.1.设置组的属性
            
            self.bigDataGroup.tag_name = "热门"
            self.bigDataGroup.icon_name = "home_header_hot"
            
            // 3.2.获取主播数据
            for dict in dataArray {
                let anchor = AnchorModel(dict: dict)
                self.bigDataGroup.anchors.append(anchor)
            }
            dGroup.leave()
            
        }
        
        //2.请求第二部分颜值数据
        dGroup.enter()
        NetworkTools.requestData(.get
            , URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: parameters) { (result) in
                //1.将result转成字典模型
                guard let resultDic = result as? [String : AnyObject] else {return}
                
                //2.根据data的key获取数组
                guard let dataArray = resultDic["data"] as? [[String : AnyObject]] else {return}
                
                //3.遍历字典，并且转成模型对象
                
                self.prettyGroup.tag_name = "颜值"
                self.prettyGroup.icon_name = "home_header_phone"
                
                for dic in dataArray {
                    let anchor = AnchorModel(dict: dic)
                    self.prettyGroup.anchors.append(anchor)
                }
                dGroup.leave()
                
        }
        
        //3.请求2-12部分游戏数据
        dGroup.enter()
//        NetworkTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: parameters) { (result) in
//            //1.将result转成字典模型
//            guard let resultDic = result as? [String : AnyObject] else {return}
//            
//            //2.根据data的key获取数组
//            guard let dataArray = resultDic["data"] as? [[String : AnyObject]] else {return}
//            
//            //3.遍历数组，获取字典，将字典转成模型对象
//            for dic in dataArray {
//                let group = AnchorGroup(dict: dic)
//                self.anchorGroups.append(group)
//            }
//            dGroup.leave()
//            
//        }
        
        loadAnchorData(URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: parameters) { 
            dGroup.leave()
        }
        
        //所有的数据都请求到
        dGroup.notify(queue: DispatchQueue.main) { 
            self.anchorGroups.insert(self.prettyGroup, at: 0)
            self.anchorGroups.insert(self.bigDataGroup, at: 0)
            
            finishCallBack()
        }
    }
    
    //请求无线轮播的数据
    func requestCycleData(finishCallback : @escaping () -> ()) {
        NetworkTools.requestData(.get, URLString: "http://www.douyutv.com/api/v1/slide/6", parameters: ["version" : "2.300"]) { (result) in
            //1.获取整体字典数据
            guard let resultDic = result as? [String : NSObject] else {return}
            
            //2.根据data的key获取数据
            guard let dataArray = resultDic["data"] as? [[String : NSObject]] else {return}
            
            //3.字典转模型
            for dict in dataArray {
                self.cycleModels.append(CycleModel(dict: dict))
            }
            
            
            finishCallback()
        }
    }

}

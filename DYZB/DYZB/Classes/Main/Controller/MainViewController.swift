//
//  MainViewController.swift
//  DYZB
//
//  Created by 张起哲 on 2017/9/1.
//  Copyright © 2017年 张起哲. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChildVc(storyName: "Home")
        addChildVc(storyName: "Live")
        addChildVc(storyName: "Follow")
        addChildVc(storyName: "Profile")
        
        }
    
    private func addChildVc (storyName: String) {
        //1.通过storyBoard获取控制器
        let childVc = UIStoryboard(name: storyName, bundle: nil).instantiateInitialViewController()!
        //2.添加自控制器
        addChildViewController(childVc)
    }

}

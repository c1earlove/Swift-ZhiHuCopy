//
//  MainViewController.swift
//  ZhiHuCopy
//
//  Created by clearlove on 2017/8/1.
//  Copyright © 2017年 clearlove. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let home = HomeViewController()
        home.view.backgroundColor = UIColor.white
        let nav = UINavigationController(rootViewController: home)
        nav.navigationBar.isHidden = true

        let theme = ThemViewController()
        theme.view.backgroundColor = UIColor.white
        let nav2 = UINavigationController(rootViewController: theme)
        nav2.navigationBar.isHidden = true
        
        
        let setting = SettingViewController()
        let nav3 = UINavigationController(rootViewController: setting)
        nav3.navigationBar.isHidden = true
        viewControllers = [nav,nav2,nav3]
        tabBar.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

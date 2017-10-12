//
//  MenuViewController.swift
//  ZhiHuCopy
//
//  Created by clearlove on 2017/8/3.
//  Copyright © 2017年 clearlove. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    var menuViewModel = MenuViewModel()
    var bindtoNav:UITabBarController?
    var thems = [ThemModel]()
    
    var showView = false {
        didSet{
            showMenu(show: showView)
        }
    }

    lazy var menuHeadView:MenuHeadView = {
       let head = MenuHeadView(frame: CGRect(x: 0, y: 0, width: screenW * 0.7, height: 130))
        head.delegate = self
        return head
    }()
 
    lazy var menuBottomView:MenuBottomView = {
       let bottom = MenuBottomView(frame: CGRect(x: 0, y: screenH - 60, width: screenW * 0.7, height: 60))
        return bottom
    }()
    lazy var tableView :UITableView = {
        let table = UITableView(frame: CGRect(x: 0, y: self.menuHeadView.bottom, width: screenW * 0.7, height: screenH - self.menuHeadView.bottom - 60), style: .plain)
        table.separatorStyle = .none
        table.backgroundColor = UIColor.clear
        table.delegate = self
        table.dataSource = self
        return table
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.rgb(34, 42, 48)
        view.addSubview(menuHeadView)
        view.addSubview(tableView)
        view.addSubview(menuBottomView)
        // Do any additional setup after loading the view.
        loadData()
    }

    func loadData() {
        menuViewModel.getThemes { (model) in
            self.thems = model.others!
            var m = ThemModel()
            m.name = "首页"
            self.thems.insert(m, at: 0)
            self.tableView.reloadData()
        }
    }
    
    func showMenu(show:Bool) {
        let view = UIApplication.shared.keyWindow?.subviews.first
        let menuView = UIApplication.shared.keyWindow?.subviews.last
        UIApplication.shared.keyWindow?.bringSubview(toFront: (UIApplication.shared.keyWindow?.subviews[1])!)
       UIView.animate(withDuration: 0.5) {
        if show{
            view?.transform = CGAffineTransform(translationX: screenW * 0.7, y: 0)
        }else{
            view?.transform = CGAffineTransform(translationX: 0, y: 0)
        }
        
        menuView?.transform = (view?.transform)!
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension MenuViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return thems.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let flag = "celll"
        var cell = tableView.dequeueReusableCell(withIdentifier: flag)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: flag)
        }
        cell?.backgroundColor = UIColor.rgb(34, 42, 48)
        cell?.textLabel?.font = UIFont.systemFont(ofSize: 13)
        cell?.textLabel?.textColor = UIColor.lightGray
        let model = thems[indexPath.row]
        cell?.textLabel?.text = model.name
        cell?.selectionStyle = .none
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showView = false
        
        showThmeVC(thems[indexPath.row])
    }
}

extension MenuViewController{
    fileprivate func showThmeVC(_ model:ThemModel) {
        if model.id == nil {
            bindtoNav?.selectedIndex = 0
        }else{
            bindtoNav?.selectedIndex = 1
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "setThems"), object: nil, userInfo:["model":model])
        }
    }
}

extension MenuViewController:MenuHeadViewDelegate{
    func clicked(index: Int) {
        switch index {
        case 0,1:
            break
        case 2:
           showView = false
            bindtoNav?.selectedIndex = 2
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "setting"), object: nil)
        default:
            break
        }
    }
}

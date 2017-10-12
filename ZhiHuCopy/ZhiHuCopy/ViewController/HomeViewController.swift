//
//  HomeViewController.swift
//  ZhiHuCopy
//
//  Created by clearlove on 2017/7/31.
//  Copyright © 2017年 clearlove. All rights reserved.
//

import UIKit
import RxSwift
import Moya
import RxDataSources
class HomeViewController: UIViewController {

    var navView = UIView()
    let homeViewModel = HomeViewModel()
    let dataArr = [storyModel]()
    var refreshView = RefreshView()
    var menuViewController = MenuViewController()
    let dispose = DisposeBag()
    
    lazy var bannerView :BannerView = {
        let banner = BannerView(frame: CGRect(x: 0, y: 0, width: screenW, height: 220))
        banner.backgroundColor = UIColor.white
      
        return banner
    }()
    
    lazy var tableView:UITableView = {
        let table = UITableView(frame: CGRect(x: 0, y: 0, width: screenW, height: screenH), style: .plain)
        table.rowHeight = 90
        table.separatorInset = UIEdgeInsetsMake(0, 25, 0, 20)
        return table
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stutasUI()
        view.addSubview(tableView)
        tableView.tableHeaderView = bannerView
    
        loadData()
        setNavBarUI()
        // Do any additional setup after loading the view.
       
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapClick(tap:)))
        
        tap.delegate = self;
        view.addGestureRecognizer(tap)
        
    }

    func tapClick(tap:UITapGestureRecognizer) {
        if menuViewController.showView == true {
            menuViewController.showView = !menuViewController.showView
        }
    }
    
    func addRefresh() {
        refreshView.frame = CGRect(x: 118, y: -2, width: 40, height: 40)
        refreshView.backgroundColor = UIColor.clear
        view.addSubview(refreshView)
    }
    
    private func loadData() {
        homeViewModel.delegate = self
        homeViewModel.tableView = tableView
        homeViewModel.refreView = refreshView
        homeViewModel.bannerView = bannerView
        homeViewModel.navView = navView
        homeViewModel.getNewsList()
        
    }
    
    private func setNavBarUI (){
        navView.frame = CGRect(x: 0, y: 0, width: screenW, height: 64)
        view.addSubview(navView)
        navView.alpha = 0
        
        
        let label = UILabel(frame: CGRect(x: 0, y: 20, width: screenW, height: 40))
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "今日热闻"
        view.addSubview(label)
        
        
        let btn = UIButton(type: .custom)
        btn.frame = CGRect(x: 10, y: 31.5, width: 22.5, height: 17)
        btn.setImage(UIImage(named: "menu"), for: .normal)
        view.addSubview(btn)

        btn.rx.tap.subscribe(onNext: { (sender) in
            UIApplication.shared.keyWindow?.addSubview(self.menuViewController.view)
            self.menuViewController.bindtoNav = self.navigationController?.tabBarController
            self.menuViewController.view.frame = CGRect(x: -screenW * 0.7, y: 0, width: screenW * 0.7, height: screenH)
            self.menuViewController.showView = !self.menuViewController.showView
        }, onError: nil, onCompleted: nil, onDisposed: nil).addDisposableTo(dispose)
        
    }
    
    private func stutasUI() {
        let sta = UIView(frame: CGRect(x: 0, y: 0, width: screenW, height: 1))
        view.addSubview(sta)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
extension HomeViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if menuViewController.showView == true {
            if (touch.view?.isKind(of: UITableView.self))! {
                return false
            }
            return true
        }
        return false
    }
}


extension HomeViewController:HomeViewModelDelegate{
    func didSelectRow(viewController: DetailViewController) {
         navigationController?.pushViewController(viewController, animated: true)
    }
}

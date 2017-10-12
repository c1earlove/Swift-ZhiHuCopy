//
//  HomeViewModel.swift
//  ZhiHuCopy
//
//  Created by clearlove on 2017/7/31.
//  Copyright © 2017年 clearlove. All rights reserved.
//

import UIKit
import Moya
import RxSwift

protocol HomeViewModelDelegate:class {
    func didSelectRow(viewController: DetailViewController)
}
class HomeViewModel: NSObject {

    private let provider = RxMoyaProvider<ApiManager>()
    let dispose = DisposeBag()
    
    var tableView = UITableView()
    var bannerView = BannerView()
    var navView = UIView()
    var dataArr = [storyModel]()
    var refreView = RefreshView()
    weak var delegate: HomeViewModelDelegate?
    func getNewsList() {
        tableView.delegate = self
        tableView.dataSource = self

        provider.request(.getNewsList).filterSuccessfulStatusCodes().mapJSON().mapObject(type: listModel.self).subscribe(onNext: { (model) in
            self.dataArr = model.stories!
            self.tableView.reloadData()
            self.bannerView.topStories = model.top_stories!

            
        }, onError: { (error) in
            
        }).addDisposableTo(dispose)
    }
  
}


extension HomeViewModel : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let flag = "cell"
        var cell = tableView.dequeueReusableCell(withIdentifier: flag) as? HomeCell
        if cell == nil {
            cell = HomeCell(style: .default, reuseIdentifier: flag)
        }
        cell?.model(model: dataArr[indexPath.row])
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var idArr = [Int]()
        dataArr.forEach { (model) in
            idArr.append(model.id!)
        }
        let detail = DetailViewController()
        detail.idArr = idArr
        detail.id = idArr[indexPath.row]
        delegate?.didSelectRow(viewController: detail)
        
        
    }
    
}

extension HomeViewModel : UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        navView.backgroundColor = UIColor.rgb(48, 142, 205)
        navView.alpha = scrollView.contentOffset.y / 200
        bannerView.offY.value = Double(scrollView.contentOffset.y)
        refreView.pullToRefresh(progress: -scrollView.contentOffset.y / 64)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView.contentOffset.y <= -64 {
            refreView.beginRefresh {
                self.getNewsList()
            }
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        refreView.resetLayer()
    }
}





//
//  BannerView.swift
//  ZhiHuCopy
//
//  Created by clearlove on 2017/7/31.
//  Copyright © 2017年 clearlove. All rights reserved.
//

import UIKit
import RxSwift
import SnapKit
import Kingfisher
let COLL_TAG = 8888
let PAGE_TAG = 6666

protocol BannerViewDelegate: class {
    func selectedItem(model: storyModel)
}

class BannerView: UIView {

    var timer = Timer()
    var offY = Variable(0.0)
    var dispose = DisposeBag()
    var bannerDelegate: BannerViewDelegate?
    var topStories = [storyModel](){
        didSet{
            let collect = viewWithTag(COLL_TAG) as! UICollectionView
            collect.reloadData()
            
            let page = viewWithTag(PAGE_TAG) as!UIPageControl
            page.numberOfPages = topStories.count
            addTimer()
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: frame, collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
        collection.tag = COLL_TAG
        collection.isPagingEnabled = true
        collection.showsVerticalScrollIndicator = false
        collection.showsHorizontalScrollIndicator = false
        collection.clipsToBounds = true
        layout.itemSize = CGSize(width: collection.width, height: collection.height)
        layout.minimumLineSpacing = 0.0
        layout.minimumInteritemSpacing = 0.0
        layout.scrollDirection = .horizontal
        addSubview(collection)

        let pageCotrol = UIPageControl(frame: CGRect(x: 0, y: frame.size.height - 25, width: screenW, height: 20))
        pageCotrol.tag = PAGE_TAG
    
        addSubview(pageCotrol)
        
        pageCotrol.rx.controlEvent(.touchUpInside).subscribe(onNext: { () in
            
            collection.contentOffset.x = screenW * CGFloat(pageCotrol.currentPage)
            
        }, onError: { (error) in
            
        }, onCompleted: { 
            
        }).addDisposableTo(dispose)
        
        collection.register(BannerViewCell.self, forCellWithReuseIdentifier: "cell")
        
        
        offY.asObservable().subscribe(onNext: { (offsetY) in
            let collect = self.viewWithTag(COLL_TAG) as! UICollectionView
            collect.visibleCells.forEach({ (cell) in
                
                let cell = cell as! BannerViewCell
                cell.img.frame.origin.y = CGFloat(offsetY)
                cell.img.frame.size.height = 220 - CGFloat(offsetY)
                
            })
        }).addDisposableTo(dispose)
    }
    
    
    func addTimer() {
        timer = Timer(timeInterval: 3.0, target: self, selector: #selector(scrollImage), userInfo: nil, repeats: true)
        RunLoop.main.add(timer, forMode: .commonModes)
    }
    func removeTimer() {
        timer.invalidate()
        timer.fire()
    }
    func scrollImage() {
        let collect = viewWithTag(COLL_TAG) as! UICollectionView
        //设置当前的indexpath
        let currnetIndexPath = collect.indexPathsForVisibleItems.first! as IndexPath
        let currentIndexPathReset = IndexPath(item: currnetIndexPath.item, section: 50)
        collect.scrollToItem(at: currentIndexPathReset, at: .left, animated: true)
        
        //设置下一个滚动的item
        var nextItem = currentIndexPathReset.item + 1
        var nextSection = currentIndexPathReset.section
        if nextItem == topStories.count {//当item等于轮播图的总个数
            nextItem = 0
            nextSection += 1
        }
        
        let nextIndexPath = IndexPath(item: nextItem, section: nextSection)
        collect.scrollToItem(at: nextIndexPath, at: .left, animated: true)
    }
}

extension BannerView:UICollectionViewDelegate,UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 100
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return topStories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! BannerViewCell
        cell.model(model: topStories[indexPath.item])
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        bannerDelegate?.selectedItem(model: topStories[indexPath.item])
    }
    
}

extension BannerView:UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //滚动时 动态设置pageControl.currentPage
        let page = viewWithTag(PAGE_TAG) as! UIPageControl
        page.currentPage = (Int)(scrollView.contentOffset.x / scrollView.frame.size.width + 0.5) % topStories.count
        
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeTimer()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addTimer()
    }
}





//
//  DetailViewController.swift
//  ZhiHuCopy
//
//  Created by clearlove on 2017/8/1.
//  Copyright © 2017年 clearlove. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var previousWeb = DetailWebView()
    var detailViewModel: DetailViewModel?
    var idArr = [Int]()
    var statusView = UIView()
    var nextID = Int()
    var previousID = Int()
    var id = Int()
    
    //MARK: --  lazy load
    lazy var bottomView: DetailBottomView = {
        let bottom = DetailBottomView(frame: CGRect(x: 0, y: screenH - 40, width: screenW, height: 40))
        bottom.delegate = self
        return bottom
    }()
    lazy var detailWebView: DetailWebView = {
        let web = DetailWebView(frame: CGRect(x: 0, y: 0, width: screenW, height: screenH - 40))
        return web
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        stutasUI()
        view.addSubview(detailWebView)
        view.addSubview(bottomView)
        previousWeb = DetailWebView.init(frame: CGRect(x: 0, y: -screenH, width: screenW, height: screenH-40))
        view.addSubview(previousWeb)
        
        
        detailViewModel = DetailViewModel.init(id: id)
        detailWebView.delegate = detailViewModel
        detailWebView.scrollView.delegate = detailViewModel
        detailViewModel?.detailWebView = detailWebView
        detailViewModel?.previousWeb = previousWeb
        detailViewModel?.statusView = statusView
        detailViewModel?.controllerVIew = view
        detailViewModel?.nextid = nextID
        detailViewModel?.previousID = previousID
        detailViewModel?.idArr = idArr
        detailViewModel?.id = id
    }
    private func stutasUI() {
        
        statusView = UIView(frame: CGRect(x: 0, y: 0, width: screenW, height: 20))
        statusView.backgroundColor = UIColor.white
        view.addSubview(statusView)
        statusView.isHidden = true
        
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


// MARK: - DetailBottomViewDelegate
extension DetailViewController: DetailBottomViewDelegate {
    
    func bottomViewClick(with index: Int) {
        
        switch index {
        case 0:
            navigationController!.popViewController(animated: true)
        default: break
            
        }
    }
}

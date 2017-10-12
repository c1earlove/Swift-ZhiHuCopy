//
//  DetailViewModel.swift
//  ZhiHuCopy
//
//  Created by clearlove on 2017/8/4.
//  Copyright © 2017年 clearlove. All rights reserved.
//

import UIKit
import RxSwift
import Moya
class DetailViewModel: NSObject {

    let dispose = DisposeBag()
    var detailWebView = DetailWebView()
    var previousWeb = DetailWebView()
    var statusView = UIView()
    var controllerVIew = UIView()
    var nextid = Int()
    var previousID = Int()
    var idArr = [Int]()
    private let provider = RxMoyaProvider<ApiManager>()
    var id = Int(){
        didSet {
            for (index,element) in idArr.enumerated() {
                if id == element {
                    if index == 0 {
                        //  最新的一条
                        previousID = 0
                        nextid = idArr[index + 1]
                    } else if index == idArr.count - 1 {
                        //最后一条
                        nextid = -1
                        previousID = idArr[index - 1]
                    }else {
                      previousID = idArr[index - 1]
                        nextid = idArr[index + 1]
                    }
                    break;
                }
            }
        }
    }
    
    
    init(id: Int) {
        super.init()
    
        setupUI()
        getNewsDetail(id: id)
    }
    func setupUI()  {
        if previousID == 0 {
            detailWebView.previousLab.text = "已经是第一篇了"
        }else{
            detailWebView.previousLab.text = "载入上一篇"
        }
        
        if nextid == -1 {
            detailWebView.previousLab.text = "已经是最后一篇了"
        }else{
            detailWebView.previousLab.text = "载入下一篇"
        }
        
    }
    
    fileprivate func getNewsDetail(id:Int) {
        provider.request(.getNewssDesc(id)).filterSuccessfulStatusCodes().mapJSON().mapObject(type: DeatilModel.self).subscribe(onNext: { (model) in
            
            if let image = model.image {
                self.detailWebView.img.kf.setImage(with: URL(string: image))
                self.detailWebView.titleLable.text = model.title
            }else{
                self.detailWebView.img.isHidden = true
                self.detailWebView.previousLab.textColor = UIColor.colorFromHex(0x777777)
            }
            
            if let image_source = model.image_source {
                self.detailWebView.imgLab.text = "图片: " + image_source
            }
            if model.title.characters.count > 16 {
                self.detailWebView.titleLable.frame = CGRect(x: 15, y: 120, width: screenW - 30, height: 55)
            }
            
            OperationQueue.main.addOperation {
                self.detailWebView.loadHTMLString(self.loadHTMLFile(css: model.css, body: model.body), baseURL: nil)
            }
            
            
        }, onError: { (error) in
            
        }, onCompleted: { 
            
        }).addDisposableTo(dispose)
    }
   
    private func loadHTMLFile(css:[String],body:String) -> String {
        var html = "<html>"
        html += "<head>"
        css.forEach {
            html += "<link rel=\"stylesheet\" href=\($0)>"
        }
        html += "<style>img{max-width:320px !important;}</style>"
        html += "</head>"
        html += "<body>"
        html += body
        html += "</body>"
        html += "</html>"
        return html
    }
    
}

//MARK: -- UIWebViewDelegate

extension DetailViewModel : UIWebViewDelegate {
    func webViewDidFinishLoad(_ webView: UIWebView) {
        detailWebView.waitView.removeFromSuperview()
        detailWebView.nextLab.frame = CGRect(x: 15, y: self.detailWebView.scrollView.contentSize.height + 10, width: screenW - 30, height: 20)
    }
}

//MARK: -- UIScrollViewDelegate

extension DetailViewModel: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if detailWebView.scrollView.contentOffset.y > 200 {
            controllerVIew.bringSubview(toFront: statusView)
            UIApplication.shared.statusBarStyle = .default
            statusView.isHidden = false
        }else{
            UIApplication.shared.statusBarStyle = .lightContent
            statusView.isHidden = true
        }
        
        detailWebView.img.height = max(200 - scrollView.contentOffset.y, 200)
        detailWebView.img.y = min(scrollView.contentOffset.y, 0)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        //载入上一篇
        if scrollView.contentOffset.y <= -100 {
            if previousID > 0 {
                previousWeb.frame = CGRect(x: 0, y: -screenH, width: screenW, height: screenH - 40)
                UIView.animate(withDuration: 0.3, animations: {
                    self.detailWebView.transform = CGAffineTransform(translationX: 0, y: screenH)
                    self.previousWeb.transform = CGAffineTransform(translationX: 0, y: screenH)
                }, completion: { (state) in
                    if state {
                        self.changeWebView(self.previousID)
                    }
                })
            }
        }
        
        //载入下一篇
        if scrollView.contentOffset.y - 100 + screenH >= scrollView.contentSize.height {
            if nextid > 0 {
                previousWeb.frame = CGRect.init(x: 0, y: screenH, width: screenW, height: screenH-40)
                UIView.animate(withDuration: 0.3, animations: {
                    self.previousWeb.transform = CGAffineTransform.init(translationX: 0, y: -screenH)
                    self.detailWebView.transform = CGAffineTransform.init(translationX: 0, y: -screenH)
                }, completion: { (state) in
                    if state {
                        self.changeWebView(self.nextid)
                    }
                })
            }
        }
        
        
    }
}


extension DetailViewModel {
    func changeWebView(_ showId: Int) {
        detailWebView.removeFromSuperview()
        previousWeb.scrollView.delegate = self
        previousWeb.delegate = self;
        detailWebView = previousWeb
        id = showId
        getNewsDetail(id: id)
        setupUI()
        previousWeb = DetailWebView(frame: CGRect(x: 0, y: -screenH, width: screenW, height: screenH - 40))
        controllerVIew.addSubview(previousWeb)
        scrollViewDidScroll(detailWebView.scrollView)
    }
}


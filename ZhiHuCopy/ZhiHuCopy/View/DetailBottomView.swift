//
//  DetailBottomView.swift
//  ZhiHuCopy
//
//  Created by clearlove on 2017/8/4.
//  Copyright © 2017年 clearlove. All rights reserved.
//

import UIKit
import RxSwift

class DetailBottomView: UIView {

    weak var delegate: DetailBottomViewDelegate?
    var dispose = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.white
        
        let line = UIView(frame: CGRect(x: 0, y: 0, width: screenW, height: 0.5))
        line.backgroundColor = UIColor.lightGray
        
        addSubview(line)
        
        
        for index in 0...4 {
            let btn = UIButton(type: .custom)
            btn.frame = CGRect(x: CGFloat(index) * screenW/5, y: 0.5, width: screenW/5, height: frame.size.height-0.5)
            btn.setImage(UIImage(named: ["back","down","zan","share","comment"][index]), for: .normal)
            addSubview(btn)
            btn.rx
                .tap
                .subscribe(onNext: { (sender) in
                    
                    self.delegate?.bottomViewClick(with: index)
                }, onError: nil, onCompleted: nil, onDisposed: nil).addDisposableTo(dispose)
            
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

protocol DetailBottomViewDelegate: class {
    func bottomViewClick(with index: Int)
}



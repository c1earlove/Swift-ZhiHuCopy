//
//  MenuBottomView.swift
//  ZhiHuCopy
//
//  Created by clearlove on 2017/8/4.
//  Copyright © 2017年 clearlove. All rights reserved.
//

import UIKit
import RxSwift
class MenuBottomView: UIView {

    let dispose = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        for index in 0...1 {
            let button = UIButton(type: .custom)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
            button.setTitleColor(UIColor.lightGray, for: .normal)
            button.setTitle(["完成","夜间"][index], for: .normal)
            button.setImage(UIImage(named: ["download","moon"][index]), for: .normal)
            button.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0)
            addSubview(button)
            button.snp.makeConstraints({ (make) in
                make.left.equalTo(CGFloat(index) * screenW * 0.7 / 2)
                make.width.equalTo(screenW * 0.7 / 2)
                make.height.equalTo(60)
                make.bottom.equalTo(self)
            })
            button.rx.tap.subscribe({(sender) in
                if index == 1{
                    print("夜间")
                }
            }).addDisposableTo(dispose)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//
//  MenuHeadView.swift
//  ZhiHuCopy
//
//  Created by clearlove on 2017/8/4.
//  Copyright © 2017年 clearlove. All rights reserved.
//

import UIKit
import RxSwift

protocol MenuHeadViewDelegate : class {
    func clicked(index:Int)
}

class MenuHeadView: UIView {
    
    weak var delegate: MenuHeadViewDelegate?
    let dispose = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.rgb(34, 42, 48)
        let button = UIButton(type: .custom)
        button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0)
        button.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0)
        button.setImage(UIImage(named: "Menu_Avatar"), for: .normal)
        button.setTitle("请登录", for: .normal)
        button.setTitleColor(UIColor.lightGray, for: .normal)
        addSubview(button)
        button.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.top.equalTo(35)
            make.height.equalTo(40)
            make.width.equalTo(100)
        }
        
        
        for index in 0...2 {
            let customButton = CustomButton()
            customButton.setImage(UIImage(named: ["collect","msg","setting"][index]), for: .normal)
            customButton.titleLabel?.font = UIFont.systemFont(ofSize: 10)
            customButton.setTitleColor(UIColor.lightGray, for: .normal)
            addSubview(customButton)
            customButton.snp.makeConstraints({ (make) in
                make.left.equalTo(CGFloat(index) * screenW * 0.7 / 3)
                make.bottom.equalTo(-10)
                make.width.equalTo(screenW * 0.7 / 3)
                make.height.equalTo(40)
            })
            customButton.rx.tap.subscribe({ (sender) in
              self.delegate?.clicked(index: index)
            }).addDisposableTo(dispose)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
class CustomButton: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        let midX = self.frame.size.width / 2
        let midY = self.frame.size.height / 2
        self.titleLabel?.center = CGPoint(x: midX, y: midY + 15)
        self.imageView?.center = CGPoint(x: midX, y: midY - 10)
        
    }
}

//
//  RefreshView.swift
//  ZhiHuCopy
//
//  Created by clearlove on 2017/7/31.
//  Copyright © 2017年 clearlove. All rights reserved.
//

import UIKit
import Then
class RefreshView: UIView {

    let circleLayer = CAShapeLayer()
    let indicatorView = UIActivityIndicatorView().then {
        $0.frame = CGRect(x: 0, y: 0, width: 16, height: 16)
    }

    
    fileprivate var refreshing = false
    fileprivate var endRef = false
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createCircleLayer()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        circleLayer.position = CGPoint(x: frame.width / 2, y: frame.height / 2)
        indicatorView.center = CGPoint(x: frame.width / 2, y: frame.height / 2)
    }
    
    func createCircleLayer() {
        circleLayer.path = UIBezierPath(arcCenter: CGPoint(x: 8, y: 8), radius: 8, startAngle: CGFloat(Double.pi / 2), endAngle: CGFloat(Double.pi / 2 + Double(2 * Double.pi)), clockwise: true).cgPath
        circleLayer.strokeColor = UIColor.red.cgColor
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.strokeStart = 0.0
        circleLayer.strokeEnd = 0.0
        circleLayer.lineWidth = 1.0
        circleLayer.lineCap = kCALineCapRound
        circleLayer.bounds = CGRect(x: 0, y: 0, width: 16, height: 16)
        circleLayer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        layer.addSublayer(circleLayer)
    }
}

extension RefreshView {
    //向下拖拽视图准备刷新的过程会响应
    func pullToRefresh(progress:CGFloat) {
        circleLayer.strokeEnd = progress
    }
    
    //开始刷新
    func beginRefresh(begin: @escaping () -> ()) {
        if refreshing {
            // 防止刷新过程中又请求刷新
            return
        }
        refreshing = true
        circleLayer.removeFromSuperlayer()
        addSubview(indicatorView)
        indicatorView.startAnimating()
        begin()
    }
    //结束刷新
    func endRefresh() {
        refreshing = false
        indicatorView.stopAnimating()
        indicatorView.removeFromSuperview()
    }
    
    //重新绘制刷新组控件
    func resetLayer() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) { 
            self.createCircleLayer()
        }
    }
    
}


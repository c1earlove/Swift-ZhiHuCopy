//
//  BannerViewCell.swift
//  ZhiHuCopy
//
//  Created by clearlove on 2017/8/1.
//  Copyright © 2017年 clearlove. All rights reserved.
//

import UIKit

class BannerViewCell: UICollectionViewCell {
    
    
    var img = UIImageView()
    var titleLabel = UILabel()
    
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        img = UIImageView.init()
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        contentView.addSubview(img)
        img.snp.makeConstraints { (make) in
            make.left.top.bottom.right.equalTo(contentView)
        }
        
        titleLabel = UILabel.init()
        titleLabel.font = UIFont.boldSystemFont(ofSize: 22)
        titleLabel.textColor = UIColor.white
        titleLabel.numberOfLines = 0
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.bottom.equalTo(-30)
        }
        
        
        
    }
    func model(model: storyModel) {
        img.kf.setImage(with: URL.init(string: model.image!))
        titleLabel.text = model.title
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}






//class BannerViewCell: UICollectionViewCell {
//    var img = UIImageView()
//    var titleLabel = UILabel()
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        img = UIImageView()
//        img.contentMode = .scaleAspectFill
//        img.clipsToBounds = true
//        contentView.addSubview(img)
//        img.snp.makeConstraints { (make) in
//            make.left.top.bottom.right.equalTo(contentView)
//        }
//        titleLabel = UILabel()
//        titleLabel.font = UIFont.systemFont(ofSize: 22)
//        titleLabel.textColor = UIColor.white
//        titleLabel.numberOfLines = 0
//        contentView.addSubview(titleLabel)
//        titleLabel.snp.makeConstraints { (make) in
//            make.left.equalTo(15)
//            make.right.equalTo(-15)
//            make.bottom.equalTo(-30)
//        }
//        
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    var model:storyModel {
//        didSet{
//            img.kf.setImage(with: URL(string: model.image!))
//            titleLabel.text = model.title
//        }
//    }
//    
//    
//}

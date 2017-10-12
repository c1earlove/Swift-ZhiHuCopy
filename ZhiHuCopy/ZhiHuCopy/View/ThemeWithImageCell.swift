//
//  ThemeWithImageCell.swift
//  ZhiHuCopy
//
//  Created by clearlove on 2017/8/8.
//  Copyright © 2017年 clearlove. All rights reserved.
//

import UIKit

class ThemeWithImageCell: UITableViewCell {

    
    var titleLabel = UILabel()
    var titleImgView = UIImageView()
    var model = ThemeStoryModel() {
        
        didSet {
            
            titleLabel.text = model.title
            titleImgView.kf.setImage(with: URL(string: (model.images?.first)!))
            
        }
        
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        titleImgView = UIImageView()
        contentView.addSubview(titleImgView)
        titleImgView.snp.makeConstraints { (make) in
            make.right.bottom.equalTo(-15)
            make.top.equalTo(15)
            make.width.equalTo((90 - 15*2)*1.2)
        }
        
        
        titleLabel = UILabel()
        titleLabel.font = UIFont.boldSystemFont(ofSize: 15)
        titleLabel.numberOfLines = 0
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.top.equalTo(15)
            make.right.equalTo(titleImgView.snp.left).offset(-15)
        }
        
    }
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        
        context?.setFillColor(UIColor.clear.cgColor)
        context?.fill(rect)
        
        //上分割线，
        context?.setStrokeColor(UIColor.rgb(225, 225, 225).cgColor)
        context?.stroke(CGRect(x: 0, y: 0, width: 0, height: 0))
        
        //下分割线
        context?.setStrokeColor(UIColor.rgb(225, 225, 225).cgColor)
        context?.stroke(CGRect(x: 15, y: rect.size.height, width: rect.size.width-30, height: 0.5))
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

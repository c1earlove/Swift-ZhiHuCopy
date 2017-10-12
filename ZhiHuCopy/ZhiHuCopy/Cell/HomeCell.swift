//
//  HomeCell.swift
//  ZhiHuCopy
//
//  Created by clearlove on 2017/8/1.
//  Copyright © 2017年 clearlove. All rights reserved.
//

import UIKit
import Kingfisher
import SnapKit

class HomeCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var titleLabel = UILabel()
    var cellImageView = UIImageView()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        cellImageView = UIImageView()
        contentView.addSubview(cellImageView)
        cellImageView.snp.makeConstraints { (make) in
            make.right.bottom.equalTo(-15)
            make.top.equalTo(15)
            make.width.equalTo((90 - 15 * 2) * 1.2)
        }
        contentView.addSubview(titleLabel)
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.numberOfLines = 0
        titleLabel.snp.makeConstraints { (make) in
            make.left.top.equalTo(15)
            make.right.equalTo(cellImageView.snp.left).offset(-15)
        }
        
    }
    func model(model:storyModel) {
        titleLabel.text = model.title
        cellImageView.kf.setImage(with: URL(string: (model.images?.count)! > 0 ? (model.images?.first)! : ""))
    }
    
    
    
}

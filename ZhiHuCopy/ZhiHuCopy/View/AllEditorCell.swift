//
//  AllEditorCell.swift
//  ZhiHuCopy
//
//  Created by clearlove on 2017/8/8.
//  Copyright © 2017年 clearlove. All rights reserved.
//

import UIKit

let collec_tag = 100000


class AllEditorCell: UITableViewCell {
    
    var editors = [EditorModel]() {

        didSet {
            
            let collec = contentView.viewWithTag(collec_tag) as! UICollectionView
            collec.reloadData()
            
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
        context?.setStrokeColor(UIColor.rgb( 225, 225, 225).cgColor)
        context?.stroke(CGRect(x: 0, y: rect.size.height, width: rect.size.width, height: 0.5))
        
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.text = "主编"
        contentView.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.centerY.equalTo(contentView)
            make.width.equalTo(40)
            make.height.equalTo(25)
        }
        
        let img = UIImageView()
        img.image = UIImage(named: "next")
        contentView.addSubview(img)
        img.snp.makeConstraints { (make) in
            make.left.equalTo(screenW-30)
            make.centerY.equalTo(contentView)
            make.width.height.equalTo(15)
        }
        
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 20, height: 20)
        let collectionView = UICollectionView(frame: CGRect(x: 60, y: 0, width: screenW-60-35, height: 34), collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.tag = collec_tag
        collectionView.backgroundColor = UIColor.white
        contentView.addSubview(collectionView)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
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

extension AllEditorCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return editors.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        let model = editors[indexPath.item]
        
        let img = UIImageView()
        img.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        img.layer.cornerRadius = 10
        img.layer.masksToBounds = true
        img.kf.setImage(with: URL(string: model.avatar!))
        cell.contentView.addSubview(img)
        
        return cell
        
    }
}

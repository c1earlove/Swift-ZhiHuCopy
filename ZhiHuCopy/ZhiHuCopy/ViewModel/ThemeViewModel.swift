//
//  ThemeViewModel.swift
//  ZhiHuCopy
//
//  Created by clearlove on 2017/8/8.
//  Copyright © 2017年 clearlove. All rights reserved.
//

import UIKit
import HandyJSON
import RxSwift
import Moya

class ThemeViewModel: NSObject {
    private let provider = RxMoyaProvider<ApiManager>()
    let dispose = DisposeBag()
    /// 获取主题详情
    ///
    /// - Parameters:
    ///   - id: id
    ///   - completed: 完成的回调
    func getThemeDetail(id: Int,completed: @escaping (_ model: ThemeDetailModel) -> ()) {
        
        provider.request(.getThemDesc(id)).mapModel(ThemeDetailModel.self).subscribe(onNext: { (model) in
            
            completed(model)
        }, onError: { (error) in
            
        }).addDisposableTo(dispose)
    }
}
struct ThemeDetailModel: HandyJSON {
    var stories: [ThemeStoryModel]?
    var description: String?
    var background: String?
    var color: Int?
    var name: String?
    var image: String?
    var editors: [EditorModel]?
    var image_source: String?
    
}


struct ThemeStoryModel: HandyJSON {
    var images: [String]?
    var type: Int?
    var id: Int?
    var title: String?
    
}
struct EditorModel: HandyJSON {
    
    var url: String?
    var bio: String?
    var id: Int?
    var avatar: String?
    var name: String?
}

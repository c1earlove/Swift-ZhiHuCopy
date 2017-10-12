//
//  MenuViewModel.swift
//  ZhiHuCopy
//
//  Created by clearlove on 2017/8/4.
//  Copyright © 2017年 clearlove. All rights reserved.
//

import UIKit
import Moya
import RxSwift
import ObjectMapper
import HandyJSON
class MenuViewModel: NSObject {

    private let provide = RxMoyaProvider<ApiManager>()
    let dispose = DisposeBag()
    
    func getThemes(completed:@escaping (_ model:MenuModel) -> ()) -> () {
        provide.request(.getThemLlist).mapModel(MenuModel.self).subscribe(onNext: { (model) in
            completed(model)
        }, onError: nil, onCompleted: nil, onDisposed: nil).addDisposableTo(dispose)
    }
    
}

struct MenuModel:HandyJSON {
    var others : [ThemModel]?
    
}
struct ThemModel:HandyJSON {
    var color: String?
    var thumbnail: String?
    var id: Int?
    var description: String?
    var name: String?
}

//
//  ApiManager.swift
//  ZhiHuCopy
//
//  Created by clearlove on 2017/7/27.
//  Copyright © 2017年 clearlove. All rights reserved.
//

import UIKit
import Moya


enum ApiManager {
    case getLaunchImg
    case getNewsList
    case getMoreNews(String)
    case getThemLlist
    case getThemDesc(Int)
    case getNewssDesc(Int)
}

extension ApiManager: TargetType{
    var baseURL:URL{
        return URL(string: "http://news-at.zhihu.com/api/")!
    }
    
    var path : String {
        switch self {
        case .getLaunchImg:
            return "7/prefetch-launch-images/750*1142"
        case .getNewsList:
            return "4/news/latest"
        case .getMoreNews(let date):
            return "4/news/before/" + date
        case .getThemLlist:
            return "4/themes"
        case .getThemDesc(let id):
            return "4/theme/\(id)"
        case .getNewssDesc(let id):
            return "4/news/\(id)"
        }
    }
    var method: Moya.Method {
        return .get
    }
    var parameters:[String:Any]? {
        return nil
    }
    
    var parameterEncoding:ParameterEncoding {
        return URLEncoding.default
    }
    var sampleData:Data {
        return "".data(using: String.Encoding.utf8)!
    }
    var task:Task {
        return .request
    }
    
    var validate:Bool {
        return false
    }
    
    
    
    
    
}

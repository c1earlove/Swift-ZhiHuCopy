//
//  StoryModel.swift
//  ZhiHuCopy
//
//  Created by clearlove on 2017/7/31.
//  Copyright © 2017年 clearlove. All rights reserved.
//

import UIKit
import ObjectMapper

class listModel: Mappable {
    
    var date: String?
    var stories: [storyModel]?
    var top_stories: [storyModel]?
    
    required init?(map: Map) {
        
    }
    
    public func mapping(map: Map) {
        date <- map["date"]
        stories <- map["stories"]
        top_stories <- map["top_stories"]
    }
    
}

class storyModel: Mappable {
    var ga_prefix: String?
    var id: Int?
    var images: [String]?
    var title: String?
    var type: Int?
    var image: String?
    var multipic = false
    
    required init?(map: Map) {
        
    }
    
    public func mapping(map: Map) {
        
        ga_prefix <- map["ga_prefix"]
        id <- map["id"]
        images <- map["images"]
        title <- map["title"]
        type <- map["type"]
        image <- map["image"]
        multipic <- map["multipic"]
        
    }
}

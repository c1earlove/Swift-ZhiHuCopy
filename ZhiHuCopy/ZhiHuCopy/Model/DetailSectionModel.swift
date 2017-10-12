//
//  DetailSectionModel.swift
//  ZhiHuCopy
//
//  Created by clearlove on 2017/8/4.
//  Copyright © 2017年 clearlove. All rights reserved.
//

import UIKit

import ObjectMapper

class DeatilModel: Mappable {
    required init?(map: Map) {
        
    }
    var body = String()
    var image_source: String?
    var title = String()
    var image: String?
    var share_url = String()
    var js = String()
    var recommenders = [[String: String]]()
    var ga_prefix = String()
    var section: DetailSectionModel?
    var type = Int()
    var id = Int()
    var css = [String]()
    
    func mapping(map: Map) {
        body <- map["body"]
        image_source <- map["image_source"]
        title <- map["title"]
        image <- map["image"]
        share_url <- map["share_url"]
        js <- map["js"]
        recommenders <- map["recommenders"]
        ga_prefix <- map["ga_prefix"]
        section <- map["section"]
        type <- map["type"]
        id <- map["id"]
        css <- map["css"]
    }
}


class DetailSectionModel: Mappable {

    required init?(map: Map) {
        
    }
    
    var thumbnail = String()
    var id = Int()
    var name = String()
    

    func mapping(map: Map) {
        thumbnail <- map["thumbnail"]
        id <- map["id"]
        name <- map["name"]
    }
}

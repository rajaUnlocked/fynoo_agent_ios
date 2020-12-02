//
//  MallMarket.swift
//  Fynoo Business
//
//  Created by Sendan IT on 17/09/19.
//  Copyright © 2019 Sendan. All rights reserved.
//


    import ObjectMapper
    
    struct MallMarket : Mappable {
        var error : Bool?
        var error_code : Int?
        var error_description : String?
        var data : MallMarketData?
        
        init?(map: Map) {
            
        }
        
        mutating func mapping(map: Map) {
            
            error <- map["error"]
            error_code <- map["error_code"]
            error_description <- map["error_description"]
            data <- map["data"]
        }
        
}

struct MallMarketData : Mappable {
       var mall_market_list : [Mall_market_list]?
       var page_limit : Int?
       var total_records : Int?
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
         page_limit <- map["page_limit"]
        total_records <- map["total_records"]
         mall_market_list <- map["mall_market_list"]
    }
    
}
struct Mall_market_list : Mappable {
    var id : Int?
    var name : String?
    var area : String?
    var city : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        name <- map["name"]
        area <- map["area"]
        city <- map["city"]
    }
    
}

//
//  SimilarDataSell.swift
//  Fynoo
//
//  Created by IND-SEN-LP-039 on 26/08/20.
//  Copyright © 2020 neerajTiwari. All rights reserved.
//

import Foundation
import ObjectMapper

struct SimilarDataSell : Mappable {
    var error : Bool?
    var error_code : Int?
    var error_description : String?
    var data : SimilarDataSellData?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        error <- map["error"]
        error_code <- map["error_code"]
        error_description <- map["error_description"]
        data <- map["data"]
    }

}
struct SimilarDataSellData : Mappable {
var page_limit : Int?
var product_list : [Product_listsell]?

init?(map: Map) {

}

mutating func mapping(map: Map) {

    page_limit <- map["page_limit"]
    product_list <- map["product_list"]
}
}
struct Product_listsell : Mappable {
    var pro_id : Int?
    var image : String?
    var pro_name : String?
    var pro_price : Double?
    var pro_currency : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        pro_id <- map["pro_id"]
        image <- map["image"]
        pro_name <- map["pro_name"]
        pro_price <- map["pro_price"]
        pro_currency <- map["pro_currency"]
    }

}

//
//  StockData.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-048 on 20/02/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import Foundation
import ObjectMapper

class StockData : Mappable {
    var error : Bool?
    var error_code : Int?
    var error_description : String?
    var data : Data_stock?

    required init?(map: Map) {

    }

    func mapping(map: Map) {

        error <- map["error"]
        error_code <- map["error_code"]
        error_description <- map["error_description"]
        data <- map["data"]
    }

}

class Data_stock : Mappable {
    var available_qty : Int?
    var created_at : String?
    var updated_at : String?

    required init?(map: Map) {

    }

    func mapping(map: Map) {

        available_qty <- map["available_qty"]
        created_at <- map["created_at"]
        updated_at <- map["updated_at"]
    }

}
// Stock Update Model
class updateStock : Mappable {
    var error : Bool?
    var error_code : Int?
    var error_description : String?
    var data : Data_update_stock?

    required init?(map: Map) {

    }

    func mapping(map: Map) {

        error <- map["error"]
        error_code <- map["error_code"]
        error_description <- map["error_description"]
        data <- map["data"]
    }

}
class Data_update_stock : Mappable {
    var updated_qty : Int?

    required init?(map: Map) {

    }

    func mapping(map: Map) {

        updated_qty <- map["updated_qty"]
    }

}

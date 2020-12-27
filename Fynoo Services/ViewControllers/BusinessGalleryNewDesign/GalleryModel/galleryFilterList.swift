//
//  galleryFilterList.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-048 on 07/03/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import Foundation
import ObjectMapper

class galleryFilterList : Mappable {
    var error : Bool?
    var error_code : Int?
    var error_description : String?
    var data : Data_filter?

    required init?(map: Map) {

    }

    func mapping(map: Map) {

        error <- map["error"]
        error_code <- map["error_code"]
        error_description <- map["error_description"]
        data <- map["data"]
    }

}
class Data_filter : Mappable {
    var data_list : [Data_list]?

    required init?(map: Map) {

    }

    func mapping(map: Map) {

        data_list <- map["data_list"]
    }

}


class Data_list : Mappable {
    var user_id : Int?
    var name : String?
    var u_image : String?

    required init?(map: Map) {

    }

    func mapping(map: Map) {

        user_id <- map["user_id"]
        name <- map["name"]
        u_image <- map["u_image"]
    }

}

//
//  GalleryImage.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-048 on 03/03/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import Foundation
import ObjectMapper

class GalleryImage : Mappable {
    var error : Bool?
    var error_code : Int?
    var error_description : String?
    var data : Data_gall?

    required init?(map: Map) {

    }

    func mapping(map: Map) {

        error <- map["error"]
        error_code <- map["error_code"]
        error_description <- map["error_description"]
        data <- map["data"]
    }

}

class Data_gall : Mappable {
    var id : Int?
    var gall_img : String?

    required init?(map: Map) {

    }

    func mapping(map: Map) {

        id <- map["id"]
        gall_img <- map["gall_img"]
    }

}


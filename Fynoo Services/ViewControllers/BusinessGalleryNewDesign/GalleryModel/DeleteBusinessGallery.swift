//
//  DeleteBusinessGallery.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-048 on 04/03/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import Foundation
import ObjectMapper

class DeleteBusinessGallery : Mappable {
    var error : Bool?
    var error_code : Int?
    var error_description : String?
    var data : Data_delete_gallery?

    required init?(map: Map) {

    }

    func mapping(map: Map) {

        error <- map["error"]
        error_code <- map["error_code"]
        error_description <- map["error_description"]
        data <- map["data"]
    }

}
class Data_delete_gallery : Mappable {

    required init?(map: Map) {

    }

    func mapping(map: Map) {

    }

}

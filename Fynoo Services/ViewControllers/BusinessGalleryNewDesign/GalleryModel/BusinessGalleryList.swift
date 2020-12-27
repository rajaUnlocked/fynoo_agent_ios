//
//  BusinessGalleryList.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-048 on 03/03/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import Foundation
import ObjectMapper
class BusinessGalleryList : Mappable{
    var error : Bool?
    var error_code : Int?
    var error_description : String?
    var data : Data_gallery_new?

    required init?(map: Map) {

    }

    func mapping(map: Map) {

        error <- map["error"]
        error_code <- map["error_code"]
        error_description <- map["error_description"]
        data <- map["data"]
    }

}

class Data_gallery_new : Mappable {
    var gallery : [Gallery_list_new]?

    required init?(map: Map) {

    }

    func mapping(map: Map) {

        gallery <- map["gallery"]
    }

}
class Gallery_list_new : Mappable {
    var id : Int?
    var name : String = ""
    var image : String?
    var image_type : String?

    required init?(map: Map) {

    }

    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        image <- map["image"]
        image_type <- map["image_type"]
    }
}

//
//  DataBankSellingProductDetail.swift
//  Fynoo
//
//  Created by IND-SEN-LP-048 on 14/05/20.
//  Copyright © 2020 Aishwarya. All rights reserved.
//

import Foundation
import ObjectMapper
import Foundation
import ObjectMapper


struct viewProductDetailEditNew : Mappable {
    var error : Bool?
    var error_code : Int?
    var error_description : String?
    var data : Data_DetailEdit?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        error <- map["error"]
        error_code <- map["error_code"]
        error_description <- map["error_description"]
        data <- map["data"]
    }

}


 struct Data_DetailEdit : Mappable {
    var pro_id : Int?
     var pro_code:String?
    var pro_filled_step: Int?
    var pro_barcode : String?
    var pro_name : String?
    var pro_description : String?
    var pro_video_url : String?
    var pro_image : [Pro_image1]?
    var pro_parent_category_id : Int?
    var pro_parent_category_image : String?
    var pro_parent_category : String?
    var pro_sub_category_id : Int?
    var pro_sub_category_image : String?
    var pro_sub_category : String?
    var pro_specification : [Pro_specification1]?
    var pro_technical_specification : String?
    var pro_pdf : [Pro_pdf2]?
    var pro_status : Int?
    var product_status : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {
          pro_code <- map["pro_code"]
         pro_filled_step <- map["pro_filled_step"]
       pro_barcode <- map["pro_barcode"]
        pro_id <- map["pro_id"]
        pro_barcode <- map["pro_barcode"]
        pro_name <- map["pro_name"]
        pro_description <- map["pro_description"]
        pro_video_url <- map["pro_video_url"]
        pro_image <- map["pro_image"]
        pro_parent_category_id <- map["pro_parent_category_id"]
        pro_parent_category_image <- map["pro_parent_category_image"]
        pro_parent_category <- map["pro_parent_category"]
        pro_sub_category_id <- map["pro_sub_category_id"]
        pro_sub_category_image <- map["pro_sub_category_image"]
        pro_sub_category <- map["pro_sub_category"]
        pro_specification <- map["pro_specification"]
        pro_technical_specification <- map["pro_technical_specification"]
        pro_pdf <- map["pro_pdf"]
        pro_status <- map["pro_status"]
        product_status <- map["product_status"]
    }

}

 struct Pro_image1 : Mappable {
    var id : Int?
    var image : String?
    var is_featured : Bool?
    var index : Int?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["id"]
        image <- map["image"]
        is_featured <- map["is_featured"]
        index <- map["index"]
    }

}


 struct Pro_pdf2 : Mappable {
    var id : Int?
    var pdf : String?
    var type : String?
    var size: Float?
    init?(map: Map) {

    }

    mutating func mapping(map: Map) {
          size <- map["size"]
        id <- map["id"]
        pdf <- map["pdf"]
        type <- map["type"]
    }

}

struct Pro_specification1 : Mappable {
    var filter_id : Int?
    var filter_name : String?
    var filter_status : Int?
    var filter_value_id : Int?
    var filter_value_name : String?
    var filter_value_status : Int?
    var filter_variant : Bool?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        filter_id <- map["filter_id"]
        filter_name <- map["filter_name"]
        filter_status <- map["filter_status"]
        filter_value_id <- map["filter_value_id"]
        filter_value_name <- map["filter_value_name"]
        filter_value_status <- map["filter_value_status"]
        filter_variant <- map["filter_variant"]
    }

}



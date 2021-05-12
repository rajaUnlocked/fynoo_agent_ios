//
//  DataBankSellingProductDetail.swift
//  Fynoo
//
//  Created by IND-SEN-LP-048 on 14/05/20.
//  Copyright © 2020 Aishwarya. All rights reserved.
//

import Foundation
import ObjectMapper

class viewProductDetailNew : Mappable {
       var error : Bool?
       var error_code : Int?
       var error_description : String?
       var data : Data_Detail?

    required init?(map: Map) {

       }

    func mapping(map: Map) {

           error <- map["error"]
           error_code <- map["error_code"]
           error_description <- map["error_description"]
           data <- map["data"]
       }

   }
class Data_Detail : Mappable {
    var pro_id : Int?
    var pro_qr : String?
    var pro_name : String?
    var pro_description : String?
    var pro_video_url : String?
    var pro_image : [Pro_image]?
    var pro_parent_category_id : Int?
    var pro_parent_category_image : String?
    var pro_parent_category : String?
    var pro_sub_category_id : Int?
    var pro_sub_category_image : String?
    var pro_sub_category : String?
    var pro_specification : [Pro_specification]?
    var pro_technical_specification : String?
    var pro_pdf : [Pro_Pdf_Product]?
    var pro_status : Int?
    var product_status : String?
    var pro_variant : [Pro_variant]?
    var similar_product : [Similar_product]?

    required init?(map: Map) {

    }

    func mapping(map: Map) {

        pro_id <- map["pro_id"]
        pro_qr <- map["pro_qr"]
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
        pro_variant <- map["pro_variant"]
        similar_product <- map["similar_product"]
    }

}


class Pro_specification : Mappable {
    var filter_id : Int?
    var filter_name : String?
    var filter_value_id : Int?
    var filter_value_name : String?

    required init?(map: Map) {

    }

    func mapping(map: Map) {

        filter_id <- map["filter_id"]
        filter_name <- map["filter_name"]
        filter_value_id <- map["filter_value_id"]
        filter_value_name <- map["filter_value_name"]
    }

}
class Similar_product : Mappable {
    var pro_id : Int?
    var image : String?
    var pro_name : String?
    var pro_price : Double?
    var pro_currency : String?

    
    required init?(map: Map) {

    }

    func mapping(map: Map) {

        pro_id <- map["pro_id"]
        image <- map["image"]
        pro_name <- map["pro_name"]
        pro_price <- map["pro_price"]
        pro_currency <- map["pro_currency"]
    }

}

class Pro_variant : Mappable {
     var  filter_icon : String?
    var filter_id : Int?
    var filter : String?
    var filter_value : String?
    required init?(map: Map) {

    }

    func mapping(map: Map) {

        filter_icon <- map["filter_icon"]
        filter_id <- map["filter_id"]
        filter <- map["filter"]
        filter_value <- map["filter_value"]
    }

}
class Pro_Pdf_Product : Mappable {
   var id : Int?
     var pdf : String?
     var type : String?

    required init?(map: Map) {

    }

    func mapping(map: Map) {

        id <- map["id"]
        pdf <- map["pdf"]
        type <- map["type"]
      
    }

}


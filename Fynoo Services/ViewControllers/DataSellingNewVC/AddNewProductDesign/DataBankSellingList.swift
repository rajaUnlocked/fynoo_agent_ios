//
//  DataBankSellingList.swift
//  Fynoo
//
//  Created by IND-SEN-LP-048 on 12/05/20.
//  Copyright © 2020 Aishwarya. All rights reserved.
//

import Foundation
import ObjectMapper

struct DataBankSellingList : Mappable {
    var error : Bool?
    var error_code : Int?
    var error_description : String?
    var data : Data_DataBankSelling?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        error <- map["error"]
        error_code <- map["error_code"]
        error_description <- map["error_description"]
        data <- map["data"]
    }

}
 struct Data_DataBankSelling : Mappable {
     var page_limit : Int?
     var total_draft : Int?
     var total_records : Int?
    var total_sold : Int?
    var total_earning : Int?
    var product_list : [Product_list_data_Bank_Selling]?
    var filters : [Filterssell]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {
        page_limit <- map["page_limit"]
        total_records <- map["total_records"]
        total_draft <- map["total_draft"]
        total_sold <- map["total_sold"]
        total_earning <- map["total_earning"]
        product_list <- map["product_list"]
        filters <- map["filters"]
    }

}

struct Product_list_data_Bank_Selling : Mappable {
    var pro_id : Int?
    var pro_name : String?
    var pro_image : String?
    var pro_category : String?
    var pro_sub_category : String?
    var pro_language : String?
    var pro_photo : Int?
    var pro_sale_price : String?
    var pro_currency_code : String?
    var pro_purchase : Int?
    var pro_added_at : String?
    var pro_added_at_timestamp : Int?
    var pro_status_value : String?
    var pro_status : Int?
    var pro_reject_desc : String?
    var pro_expiry_at : String?
    var is_variant_available : Bool?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        pro_id <- map["pro_id"]
        pro_name <- map["pro_name"]
        pro_image <- map["pro_image"]
        pro_category <- map["pro_category"]
        pro_sub_category <- map["pro_sub_category"]
        pro_language <- map["pro_language"]
        pro_photo <- map["pro_photo"]
        pro_sale_price <- map["pro_sale_price"]
        pro_currency_code <- map["pro_currency_code"]
        pro_purchase <- map["pro_purchase"]
        pro_added_at <- map["pro_added_at"]
        pro_added_at_timestamp <- map["pro_added_at_timestamp"]
        pro_status_value <- map["pro_status_value"]
        pro_status <- map["pro_status"]
        pro_reject_desc <- map["pro_reject_desc"]
        pro_expiry_at <- map["pro_expiry_at"]
        is_variant_available <- map["is_variant_available"]
    }

}
struct Filterssell : Mappable {
    var filter_id : Int?
    var filter_code : String?
    var filter_name : String?
    var filter_description : String?
    var radio_list : [Radio_list]?
    var complex_radio_list : [Complex_Radio_list]?
    var checkbox_item : [Checkbox_item]?
    var range_list : String?
    var view_type : String?
    var is_selected :Bool?
    init?(map: Map) {

    }

    mutating func mapping(map: Map) {
         is_selected <- map["is_selected"]
        filter_id <- map["filter_id"]
        filter_code <- map["filter_code"]
        filter_name <- map["filter_name"]
        filter_description <- map["filter_description"]
        radio_list <- map["radio_list"]
        complex_radio_list <- map["complex_radio_list"]
        checkbox_item <- map["checkbox_item"]
        range_list <- map["range_list"]
        view_type <- map["view_type"]
    }

}
struct Checkbox_item : Mappable {
    var key : String?
    var value : Double?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        key <- map["key"]
        value <- map["value"]
    }

}
struct Radio_list : Mappable {
    var key : String?
    var value : Int?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        key <- map["key"]
        value <- map["value"]
    }

}
struct Complex_Radio_list : Mappable {
    var key : String?
    var value : Int?
    var value_list : [ComplexRadio]?
    init?(map: Map) {

    }

    mutating func mapping(map: Map) {
           value_list <- map["value_list"]
        key <- map["key"]
        value <- map["value"]
    }

}
struct ComplexRadio : Mappable {
    var key : String?
    var value : Int?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        key <- map["key"]
        value <- map["value"]
    }

}

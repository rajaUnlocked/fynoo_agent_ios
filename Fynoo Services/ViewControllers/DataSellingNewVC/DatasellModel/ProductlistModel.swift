//
//  ProductlistModel.swift
//  Fynoo
//
//  Created by IND-SEN-LP-039 on 12/05/20.
//  Copyright © 2020 Aishwarya. All rights reserved.
//

import Foundation
import ObjectMapper

struct ProductlistModel : Mappable {
    var error : Bool?
    var error_code : Int?
    var error_description : String?
    var data : ProductlistModelData?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        error <- map["error"]
        error_code <- map["error_code"]
        error_description <- map["error_description"]
        data <- map["data"]
    }

}
struct ProductlistModelData : Mappable {
    var per_page : Int?
    var total_product : Int?
    var multiple_banner : [Multiple_banner]?
    var single_banner : [Single_banner]?
    var cat_list : [Cata_list]?
    var brand_list : [Brand_list]?
    var deals_product : Int?
    var product_list : [Product_lists]?
    var cart_count:Int?
    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

          cart_count <- map["cart_count"]
        per_page <- map["per_page"]
        total_product <- map["total_product"]
        multiple_banner <- map["multiple_banner"]
        single_banner <- map["single_banner"]
        cat_list <- map["cat_list"]
        brand_list <- map["brand_list"]
        deals_product <- map["deals_product"]
        product_list <- map["product_list"]
    }

}
struct Single_banner : Mappable {
    var banner_image : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        banner_image <- map["banner_image"]
    }

}
struct Multiple_banner : Mappable {
    var banner_image : String?
    var banner_image_type : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        banner_image <- map["banner_image"]
        banner_image_type <- map["banner_image_type"]
    }

}
struct Cata_list : Mappable {
    var cat_id : Int?
      var cat_name : String?
      var cat_desc : String?
      var cat_img : String?
      var cat_f_img : Bool?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        cat_id <- map["cat_id"]
         cat_name <- map["cat_name"]
         cat_desc <- map["cat_desc"]
         cat_img <- map["cat_img"]
         cat_f_img <- map["cat_f_img"]
    }

}
struct Brand_list : Mappable {
    var brand_id : Int?
      var brand_logo : String?
      var brand_name : String?
      

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        brand_id <- map["brand_id"]
         brand_logo <- map["brand_logo"]
         brand_name <- map["brand_name"]
        
    }

}
struct Product_lists : Mappable {
        var single_banner : String?
        var view_type: Int?
         var branch_name : String?
    var branch_image : String?
         var product_list : [product_list1]?
    init?(map: Map) {

    }

    mutating func mapping(map: Map) {
       single_banner <- map["single_banner"]
        view_type <- map["view_type"]
         branch_image <- map["branch_image"]
         branch_name <- map["branch_name"]
         product_list <- map["product_list"]
        
    }

}
struct product_list1 : Mappable {
      var instore_branch_available :Bool?
    var bo_id :Int?
    var pro_id : Int?
    var is_special :Bool?
     var is_favrt :Int?
      var image : String?
      var pro_name : String?
       var pro_main_price : String?
     var pro_cut_price : String?
     var pro_dis_perc : String?
 var pro_vat_perc : String?
     var pro_currency_code : String?
     var pro_avg_rating : Float?
      var pro_raters : String?
      var pro_online_available : Bool?
      var pro_store_available : Bool?
    var min_price_at : String?
    init?(map: Map) {

    }

    mutating func mapping(map: Map) {
          instore_branch_available <- map["instore_branch_available"]
         bo_id <- map["bo_id"]
        pro_id <- map["pro_id"]
         is_special <- map["is_special"]
         is_favrt <- map["is_favrt"]
        image <- map["image"]
        pro_name <- map["pro_name"]
        pro_main_price <- map["pro_main_price"]
        pro_cut_price <- map["pro_cut_price"]
         pro_dis_perc <- map["pro_dis_perc"]
         pro_cut_price <- map["pro_cut_price"]
        
         pro_vat_perc <- map["pro_vat_perc"]
         pro_currency_code <- map["pro_currency_code"]
         pro_avg_rating <- map["pro_avg_rating"]
         pro_raters <- map["pro_raters"]
          pro_online_available <- map["pro_online_available"]
        pro_store_available <- map["pro_store_available"]
        min_price_at <- map["min_price_at"]
        
        
    }

}

              
              
              
             
            

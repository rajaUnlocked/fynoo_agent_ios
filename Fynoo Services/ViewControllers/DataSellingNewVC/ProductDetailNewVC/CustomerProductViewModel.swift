//
//  CustomerProductViewModel.swift
//  Fynoo
//
//  Created by IND-SEN-LP-048 on 16/05/20.
//  Copyright © 2020 Aishwarya. All rights reserved.
//

import Foundation
struct viewCustomerProductDetailNew : Decodable {
let error : Bool?
let error_code : Int?
let error_description : String?
    var data : Data_cus?
}
struct Data_cus : Decodable{
    
    let pro_web_share_url : String?
    let pro_sub_cat : Int?
    var pro_cat : Int?
    let pro_id : Int?
    var bo_id : Int?
    let pro_code : String?
    let pro_name : String?
    let pro_barcode_val : String?
    let pro_currency_code : String?
    let pro_description : String?
    let pro_qr_code : String?
    let is_drop_shipping : Int?
    let is_liked : Int?
    let pro_video_url : String?
    let pro_image : [Pro_image_Customer]?
    let pro_online_store : Bool?
    let pro_in_store : Bool?
    let pro_branch_availability : Bool?
    let retail_available : Bool?
    let wholesale_available : Bool?
    let retail : Retail?
    let wholesale : Wholesale?
    let pro_stock : String?
    let delivery_days : String?
    let payment_mode : String?
    let delivery_option : String?
    let min_price_tag : Int?
    let pro_variant : [viewPro_variant]?
    let pro_specification : [Pro_specification_Customer]?
    let pro_technical_specification : String?
    let pro_pdf : [ViewPro_pdf]?
    let pro_warranty_section : String?
    let pro_avg_rating : Double?
    let pro_total_rating : String?
    let pro_follower : Int?
    let pro_likes : String?
    let pro_likes_count : String?
    let pro_likes_list : [Pro_likes_list]?
    var similar_product : [Similar_product_Customer]?
    let avg_rating : String?
    let total_ratings : String?
    let total_reviews : String?
    let one_star_rating : String?
    let second_star_rating : String?
    let third_star_rating : String?
    let fourth_star_rating : String?
    let fifth_star_rating : String?
    let one_star_rating_per : Int?
    let second_star_rating_per : Int?
    let third_star_rating_per : Int?
    let fourth_star_rating_per : Int?
    let fifth_star_rating_per : Int?
    let review_list : [Review_list_Customer]?
    let show_map : Int?
    let is_return : Int?
    
}
struct Pro_image_Customer : Decodable {
let id : Int?
let image : String?
let is_featured : Bool?
}
struct Pro_likes_list : Decodable {
let customer_id : Int?
let customer_pic : String?
}
struct Pro_specification_Customer : Decodable {
let filter_name : String?
let filter_value_name : String?
}
struct Retail : Codable {
let retail_main_price : String?
let retail_cut_price : String?
let retail_save_price : String?
let retail_perc_off : String?
let retail_vat : String?
let retail_min_order : String?
let retail_discount_time : String?
}
struct Review_list_Customer : Decodable {
let review_id : Int?
let rating : Int?
let title : String?
let comment : String?
let user_id : Int?
let user_name : String?
let updated_at : String?
let review_img : [Review_img]?
let comment_likes : String?
let comment_dislikes : String?

}
struct Similar_product_Customer : Decodable {
let pro_branch_availability : Bool?
let pro_id : Int?
let is_special : Int?
var is_favrt : Int?
let image : String?
let pro_name : String?
let pro_main_price : String?
let pro_cut_price : String?
let pro_dis_perc : String?
let pro_vat_perc : String?
let pro_currency_code : String?
let pro_avg_rating : Double?
let pro_raters : String?
let min_price_at : String?
let pro_online : Bool?
let pro_store : Bool?

}
struct Wholesale : Decodable {
let wholesale_main_price : String?
let wholesale_cut_price : String?
let wholesale_save_price : String?
let wholesale_perc_off : String?
let wholesale_vat : String?
let wholesale_min_order : String?
}

struct ViewPro_pdf : Decodable {
let id : Int?
let pdf : String?
let type : String?

}
struct viewPro_variant : Decodable {
let filter_icon : String?
let filter_id : Int?
let filter : String?
let filter_value : String?
}
struct Review_img : Decodable {
    
    let image : String?
    let media : String?
    let video_thumbnail : String?
    let type : String?

}

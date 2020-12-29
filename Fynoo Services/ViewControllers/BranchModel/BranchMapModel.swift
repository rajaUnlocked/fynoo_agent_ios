//
//  BranchMapModel.swift
//  Fynoo Services
//
//  Created by IND-SEN-LP-039 on 01/12/20.
//  Copyright © 2020 Aishwarya. All rights reserved.
//

import Foundation
import ObjectMapper

struct PlatFormType : Mappable {
    var error : Bool?
    var error_code : Int?
    var error_description : String?
    var data : PlatFormTypeData?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        error <- map["error"]
        error_code <- map["error_code"]
        error_description <- map["error_description"]
        data <- map["data"]
    }

}
struct PlatFormTypeData : Mappable {
    var platform_type : [Platform_type]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        platform_type <- map["platform_type"]
    }

}
struct Platform_type : Mappable {
    var id : Int?
    var code : String?
    var value : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["id"]
        code <- map["code"]
        value <- map["value"]
    }

}

//display type

struct DisplayType : Mappable {
    var error : Bool?
    var error_code : Int?
    var error_description : String?
    var data : DisplayTypeData?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        error <- map["error"]
        error_code <- map["error_code"]
        error_description <- map["error_description"]
        data <- map["data"]
    }

}
struct DisplayTypeData : Mappable {
    var time_display_type : [Time_display_type]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        time_display_type <- map["time_display_type"]
    }

}

struct Time_display_type : Mappable {
    var id : Int?
    var code : String?
    var value : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["id"]
        code <- map["code"]
        value <- map["value"]
    }

}

// show image list

struct ShowImageList : Mappable {
    var error : Bool?
    var error_code : Int?
    var error_description : String?
    var data : ShowImageListData?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        error <- map["error"]
        error_code <- map["error_code"]
        error_description <- map["error_description"]
        data <- map["data"]
    }

}
struct ShowImageListData : Mappable {
    var images_list : [Images_list]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        images_list <- map["images_list"]
    }

}
struct Images_list : Mappable {
    var id : Int?
    var image : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["id"]
        image <- map["image"]
    }

}
//upload branch logo
struct UploadBranchLogo : Mappable {
    var error : Bool?
    var error_code : Int?
    var error_description : String?
    var data : UploadBranchLogoData?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        error <- map["error"]
        error_code <- map["error_code"]
        error_description <- map["error_description"]
        data <- map["data"]
    }

}
struct UploadBranchLogoData : Mappable {
    var id : Int?
    var logo_url : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["id"]
        logo_url <- map["logo_url"]
    }

}

// branch detail list
struct BranchDetailList : Mappable {
    var error : Bool?
    var error_code : Int?
    var error_description : String?
    var data : BranchDetailListData?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        error <- map["error"]
        error_code <- map["error_code"]
        error_description <- map["error_description"]
        data <- map["data"]
    }

}

struct BranchDetailListData : Mappable {
    var branch_id : Int?
    var branch_name : String?
    var email : String?
    var mobile_code : String?
    var mobile_number : String?
    var phone_code : String?
    var phone_number : String?
    var whats_app_mob_code : String?
    var whats_app_number : String?
    var description : String?
    var store_time_display : String?
    var is_store_open : Bool?
    var total_followers : Int?
    var country : String?
    var city : String?
    var state : String?
    var area : String?
    var zipcode : String?
    var address : String?
    var markets_notes : String?
    var time_display_style:Int?
    var branch_logo:Int?
    var lat : String?
    var long : String?
    var facebook : String?
    var twitter : String?
    var instagram : String?
    var linkedin : String?
    var youtube : String?
    var created_on : String?
    var created_by : String?
    var updated_at : String?
    var updated_by : String?
    var branch_image : String?
    var qr_code : String?
    var avg_rating : Double?
    var is_main_branch : Int?
    var is_branch_active : Int?
    var mall_market_id : String?
    var review_count : Int?
    var distance : Double?
    var total_products : Int?
    var product_data : [String]?
    var branch_timings_id : Int?
    var timings : [Timings]?
    var address_type : Address_type?
    var market_name : Market_name?
    var business_type : [Business_types]?
    var branch_platform : [Branch_platform]?
    var interior_img : [Interior_imgs]?
    var exterior_img : [Exterior_imgs]?
    var videos : String?
    var videos_thumb : String?
    var category_list : [Category_list]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {
        branch_logo <- map["branch_logo"]
        branch_id <- map["branch_id"]
        branch_name <- map["branch_name"]
        email <- map["email"]
        mobile_code <- map["mobile_code"]
        mobile_number <- map["mobile_number"]
        phone_code <- map["phone_code"]
        phone_number <- map["phone_number"]
        whats_app_mob_code <- map["whats_app_mob_code"]
        whats_app_number <- map["whats_app_number"]
        description <- map["description"]
        store_time_display <- map["store_time_display"]
        is_store_open <- map["is_store_open"]
        total_followers <- map["total_followers"]
        country <- map["country"]
        city <- map["city"]
        state <- map["state"]
        area <- map["area"]
        time_display_style <- map["time_display_style"]
        zipcode <- map["zipcode"]
        address <- map["address"]
        markets_notes <- map["markets_notes"]
        lat <- map["lat"]
        long <- map["long"]
        facebook <- map["facebook"]
        twitter <- map["twitter"]
        instagram <- map["instagram"]
        linkedin <- map["linkedin"]
        youtube <- map["youtube"]
        created_on <- map["created_on"]
        created_by <- map["created_by"]
        updated_at <- map["updated_at"]
        updated_by <- map["updated_by"]
        branch_image <- map["branch_image"]
        qr_code <- map["qr_code"]
        avg_rating <- map["avg_rating"]
        is_main_branch <- map["is_main_branch"]
        is_branch_active <- map["is_branch_active"]
        mall_market_id <- map["mall_market_id"]
        review_count <- map["review_count"]
        distance <- map["distance"]
        total_products <- map["total_products"]
        product_data <- map["product_data"]
        branch_timings_id <- map["branch_timings_id"]
        timings <- map["timings"]
        address_type <- map["address_type"]
        market_name <- map["market_name"]
        business_type <- map["business_type"]
        branch_platform <- map["branch_platform"]
        interior_img <- map["interior_img"]
        exterior_img <- map["exterior_img"]
        videos <- map["videos"]
        videos_thumb <- map["videos_thumb"]
        category_list <- map["category_list"]
    }

}
struct Timings : Mappable {
    var dayName : String?
    var is24Open : Bool?
    var isClose : Bool?
    var slotArrayList : [SlotArrayList2]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        dayName <- map["dayName"]
        is24Open <- map["is24Open"]
        isClose <- map["isClose"]
        slotArrayList <- map["slotArrayList"]
    }
}

struct Address_type : Mappable {
    var id : Int?
    var address_type_name : String?
    var address_type_name_ar : String?
    var created_at : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["id"]
        address_type_name <- map["address_type_name"]
        address_type_name_ar <- map["address_type_name_ar"]
        created_at <- map["created_at"]
    }

}
struct Market_name : Mappable {
    var mall_market_id : Int?
    var market_name : String?
    var address_type_id : Int?
    var address_type_name : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        mall_market_id <- map["mall_market_id"]
        market_name <- map["market_name"]
        address_type_id <- map["address_type_id"]
        address_type_name <- map["address_type_name"]
    }

}

struct Business_types : Mappable {
    var id : Int?
    var name : String?
    var description : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["id"]
        name <- map["name"]
        description <- map["description"]
    }

}
struct Branch_platform : Mappable {
    var id : Int?
    var platform : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["id"]
        platform <- map["platform"]
    }

}
struct Interior_imgs : Mappable {
    var image_id : Int?
    var image_name : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        image_id <- map["image_id"]
        image_name <- map["image_name"]
    }

}
struct Exterior_imgs : Mappable {
    var image_id : Int?
    var image_name : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        image_id <- map["image_id"]
        image_name <- map["image_name"]
    }

}
struct Category_list : Mappable {
    var id : String?
    var category_image : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["id"]
        category_image <- map["category_image"]
    }

}
struct SlotArrayList2 : Mappable {
    var time_slot : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        time_slot <- map["time_slot"]
    }

}

// description list

struct DescriptionValueList : Mappable {
    var error : Bool?
    var error_code : Int?
    var error_description : String?
    var data : DescriptionValueListData?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        error <- map["error"]
        error_code <- map["error_code"]
        error_description <- map["error_description"]
        data <- map["data"]
    }

}
struct DescriptionValueListData : Mappable {
    var br_limit_list : [br_limit_list]?
    var branch_img_limit:Int?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        br_limit_list <- map["br_limit_list"]
         branch_img_limit <- map["branch_img_limit"]
    }

}
struct br_limit_list : Mappable {
    var id : Int?
    var code : String?
    var description : String?
    var value : Int?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["id"]
        code <- map["code"]
        description <- map["description"]
        value <- map["value"]
    }

}

// uploadfynoo gallery

struct FynooGalleryUpload : Mappable {
    var error : Bool?
    var error_code : Int?
    var error_description : String?
    var data : FynooGalleryUploadData?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        error <- map["error"]
        error_code <- map["error_code"]
        error_description <- map["error_description"]
        data <- map["data"]
    }

}
struct FynooGalleryUploadData : Mappable {
    var gallery_imgs : [Gallery_imgs]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        gallery_imgs <- map["gallery_imgs"]
    }

}
struct Gallery_imgs : Mappable {
    var image_id : Int?
    var image_url : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        image_id <- map["image_id"]
        image_url <- map["image_url"]
    }

}

// BRANCH DETAILS

struct BranchDetail:Decodable {
    let error : Bool?
    let error_code : Int?
    let error_description : String?
    let data : Data1?

}
struct Data1:Decodable
{
    let qr_code:String?
let branch_id : Int?
let branch_name : String?
let email : String?
let mobile_code : String?
let mobile_number : String?
let phone_number : String?
let phone_code : String?
let description : String?
let maroof_link : String?
let branch_image : String?
let country : String?
let city : String?
let state : String?
let area : String?
let zipcode : String?
let address : String?
let markets_notes : String?
    let total_followers : Int?
    let is_followed : Bool?
let lat : String?
let long : String?
let facebook : String?
let twitter : String?
let instagram : String?
let linkedin : String?
let youtube : String?
let created_on : String?
let created_by : String?
let updated_at : String?
let updated_by : String?
let user_type : String?
let is_main_branch : String?
let is_branch_active : String?
let total_products : Int?
    let avg_rating:Double?
let review_count : Int?
let product_data : [product_data]?
let branch_timings_id : Int?
let timings : [Timingss]?
let address_type : address_type?
let market_name : market_name?
let business_type : [business_type]?
let interior_img : [Interior_img]?
let exterior_img : [Exterior_img]?
let videos : [Video_img]?
}
struct business_type:Decodable {
    let id:Int?
    let name:String?
    let description:String?
}
struct Timingss:Decodable {
    let dayName:String?
    let is24Open:Bool?
    let isClosed:Bool?
    let slotArrayList : [SlotArrayLists]?

}

struct SlotArrayLists:Decodable {
let time_slot : String?
}
 
struct Interior_img:Decodable {
   let image_id : Int
    let image_name : String?
}
struct Exterior_img:Decodable {
    let image_id : Int
    let image_name : String?
}
struct Video_img:Decodable {
    let image_id : Int
    let image_name : String?
    let thumbnail :String?
}
struct address_type:Decodable {
     let id : Int?
     let address_type_name : String?
     let address_type_name_ar : String?
     let created_at : String?
}
struct market_name:Decodable {
    let mall_market_id : Int?
    let market_name : String?
    let address_type_id : Int?
    let address_type_name : String?
}
struct product_data:Decodable {
    let id : Int?
    let pro_parent_varient_id : String?
    let pro_bo_id : Int?
    let pro_bo_name : String?
    let pro_code : String?
    let pro_name : String?
    let pro_bo_branch_id : Int?
    let pro_bo_branch_name : String?
    let pro_description : String?
    let pro_currency_id : Int?
    let pro_barcode : String?
    let pro_barcode_val : String?
    let pro_online : Bool?
    let pro_online_retail : Bool?
    let pro_online_retail_price : Double?
    let pro_online_retail_dis_price : Double?
    let pro_online_retail_net_sell_price : Double?
    let pro_online_retail_vat : Double?
    let pro_online_retail_final_price : Double?
    let pro_online_retail_max_qty : String?
    let pro_delivery_retail_charge : String?
    let pro_online_wholesale : Bool?
    let pro_online_wholesale_price : String?
    let pro_online_wholesale_dis_price : String?
    let pro_online_wholesale_net_sell_price : String?
    let pro_online_wholesale_vat : String?
    let pro_online_wholesale_final_price : String?
    let pro_online_wholesale_min_qty : String?
    let pro_online_retail_return : Bool?
    let pro_online_retail_return_days : Int?
    let pro_online_retail_exchange : Bool?
    let pro_online_retail_exchange_days : Int?
    let pro_online_wholesale_return : Bool?
    let pro_online_wholesale_return_days : Int?
    let pro_online_wholesale_exchange : Bool?
    let pro_online_wholesale_exchange_days : Int?
    let pro_store : Bool?
    let pro_store_retail : Bool?
    let pro_store_retail_price : String?
    let pro_store_retail_dis_price : String?
    let pro_store_retail_net_sell_price : String?
    let pro_store_retail_vat : String?
    let pro_store_retail_final_price : String?
    let pro_store_wholesale : Bool?
    let pro_store_wholesale_price : String?
    let pro_store_wholesale_dis_price : String?
    let pro_store_wholesale_net_sell_price : String?
    let pro_store_wholesale_vat : String?
    let pro_store_wholesale_final_price : String?
    let pro_store_retail_return : Bool?
    let pro_store_retail_return_days : Int?
    let pro_store_retail_exchange : Bool?
    let pro_store_retail_exchange_days : Int?
    let pro_store_wholesale_return : Bool?
    let pro_store_wholesale_return_days : Int?
    let pro_store_wholesale_exchange : Bool?
    let pro_store_wholesale_exchange_days : Int?
    let pro_delivery_days : Int?
    let pro_cod_payment : Bool?
    let pro_online_payment : Bool?
    let pro_stock : Int?
    let pro_parent_cat_id : Int?
    let pro_sub_cat_id : Int?
    let pro_technical_specification : String?
    let pro_status : Int?
    let pro_data_sell_price : String?
    let pro_data_cbf_percentage : String?
    let pro_data_dropshipping_percentage : String?
    let pro_user_type : String?
    let pro_created_at : String?
    let pro_created_by : Int?
    let pro_updated_at : String?
    let pro_updated_by : String?
    let pro_delivery_retail_same : Bool?
    let pro_delivery_retail_per_product : Bool?
    let is_display : Int?
}

//address list

struct AddressTypeList:Decodable {
    let error : Bool?
    let error_code : Int?
    let error_description : String?
    let address_type_list : [Address_type_list]?
}
struct Address_type_list:Decodable {
    let id : Int?
    let address_type_name : String?

}


//
//  ProductModels.swift
//  Fynoo Services
//
//  Created by IND-SEN-LP-039 on 01/12/20.
//  Copyright © 2020 Aishwarya. All rights reserved.
//

import Foundation
import ObjectMapper
struct ProductLimit : Mappable {
    var error : Bool?
    var error_code : Int?
    var error_description : String?
    var data : ProductLimitData?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        error <- map["error"]
        error_code <- map["error_code"]
        error_description <- map["error_description"]
        data <- map["data"]
    }

}
struct ProductLimitData : Mappable {
    var br_limit_list : [Br_limit_list]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        br_limit_list <- map["br_limit_list"]
    }

}
struct Br_limit_list : Mappable {
    var code : String?
    var description : String?
    var value : Int?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        code <- map["code"]
        description <- map["description"]
        value <- map["value"]
    }

}

//currency list

class CurrencyLIST : Mappable{
    
    
    var error = ""
    var error_code  = ""
    var error_description = ""
    var data : CurrencyLISTData?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        
        error <- map["error"]
        error_code <- map["error_code"]
        error_description <- map["error_description"]
        data <- map["data"]
    }
    
}

class CurrencyLISTData : Mappable {
    var currency_list = [currency_lists]()
   
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        
        currency_list <- map["currency_list"]
       
    }
    
}
class currency_lists : Mappable {
    var id = 0
     var currency = ""
     var currency_code = ""
   
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        
        id <- map["id"]
         currency <- map["currency"]
         currency_code <- map["currency_code"]
        
    }
    
}


// edit product

struct EditProductnew : Mappable {
    var error : Bool?
    var error_code : Int?
    var error_description : String?
    var data : EditProductnewData?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        error <- map["error"]
        error_code <- map["error_code"]
        error_description <- map["error_description"]
        data <- map["data"]
    }

}
struct EditProductnewData : Mappable {
    var product_id : Int?
    var pro_code : String?
    var pro_barcode : String?
    var pro_currency_id : Int?
    var pro_currency_name : String?
    var pro_name : String?
    var pro_no_of_branch : Int?
    var pro_description : String?
    var pro_featured_image : String?
    var pro_qr : String?
    var pro_status : Int?
    var pro_final_status : Int?
    var product_status : String?
    var pro_pdf : [Pro_pdf1]?
    init?(map: Map) {

    }

    mutating func mapping(map: Map) {
       pro_pdf <- map["pro_pdf"]
        product_id <- map["product_id"]
        pro_code <- map["pro_code"]
        pro_barcode <- map["pro_barcode"]
        pro_currency_id <- map["pro_currency_id"]
        pro_currency_name <- map["pro_currency_name"]
        pro_name <- map["pro_name"]
        pro_no_of_branch <- map["pro_no_of_branch"]
        pro_description <- map["pro_description"]
        pro_featured_image <- map["pro_featured_image"]
        pro_qr <- map["pro_qr"]
        pro_status <- map["pro_status"]
        pro_final_status <- map["pro_final_status"]
        product_status <- map["product_status"]
    }

}
struct Pro_pdf1 : Mappable {
    var id : Int?
    var pdf : String?
    var size : Double?
    init?(map: Map) {

    }

    mutating func mapping(map: Map) {
        size <- map["size"]
        id <- map["id"]
        pdf <- map["pdf"]
    }

}

// barcode

struct CheckBarCode : Mappable {
    var error : Bool?
    var error_code : Int?
    var error_description : String?
    var data : CheckBarCodeData?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        error <- map["error"]
        error_code <- map["error_code"]
        error_description <- map["error_description"]
        data <- map["data"]
    }

}
struct CheckBarCodeData : Mappable {
    var status_val : Int?
    var status_description : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        status_val <- map["status_val"]
        status_description <- map["status_description"]
    }

}

// product detaills
struct ProductDetailNew : Mappable {
     var error : Bool?
        var error_code : Int?
        var error_description : String?
        var data : ProductDetailNewdata?

        init?(map: Map) {

        }

        mutating func mapping(map: Map) {

            error <- map["error"]
            error_code <- map["error_code"]
            error_description <- map["error_description"]
            data <- map["data"]
        }
    }

    struct ProductDetailNewdata : Mappable {
        var product_details : Product_detailsnew?

        init?(map: Map) {

        }

        mutating func mapping(map: Map) {

            product_details <- map["product_details"]
        }

    }
    struct Product_detailsnew : Mappable {
        var pro_id : Int?
        var pro_code : String?
        var pro_name : String?
        var pro_barcode_val : String?
        var pro_currency_id : Int?
        var pro_currency_code : String?
        var pro_description : String?
        var pro_video_url : String?
        var pro_image : [Pro_image]?
        var pro_no_of_branch : Int?
        var pro_branch : [Pro_branch]?
        var online_payment_mode : Online_payment_mode?
        var pro_delivery_days : Int?
        var pro_online_retail_return_days : Int?
        var pro_online_wholesale_return_days : Int?
        var pro_online : Bool?
        var pro_online_retail : Bool?
        var pro_online_retail_price : Double?
        var pro_online_retail_dis_price : Double?
        var pro_online_retail_dis_percentage : Double?
        var pro_online_retail_net_sell_price : Double?
        var pro_online_retail_vat : Double?
        var pro_online_retail_vat_percentage : Double?
        var pro_online_retail_final_price : Double?
        var pro_online_retail_min_qty : Int?
        var pro_online_retail_max_qty : Int?
        var pro_online_wholesale : Bool?
        var online_wholesale_mapping : [Online_wholesale_mapping]?
        var pro_store : Bool?
        var pro_store_retail : Bool?
        var pro_store_retail_price : Double?
        var pro_store_retail_dis_price : Double?
        var pro_store_retail_dis_percentage : Double?
        var pro_store_retail_net_sell_price : Double?
        var pro_store_retail_vat : Double?
        var pro_store_retail_vat_percentage : Double?
        var pro_store_retail_final_price : Double?
        var pro_store_retail_min_qty : Int?
        var pro_store_retail_max_qty : Int?
        var pro_store_retail_return_days : Int?
        var pro_store_wholesale : Bool?
          var pro_final_status : Int?
          var status : String?
        var pro_status : Int?
        var pro_store_wholesale_price : Double?
        var pro_store_wholesale_dis_price : Double?
        var pro_store_wholesale_dis_percentage : Double?
        var pro_store_wholesale_net_sell_price : Double?
        var pro_store_wholesale_vat : Double?
        var pro_store_wholesale_vat_percentage : Double?
        var pro_store_wholesale_final_price : Double?
        var pro_store_wholesale_min_qty : Int?
        var pro_store_wholesale_max_qty : Int?
        var pro_store_wholesale_return_days : Int?
        var store_payment_mode : Store_payment_mode?
        var pro_parent_cat_id : Int?
        var pro_parent_cat_name : String?
        var pro_sub_cat_id : Int?
        var pro_sub_cat_name : String?
        var pro_parent_cat_image:String?
        var pro_sub_cat_image: String?
        var pro_filter : [Pro_filter]?
        var pro_weight : Double?
        var pro_length : Double?
        var pro_width : Double?
        var pro_height : Double?
        var pro_dimension : Double?
        var pro_technical_specification : String?
        var pro_pdf : [Pro_pdf]?
        var pro_warranty_section : String?
        var pro_stock : Int?
        var pro_filled_step : Int?
        var store_payment_list:[Store_payment_list]?
        var pro_reference_id : String?
        init?(map: Map) {

        }

        mutating func mapping(map: Map) {
             pro_status <- map["pro_status"]
            pro_reference_id <- map["pro_reference_id"]
            store_payment_list <- map["store_payment_list"]
             pro_filled_step <- map["pro_filled_step"]
             pro_final_status <- map["pro_final_status"]
             status <- map["status"]
             pro_parent_cat_image <- map["pro_parent_cat_image"]
             pro_sub_cat_image <- map["pro_sub_cat_image"]
            pro_id <- map["pro_id"]
            pro_code <- map["pro_code"]
            pro_name <- map["pro_name"]
            pro_barcode_val <- map["pro_barcode_val"]
            pro_currency_id <- map["pro_currency_id"]
            pro_currency_code <- map["pro_currency_code"]
            pro_description <- map["pro_description"]
            pro_video_url <- map["pro_video_url"]
            pro_image <- map["pro_image"]
            pro_no_of_branch <- map["pro_no_of_branch"]
            pro_branch <- map["pro_branch"]
            online_payment_mode <- map["online_payment_mode"]
            pro_delivery_days <- map["pro_delivery_days"]
            pro_online_retail_return_days <- map["pro_online_retail_return_days"]
            pro_online_wholesale_return_days <- map["pro_online_wholesale_return_days"]
            pro_online <- map["pro_online"]
            pro_online_retail <- map["pro_online_retail"]
            pro_online_retail_price <- map["pro_online_retail_price"]
            pro_online_retail_dis_price <- map["pro_online_retail_dis_price"]
            pro_online_retail_dis_percentage <- map["pro_online_retail_dis_percentage"]
            pro_online_retail_net_sell_price <- map["pro_online_retail_net_sell_price"]
            pro_online_retail_vat <- map["pro_online_retail_vat"]
            pro_online_retail_vat_percentage <- map["pro_online_retail_vat_percentage"]
            pro_online_retail_final_price <- map["pro_online_retail_final_price"]
            pro_online_retail_min_qty <- map["pro_online_retail_min_qty"]
            pro_online_retail_max_qty <- map["pro_online_retail_max_qty"]
            pro_online_wholesale <- map["pro_online_wholesale"]
            online_wholesale_mapping <- map["online_wholesale_mapping"]
            pro_store <- map["pro_store"]
            pro_store_retail <- map["pro_store_retail"]
            pro_store_retail_price <- map["pro_store_retail_price"]
            pro_store_retail_dis_price <- map["pro_store_retail_dis_price"]
            pro_store_retail_dis_percentage <- map["pro_store_retail_dis_percentage"]
            pro_store_retail_net_sell_price <- map["pro_store_retail_net_sell_price"]
            pro_store_retail_vat <- map["pro_store_retail_vat"]
            pro_store_retail_vat_percentage <- map["pro_store_retail_vat_percentage"]
            pro_store_retail_final_price <- map["pro_store_retail_final_price"]
            pro_store_retail_min_qty <- map["pro_store_retail_min_qty"]
            pro_store_retail_max_qty <- map["pro_store_retail_max_qty"]
            pro_store_retail_return_days <- map["pro_store_retail_return_days"]
            pro_store_wholesale <- map["pro_store_wholesale"]
            pro_store_wholesale_price <- map["pro_store_wholesale_price"]
            pro_store_wholesale_dis_price <- map["pro_store_wholesale_dis_price"]
            pro_store_wholesale_dis_percentage <- map["pro_store_wholesale_dis_percentage"]
            pro_store_wholesale_net_sell_price <- map["pro_store_wholesale_net_sell_price"]
            pro_store_wholesale_vat <- map["pro_store_wholesale_vat"]
            pro_store_wholesale_vat_percentage <- map["pro_store_wholesale_vat_percentage"]
            pro_store_wholesale_final_price <- map["pro_store_wholesale_final_price"]
            pro_store_wholesale_min_qty <- map["pro_store_wholesale_min_qty"]
            pro_store_wholesale_max_qty <- map["pro_store_wholesale_max_qty"]
            pro_store_wholesale_return_days <- map["pro_store_wholesale_return_days"]
            store_payment_mode <- map["store_payment_mode"]
            pro_parent_cat_id <- map["pro_parent_cat_id"]
            pro_parent_cat_name <- map["pro_parent_cat_name"]
            pro_sub_cat_id <- map["pro_sub_cat_id"]
            pro_sub_cat_name <- map["pro_sub_cat_name"]
            pro_filter <- map["pro_filter"]
            pro_weight <- map["pro_weight"]
            pro_length <- map["pro_length"]
            pro_width <- map["pro_width"]
            pro_height <- map["pro_height"]
            pro_dimension <- map["pro_dimension"]
            pro_technical_specification <- map["pro_technical_specification"]
            pro_pdf <- map["pro_pdf"]
            pro_warranty_section <- map["pro_warranty_section"]
            pro_stock <- map["pro_stock"]
        }

    }

    struct Pro_image : Mappable {
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
    struct Pro_branch : Mappable {
        var branch_id : Int?
        var branch_name : String?

        init?(map: Map) {

        }

        mutating func mapping(map: Map) {

            branch_id <- map["branch_id"]
            branch_name <- map["branch_name"]
        }

    }
    struct Store_payment_list : Mappable {
        var payment_id : Int?
        var payment_name : String?

        init?(map: Map) {

        }

        mutating func mapping(map: Map) {

            payment_id <- map["payment_id"]
            payment_name <- map["payment_name"]
        }

    }


    struct Pro_pdf : Mappable {
        var id : Int?
        var pdf : String?
        var size : Double?
        init?(map: Map) {

        }

        mutating func mapping(map: Map) {
            size <- map["size"]
            id <- map["id"]
            pdf <- map["pdf"]
        }

    }
    struct Pro_filter : Mappable {
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

    struct Online_wholesale_mapping : Mappable {
        var online_wholesale_min_qty : Int?
        var online_wholesale_max_qty : Int?
        var online_wholesale_price : Double?
        var online_wholesale_discount : Double?
        var online_wholesale_discount_per : Double?
        var online_wholesale_net_sell_price : Double?
        var online_wholesale_vat : Double?
        var online_wholesale_vat_per : Double?
        var online_wholesale_final_price : Double?

        init?(map: Map) {

        }

        mutating func mapping(map: Map) {

            online_wholesale_min_qty <- map["online_wholesale_min_qty"]
            online_wholesale_max_qty <- map["online_wholesale_max_qty"]
            online_wholesale_price <- map["online_wholesale_price"]
            online_wholesale_discount <- map["online_wholesale_discount"]
            online_wholesale_discount_per <- map["online_wholesale_discount_per"]
            online_wholesale_net_sell_price <- map["online_wholesale_net_sell_price"]
            online_wholesale_vat <- map["online_wholesale_vat"]
            online_wholesale_vat_per <- map["online_wholesale_vat_per"]
            online_wholesale_final_price <- map["online_wholesale_final_price"]
        }
    }
    struct Store_payment_mode : Mappable {
        var oNLINE : Bool?
        var cOD : Bool?

        init?(map: Map) {

        }

        mutating func mapping(map: Map) {

            oNLINE <- map["ONLINE"]
            cOD <- map["COD"]
        }

    }
    struct Online_payment_mode : Mappable {
        var oNLINE : Bool?
        var cOD : Bool?

        init?(map: Map) {

        }

        mutating func mapping(map: Map) {

            oNLINE <- map["ONLINE"]
            cOD <- map["COD"]
        }

    }

// store payment


struct StorePayment : Mappable {
    var error : Bool?
    var error_code : Int?
    var error_description : String?
    var data : StorePaymentData?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        error <- map["error"]
        error_code <- map["error_code"]
        error_description <- map["error_description"]
        data <- map["data"]
    }

}
struct StorePaymentData : Mappable {
    var store_payment_option : [Store_payment_option]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        store_payment_option <- map["store_payment_option"]
    }

}
struct Store_payment_option : Mappable {
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

//filter list

struct ProductFilterList : Mappable {
    var error : Bool?
    var error_code : Int?
    var error_description : String?
    var data : ProductFilterListData?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        error <- map["error"]
        error_code <- map["error_code"]
        error_description <- map["error_description"]
        data <- map["data"]
    }

}
struct ProductFilterListData : Mappable {
    var filter_list : [Filter_listnew]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        filter_list <- map["filter_list"]
    }

}
struct Filter_listnew : Mappable {
    var filter_id : Int?
    var filter_name : String?
    var filter_image : String?
    var filter_status : Int?
    var filter_created_by : Int?
    var filter_for_variant : Bool?
    var filter_value : [Filter_valuenew]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        filter_id <- map["filter_id"]
        filter_name <- map["filter_name"]
        filter_image <- map["filter_image"]
        filter_status <- map["filter_status"]
        filter_created_by <- map["filter_created_by"]
        filter_for_variant <- map["filter_for_variant"]
        filter_value <- map["filter_value"]
    }

}
struct Filter_valuenew : Mappable {
    var filter_value_id : Int?
    var filter_value_name : String?
    var filter_value_image : String?
    var filter_value_status : Int?
    var filter_value_created_by : Int?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        filter_value_id <- map["filter_value_id"]
        filter_value_name <- map["filter_value_name"]
        filter_value_image <- map["filter_value_image"]
        filter_value_status <- map["filter_value_status"]
        filter_value_created_by <- map["filter_value_created_by"]
    }

}


// select multiple branch data


struct CreateViewProductList : Mappable {
    var error : Bool?
    var error_code : Int?
    var error_description : String?
    var data : CreateViewProductListData?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        error <- map["error"]
        error_code <- map["error_code"]
        error_description <- map["error_description"]
        data <- map["data"]
    }

}
struct CreateViewProductListData : Mappable {
    var product_list : [Product_listdata]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        product_list <- map["product_list"]
    }

}
struct Product_listdata : Mappable {
    var pro_id : Int?
    var pro_name : String?
    var pro_image : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        pro_id <- map["pro_id"]
        pro_name <- map["pro_name"]
        pro_image <- map["pro_image"]
    }

}


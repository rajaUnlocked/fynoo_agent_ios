//
//  DataEntryServiceListModal.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-040 on 07/12/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import Foundation
import ObjectMapper

struct DataEntryOrderRequestDatas : Mappable {
    var error : Bool?
    var error_code : Int?
    var error_description : String?
    var data : DataEntryOrderList?
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        error <- map["error"]
        error_code <- map["error_code"]
        error_description <- map["error_description"]
        data <- map["data"]
    }
}

struct DataEntryOrderList : Mappable {
    
    var rating_count : Int?
    var rating_avg : String?
    var service_list : [OrderService_list]?
    var in_progress_limit : Int?
    var filter_list : [DataEntry_Filter]?
    var is_active : Bool?
    var per_page_limit : Int?
    var total_records_count : Int?
    var service_name : String?
    var service_icon : String?
    
    
    
    init?(map: Map) {
    }
    mutating func mapping(map: Map) {
        
        rating_count <- map["rating_count"]
        per_page_limit <- map["per_page_limit"]
        total_records_count <- map["total_records_count"]
        service_name <- map["service_name"]
        service_icon <- map["service_icon"]
        is_active <- map["is_active"]
        rating_avg <- map["rating_avg"]
        service_list <- map["service_list"]
        in_progress_limit <- map["in_progress_limit"]
        filter_list <- map["filter_list"]
    }
}

struct OrderService_list : Mappable {
    
    var id : Int?
    var instruction : String?
    var order_id : String?
    var order_date : Int?
    var in_progress_date : Int?
    var order_price : Double?
    var location : String?
    var branch : Int?
    var country_code : String?
    var city_name : String?
    var branch_address : String?
    var lat : String?
    var long : String?
    var bo_id : Int?
    var bo_name : String?
    var bo_email : String?
    var bo_number : String?
    var bo_mob_code : String?
    var bo_pic : String?
    var start_work : Int?
    
    var address : String?
    var rating_count : Int?
    var rating_avg : String?
    var rating_given : Int?
    var reason : String?
    
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        instruction <- map["instruction"]
        order_id <- map["order_id"]
        order_date <- map["order_date"]
        in_progress_date <- map["in_progress_date"]
        order_price <- map["order_price"]
        location <- map["location"]
        branch <- map["branch"]
        country_code <- map["country_code"]
        city_name <- map["city_name"]
        branch_address <- map["branch_address"]
        lat <- map["lat"]
        long <- map["long"]
        bo_id <- map["bo_id"]
        bo_name <- map["bo_name"]
        bo_email <- map["bo_email"]
        bo_number <- map["bo_number"]
        bo_mob_code <- map["bo_mob_code"]
        bo_pic <- map["bo_pic"]
        
        address <- map["address"]
        rating_count <- map["rating_count"]
        rating_avg <- map["rating_avg"]
        rating_given <- map["rating_given"]
        reason <- map["reason"]
        start_work <- map["start_work"]
        
    }
}

struct DataEntry_Filter : Mappable {
    
    var filter_code : String?
    var filter_id : Int?
    var filter_name : String?
    var view_type : String?
    var range_list : String?
    
    var radio_list : [DataEntryRadio_list]?
    var checkbox_item : [DataEntrycheckbox_item]?
      
      
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        
        filter_code <- map["filter_code"]
        filter_id <- map["filter_id"]
        filter_name <- map["filter_name"]
        view_type <- map["view_type"]
        radio_list <- map["radio_list"]
        checkbox_item <- map["checkbox_item"]
        range_list <- map["range_list"]
        
    }
}


struct DataEntryRadio_list : Mappable {
    
    var key : String?
    var value : Int?
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        key <- map["key"]
        value <- map["value"]
    }
}

struct DataEntrycheckbox_item : Mappable {
    
    var id : Int?
    var name : String?
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
    }
}
struct ChooseFilters
{
    var filter_code : String
    var range : String
    var type : String

    init(code : String, range : String, type : String) {
        self.filter_code = code
        self.range = range
        self.type = type
    }
    
}

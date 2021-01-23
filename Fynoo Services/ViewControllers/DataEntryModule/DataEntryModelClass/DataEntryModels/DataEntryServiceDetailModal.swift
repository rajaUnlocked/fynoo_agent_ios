//
//  DataEntryServiceDetailModal.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-040 on 24/12/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper


class serviceDetailData : Mappable {
    var error = ""
    var error_code  = ""
    var error_description = ""
    var data : serviceDatas?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        
        error <- map["error"]
        error_code <- map["error_code"]
        error_description <- map["error_description"]
        data <- map["data"]
    }
    
}
class serviceDatas : Mappable {
  
    var id : Int?
    var instruction : String?
    var order_id : String?
    var order_date : Int?
    var completion_days : Int?
    var work_place : Int?
    var in_progress_date : Int?
    var completed_date : Int?
    var reject_date : Int?
    var cancel_date : Int?
    var service_price : Double?
    var paid_amount : Double?
    var location : String?
    var country_code = ""
    var city_name = ""
    var branch : Int?
    var branch_name : String?
    var address : String?
    var branch_lat : String?
    var branch_long : String?
    var service_status : Int?
    var bo_id : Int?
    var rating_count : Int?
    var rating_avg : String?
    var bo_name : String?
    var bo_email : String?
    var bo_number : String?
    var bo_mob_code : String?
    var bo_pic : String?
    var data_entry_lines : [Data_entry_lines]?
    var rem_days_text : String?
    var des_product_count : Int?
    var des_product_complete : Int?
    var des_branch_count : Int?
    var des_branch_complete : Int?
    var start_work : Int?
    var ip_limit : Int?
    var current_ip : Int?

    
    
  
    
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        
        
        id <- map["id"]
        instruction <- map["instruction"]
        order_id <- map["order_id"]
        order_date <- map["order_date"]
        completion_days <- map["completion_days"]
        work_place <- map["work_place"]
        in_progress_date <- map["in_progress_date"]
        completed_date <- map["completed_date"]
        reject_date <- map["reject_date"]
        cancel_date <- map["cancel_date"]
        service_price <- map["service_price"]
        paid_amount <- map["paid_amount"]
        location <- map["location"]
        country_code <- map["country_code"]
        city_name <- map["city_name"]
        branch <- map["branch"]
        branch_name <- map["branch_name"]
        address <- map["address"]
        branch_lat <- map["branch_lat"]
        branch_long <- map["branch_long"]
        service_status <- map["service_status"]
        bo_id <- map["bo_id"]
        rating_count <- map["rating_count"]
        rating_avg <- map["rating_avg"]
        bo_name <- map["bo_name"]
        bo_email <- map["bo_email"]
        bo_number <- map["bo_number"]
        bo_mob_code <- map["bo_mob_code"]
        bo_pic <- map["bo_pic"]
        data_entry_lines <- map["data_entry_lines"]
        ip_limit <- map["ip_limit"]
        current_ip <- map["current_ip"]
        rem_days_text <- map["rem_days_text"]
        des_product_count <- map["des_product_count"]
        des_product_complete <- map["des_product_complete"]
        des_branch_count <- map["des_branch_count"]
        des_branch_complete <- map["des_branch_complete"]
        start_work <- map["start_work"]
        
        
    }
}

class Data_entry_lines : Mappable {
    
    var des_id : Int?
    var des_name : String?
    var des_type_count : Int?
    var type_name : String?
    var is_complete : Int?
    
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        
        des_id <- map["des_id"]
        des_name <- map["des_name"]
        des_type_count <- map["des_type_count"]
        type_name <- map["type_name"]
        is_complete <- map["is_complete"]
    }
    
}

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
    
   var service_list : [OrderService_list]?

    
    init?(map: Map) {
    }
    mutating func mapping(map: Map) {
        
        service_list <- map["service_list"]
 
    }
}

struct OrderService_list : Mappable {
  

    
    var id : Int?
    var instruction : String?
    var order_id : String?
    var order_date : Int?
    var order_price : Double?
    var location : String?
    var country_code : String?
    var city_name : String?
    var branch : Int?
    var address : String?
    var branch_lat : String?
    var branch_long : String?
    var agent_id : Int?
    var rating_count : Int?
    var rating_avg : String?
    var rating_given : Int?
    var agent_name : String?
    var agent_email : String?
    var agent_number : String?
    var agent_mob_code : String?
    var agent_country : String?
    var agent_city : String?
    var agent_pic : String?
    var agent_lang : String?
    var reason : String?
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        instruction <- map["instruction"]
        order_id <- map["order_id"]
        order_date <- map["order_date"]
        order_price <- map["order_price"]
        location <- map["location"]
        country_code <- map["country_code"]
        city_name <- map["city_name"]
        branch <- map["branch"]
        address <- map["address"]
        branch_lat <- map["branch_lat"]
        branch_long <- map["branch_long"]
        agent_id <- map["agent_id"]
        rating_count <- map["rating_count"]
        rating_avg <- map["rating_avg"]
         rating_given <- map["rating_given"]
        agent_name <- map["agent_name"]
        agent_email <- map["agent_email"]
        agent_number <- map["agent_number"]
        agent_mob_code <- map["agent_mob_code"]
        agent_country <- map["agent_country"]
        agent_city <- map["agent_city"]
        agent_pic <- map["agent_pic"]
        agent_lang <- map["agent_lang"]
        reason <- map["reason"]
        
    }
}


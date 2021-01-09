//
//  BOServicesModal.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-040 on 04/12/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper

class BOServicesData : Mappable {
    
    var error : Bool?
    var error_code : Int?
    var error_description : String?
    var data : [services_lists]?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        
        error <- map["error"]
        error_code <- map["error_code"]
        error_description <- map["error_description"]
        data <- map["data"]
    }
}


class services_lists : Mappable {
    var service_id : Int?
    var service_name : String?
    var service_icon : String?
    var waiting_list : Int?
    var in_progress_list : Int?
    
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        
        service_id <- map["service_id"]
        service_name <- map["service_name"]
        service_icon <- map["service_icon"]
        waiting_list <- map["waiting_list"]
        in_progress_list <- map["in_progress_list"]
    }
    
}

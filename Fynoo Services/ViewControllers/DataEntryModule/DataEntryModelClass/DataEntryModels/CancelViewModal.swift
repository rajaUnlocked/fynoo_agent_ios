//
//  CancelViewModal.swift
//  Fynoo
//
//  Created by IND-SEN-LP-046 on 16/05/20.
//  Copyright © 2020 Aishwarya. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper


class ReasonRejectData : Mappable {
    var error = ""
    var error_code  = ""
    var error_description = ""
    var data : reasonDatas?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        
        error <- map["error"]
        error_code <- map["error_code"]
        error_description <- map["error_description"]
        data <- map["data"]
    }
    
}
class reasonDatas : Mappable {
    var reason_list : [RejectReason_lists]?
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        
      reason_list <- map["reason_list"]
    }
}

class RejectReason_lists : Mappable {
    var reason_id : Int?
    var reason : String?
    var reason_name : String?
    var reason_for : Int?
    var reason_at : Int?
    var reason_type : String?

   
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        
        reason_id <- map["reason_id"]
        reason <- map["reason"]
        reason_name <- map["reason_name"]
        reason_for <- map["reason_for"]
        reason_at <- map["reason_at"]
        reason_type <- map["reason_type"]
    }
    
}

//
//  DataEntryTypeListingModal.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-040 on 28/12/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper


class ServiceTypeData : Mappable {
    var error = ""
    var error_code  = ""
    var error_description = ""
    var data : TypeDatas?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        
        error <- map["error"]
        error_code <- map["error_code"]
        error_description <- map["error_description"]
        data <- map["data"]
    }
    
}
class TypeDatas : Mappable {
    var data_entry_lines : [Data_lines]?
    var bo_id : Int?
    var agent_id : Int?

    required init?(map: Map) {}
    
    func mapping(map: Map) {
        
     data_entry_lines <- map["data_entry_lines"]
      bo_id <- map["bo_id"]
      agent_id <- map["agent_id"]
        
    }
}

class Data_lines : Mappable {
    
   var des_name : String?
    var type_name : String?
    var is_complete : Int?
   
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        
       des_name <- map["des_name"]
        type_name <- map["type_name"]
        is_complete <- map["is_complete"]
    }
    
}

//
//  DataEntryFormTypeModal.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-040 on 17/12/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import Foundation
import ObjectMapper

class dataEntryFormTypeModal : Mappable {
    
    var error : Bool?
    var error_code : Int?
    var error_description : String?
    var data : formType_lists?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        
        error <- map["error"]
        error_code <- map["error_code"]
        error_description <- map["error_description"]
        data <- map["data"]
    }
}

class formType_lists : Mappable {
    
    var data_entry_types : [Data_entry_List]?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        
        data_entry_types <- map["data_entry_types"]
    }
    
}

class Data_entry_List : Mappable {
    var type_name : String?
    var type_id : Int?
    var feat_icon : String?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        
        type_name <- map["type_name"]
        type_id <- map["type_id"]
         feat_icon <- map["feat_icon"]
    }
}

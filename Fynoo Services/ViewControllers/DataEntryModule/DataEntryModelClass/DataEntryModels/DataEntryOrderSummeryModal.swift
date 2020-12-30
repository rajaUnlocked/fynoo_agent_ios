//
//  DataEntryOrderSummeryModal.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-040 on 16/12/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import Foundation
import ObjectMapper

struct DataEntryPriceBifercationModal : Mappable {
  var error : Bool?
    var error_code : Int?
    var error_description : String?
    var data : dataEntryPriceDetail?

    init?(map: Map) {
    }

    mutating func mapping(map: Map) {
           error <- map["error"]
            error_code <- map["error_code"]
            error_description <- map["error_description"]
            data <- map["data"]
    }
}

struct dataEntryPriceDetail : Mappable {
    
    var or_price : String?
    var tax_amount : String?
    var tax_percent : String?
    var final_price : String?
    var wal_free_balance : String?
    var entry_id : String?
    var cart_count : Int?

    
    
    init?(map: Map) {
    }
    mutating func mapping(map: Map) {
        
        or_price <- map["or_price"]
        tax_amount <- map["tax_amount"]
        tax_percent <- map["tax_percent"]
        final_price <- map["final_price"]
        wal_free_balance <- map["wal_free_balance"]
        entry_id <- map["entry_id"]
         cart_count <- map["cart_count"]
    }
}


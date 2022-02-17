//
//  BankList.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-048 on 20/09/19.
//  Copyright © 2019 Sendan. All rights reserved.
//

import Foundation
import ObjectMapper

class BankList : Mappable {
    var error = ""
    var error_code  = ""
    var error_description = ""
    var data : userBank?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        
        error <- map["error"]
        error_code <- map["error_code"]
        error_description <- map["error_description"]
        data <- map["data"]
    }
    
}
class userBank  :Mappable{
    var users_bank : [users_banks]?
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        
        users_bank <- map["users_bank"]
        
    }
}


class users_banks : Mappable {
    
    var account_iban_nbr  = ""
    var account_nbr  = ""
    var bank_name  = ""
    var bank_id  = 0
    var full_name  = ""
    var full_name_ar  = ""
    var id  = 0
    var currency_code = ""
    var currency_id = 0
    var short_name = ""
    var is_agreed = false
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        
        short_name <- map["short_name"]
        currency_code <- map["currency_code"]
        currency_id <- map["currency_id"]
        account_iban_nbr <- map["account_iban_nbr"]
        account_nbr <- map["account_nbr"]
        bank_id <- map["bank_id"]
        bank_name <- map["bank_name"]
        full_name <- map["full_name"]
        full_name_ar <- map["full_name_ar"]
        id <- map["id"]
        is_agreed <- map["is_agreed"]
        
    }
    
}





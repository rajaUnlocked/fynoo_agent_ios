//
//  ProfileModal.swift
//  Fynoo Services
//
//  Created by IND-SEN-LP-046 on 10/09/20.
//  Copyright © 2020 Aishwarya. All rights reserved.
//

import Foundation
import ObjectMapper




class AgentProfile : NSObject{
    //basic Info
    var businessName = ""
    var Email = ""
    var country = ""
    var countryId = 0
    var city = ""
    var cityId = 0
    var mobileNo = ""
    var mobileCode = ""
    var mobileFlag = ""
    var phoneNo = ""
    var phCode  = ""
    var phFlag = ""
    var maroof = ""
    
    //bankDetail
    var bankname = ""
    var cardHolderName = ""
    var iban = ""
    var bankId = 0
    //vat
    var vatNo = ""
    var vatCertificate = ""
    
    //personal
    var name = ""
    var gender = ""
    var dob = ""
    var education = ""
    var major = ""
    
}




class ProfileModal : Mappable{
    
    
    var error = ""
    var error_code  = ""
    var error_description = ""
    var data : ProfileData?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        
        error <- map["error"]
        error_code <- map["error_code"]
        error_description <- map["error_description"]
        data <- map["data"]
    }
    
}

class ProfileData : Mappable{
    
    var total_branches  = 0
    var total_follower = 0
    var total_likes = 0
    var total_products = 0
    var user_type = ""
    var vat_no = ""
    var bank_information : [bank_information]?
    var basic_information : [basic_information]?
    var service_list_data : [service_list_data]?
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        
        total_branches <- map["total_branches"]
        total_follower <- map["total_follower"]
        total_likes <- map["total_likes"]
        total_products <- map["total_products"]
        user_type <- map["user_type"]
        vat_no <- map["vat_no"]
        
        bank_information <- map["bank_information"]
        basic_information <- map["basic_information"]
        service_list_data <- map["service_list_data"]
    }
    
}

class bank_information : Mappable{
    
    
    var bank_details_id = 0
    var full_name = ""
    var bank_id = 0
    var bank_name = ""
    var account_iban_nbr = ""
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        
        bank_details_id <- map["bank_details_id"]
        full_name <- map["full_name"]
        bank_id <- map["bank_id"]
        account_iban_nbr <- map["account_iban_nbr"]
        bank_name <- map["bank_name"]
    }
    
}

class basic_information : Mappable{
    
    
    var business_name = ""
    var city = ""
    var city_id = 0
    var country = ""
    var country_id = 0
    var dob = ""
    var education_id = 0
    var education_name = ""
    var email = ""
    var gender = ""
    var major_id = 0
    var major_name = ""
    var maroof_link = ""
    var mobile_code = ""
    var mobile_number = ""
    var name = ""
    var phone_code = ""
    var phone_number = ""
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        
        business_name <- map["business_name"]
        city <- map["city"]
        city_id <- map["city_id"]
        country <- map["country"]
        country_id <- map["country_id"]
        
        dob <- map["dob"]
        education_id <- map["education_id"]
        education_name <- map["education_name"]
        email <- map["email"]
        gender <- map["gender"]
        
        major_id <- map["major_id"]
        major_name <- map["major_name"]
        maroof_link <- map["maroof_link"]
        mobile_code <- map["mobile_code"]
        mobile_number <- map["mobile_number"]
        
        name <- map["name"]
        phone_code <- map["phone_code"]
        phone_number <- map["phone_number"]
    }
    
}

class service_list_data : Mappable{
    
    
    var is_active = 0
    var is_opt = 0
    var service_code = ""
    var service_icon = ""
    var service_id = 0
    var service_name = ""
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        
        is_active <- map["is_active"]
        is_opt <- map["is_opt"]
        service_code <- map["service_code"]
        service_icon <- map["service_icon"]
        service_id <- map["service_id"]
        service_name <- map["service_name"]

    }
    
}

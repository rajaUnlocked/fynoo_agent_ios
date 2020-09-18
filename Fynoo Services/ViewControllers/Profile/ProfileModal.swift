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
    var name = ""
    var businessName = "ffjdfgh"
    var Email = ""
    var country = ""
    var countryId = 0
    var city = ""
    var cityId = 0
    var mobileNo = ""
    var mobileCode = ""
    var mobileFlag = ""
    var mobileLength = 0
    var phoneLength = 0
    var phoneNo = ""
    var phCode  = ""
    var phFlag = ""
    var maroof = ""
    
    //bankDetail
    var bankname = ""
    var cardHolderName = "hgsdsd"
    var iban = ""
    var bankId = 0
    //vat
    var vatNo = ""
    var vatCertificate = ""
    
    //personal
    var gender = ""
    var dob = ""
    var education = ""
    var educationId = 0
    var majorId = 0
    var major = ""
    var ibanLenght = 0
    
    var serviceArr = NSMutableArray()
}




class ProfileModal : Mappable{
    
    
    var error = ""
    var error_code  = ""
    var error_description = ""
    var data : ProfileDataInfo?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        
        error <- map["error"]
        error_code <- map["error_code"]
        error_description <- map["error_description"]
        data <- map["data"]
    }
    
}
class ProfileDataInfo : Mappable{
    
    var user_data : ProfileData?
    var service_list_data : [service_list_data]?
      var language_list : [language_lists]?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        language_list <- map["language_list"]

        service_list_data <- map["service_list_data"]
        user_data <- map["user_data"]
    }
    
}
class language_lists : Mappable{
    
    var id = 0
    var lang_id = ""
    var lang_name = ""
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        
        id <- map["id"]
        lang_id <- map["lang_id"]
        lang_name <- map["lang_name"]
    }
    
}


class ProfileData : Mappable{
    var ac_holder_name = ""
    var total_branches  = 0
    var total_follower = 0
    var total_likes = 0
    var total_products = 0
    var user_type = ""
    var vat_no = ""
    var bank_details_id = 0
    var full_name = ""
    var bank_id = 0
    var bank_name = ""
    var account_iban_nbr = ""
    var iban_no = ""
    var business_name = ""
    var city = ""
    var city_id = 0
    var country = ""
    var country_id = 0
    var dob = ""
    var education_new = 0
    var education = ""
    var email = ""
    var gender = ""
    var education_major_id = 0
    var education_major = ""
    var maroof_link = ""
    var mobile_code = ""
    var mobile_number = ""
    var name = ""
    var phone_code = ""
    var phone_number = ""
    var vat_certificate = ""
    var mobile_flag = ""
    var phone_flag = ""
    var mobile_length = 0
    var phone_length = 0
    var profile_image = ""
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        profile_image <- map["profile_image"]
        mobile_length <- map["mobile_length"]
        phone_length <- map["phone_length"]
        phone_flag <- map["phone_flag"]
        mobile_flag <- map["mobile_flag"]
        ac_holder_name <- map["ac_holder_name"]

        vat_certificate <- map["vat_certificate"]
        iban_no <- map["iban_no"]
        bank_details_id <- map["bank_details_id"]
        full_name <- map["full_name"]
        bank_id <- map["bank_id"]
        account_iban_nbr <- map["account_iban_nbr"]
        bank_name <- map["bank_name"]
        
        total_branches <- map["total_branches"]
        total_follower <- map["total_follower"]
        total_likes <- map["total_likes"]
        total_products <- map["total_products"]
        user_type <- map["user_type"]
        vat_no <- map["vat_no"]
        business_name <- map["business_name"]
        city <- map["city"]
        city_id <- map["city_id"]
        country <- map["country"]
        country_id <- map["country_id"]
        
        dob <- map["dob"]
        education_new <- map["education_new"]
        education <- map["education"]
        email <- map["email"]
        gender <- map["gender"]
        
        education_major <- map["education_major"]
        education_major_id <- map["education_major_id"]
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

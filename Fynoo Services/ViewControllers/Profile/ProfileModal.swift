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
    var langArr = NSMutableArray()
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
    var lang_id = 0
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
    var bank = 0
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
    var fynoo_id = ""
    var company_name = ""
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        company_name <- map["company_name"]
        fynoo_id <- map["fynoo_id"]
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
        bank <- map["bank"]
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
    
    var check_service = false
    var is_active = 0
    var is_opt = 0
    var service_code = ""
    var service_icon = ""
    var service_id = 0
    var service_name = ""
    var service_status = 0
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        check_service <- map["check_service"]
        is_active <- map["is_active"]
        is_opt <- map["is_opt"]
        service_code <- map["service_code"]
        service_icon <- map["service_icon"]
        service_id <- map["service_id"]
        service_name <- map["service_name"]
        service_status <- map["service_status"]
        
    }
    
}




class deliveryDashboard : Mappable {
    
    
    var error = ""
    var error_code  = ""
    var error_description = ""
    var data : DeliveryInfo?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        
        error <- map["error"]
        error_code <- map["error_code"]
        error_description <- map["error_description"]
        data <- map["data"]
    }
    
}

class DeliveryInfo : Mappable {
    
    var user_lang : String?
    var agent_information : agentInfo?
    var del_accept_limit : acceptInfo?
//    var user_lang : [language_lists]?

    
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        agent_information <- map["agent_information"]
        del_accept_limit <- map["del_accept_limit"]
        user_lang <- map["user_lang"]
    }
    
}
class trips_achievements : Mappable{
    
    
    var trip_code = ""
    var trip_count = 0
    var trip_icon = ""
    var trip_text = ""
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        
        trip_code <- map["trip_code"]
        trip_count <- map["trip_count"]
        trip_icon <- map["trip_icon"]
        trip_text <- map["trip_text"]
    }
    
}

class acceptInfo : Mappable{
    
    
    var today_cod = 0
    var cod_id = 0

    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        
        today_cod <- map["today_cod"]
        cod_id <- map["cod_id"]
    }
    
}


class agentInfo : Mappable{
    
    var above_and_beyond = 0
    var active_years = 0
    var avg_rating = 0.0

    var trips_achievements:[trips_achievements]?
    var del_service_document = ""
   var del_service_document_reason = ""
    var del_service_document_uploaded = 0
    var del_service_status = 0
    var dsd_id = 0
    var excellent_service = 0
    var fynoo_id = ""
    var great_attitude = 0
    var id = 0
    var name = ""
    var service_icon = ""
    var total_earnings = 0
    var total_rating = 0
    var total_trips = 0
    var u_image_id = 0
    var user_img = ""
    var very_helpful = 0
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        
        del_service_document_reason <- map["del_service_document_reason"]
          dsd_id <- map["dsd_id"]
          trips_achievements <- map["trips_achievements"]
        del_service_document <- map["del_service_document"]
        above_and_beyond <- map["above_and_beyond"]
        active_years <- map["active_years"]
        avg_rating <- map["avg_rating"]
        
        del_service_document_uploaded <- map["del_service_document_uploaded"]
        del_service_status <- map["del_service_status"]
        excellent_service <- map["excellent_service"]
        fynoo_id <- map["fynoo_id"]
        id <- map["id"]
        name <- map["name"]
        service_icon <- map["service_icon"]
        total_earnings <- map["total_earnings"]
        total_rating <- map["total_rating"]
        total_trips <- map["total_trips"]
        u_image_id <- map["u_image_id"]
        user_img <- map["user_img"]
        very_helpful <- map["very_helpful"]
    }
    
}

class TripListInfo : Mappable{
    
    
    var error = ""
    var error_code  = ""
    var error_description = ""
    var data : tripData?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        
        error <- map["error"]
        error_code <- map["error_code"]
        error_description <- map["error_description"]
        data <- map["data"]
    }
    
}

class tripData : Mappable{
    
    
    var trip_list : [triplist]?
   
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        
        trip_list <- map["trip_list"]
       
    }
    
}

class triplist : Mappable{
    
    var id : Int?
    var cust_name : String?
    var search_id : Int?
    var cust_image : String?
    var qty : Int?
    var address : String?
    var almost_total_price : Double?
    var currency : String?
    var order_id : String?
    var payment_mode : String?
    var payment_icon : String?
    var avg_rating : String?
    var total_rating : String?
    var order_date : String?
    var status : Int?
    var status_desc : String?
    var lat : String?
    var long : String?
    var cust_mobile : String?
    
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        
       id <- map["id"]
        cust_name <- map["cust_name"]
        search_id <- map["search_id"]
        cust_image <- map["cust_image"]
        qty <- map["qty"]
        address <- map["address"]
        almost_total_price <- map["almost_total_price"]
        currency <- map["currency"]
        order_id <- map["order_id"]
        payment_mode <- map["payment_mode"]
        payment_icon <- map["payment_icon"]
        avg_rating <- map["avg_rating"]
        total_rating <- map["total_rating"]
        order_date <- map["order_date"]
        status <- map["status"]
        status_desc <- map["status_desc"]
        lat <- map["lat"]
        long <- map["long"]
        cust_mobile <- map["cust_mobile"]
        
    }
    
}

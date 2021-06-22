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



class deliveryTripDetail : Mappable {
    
    
    var error = ""
    var error_code  = ""
    var error_description = ""
    var data : DeliveryTripDetail?
    
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

class DeliveryTripDetail : Mappable {
    
    var user_lang : String?
    var trip_details : tripDetailInfo?
//    var del_accept_limit : acceptInfo?
//    var user_lang : [language_lists]?

    
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        trip_details <- map["trip_details"]
//      del_accept_limit <- map["del_accept_limit"]
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


class tripDetailInfo : Mappable{
    var id : Int?
    var order_id : String?
    var branch_id : Int?
    var branch_name : String?
    var branch_image : String?
    var rating : String?
    var total_rating : String?
    var address : String?
    var bo_lat : String?
    var bo_long : String?
    var time_display_style : Int?
    var time_display_code : String?
    var store_time_display : String?
    var is_store_open : Bool?
    var available_time : String?
    var show_timings : [String]?
    var delivery_times : [Delivery_times]?
    var cust_nam : String?
    var cust_address : String?
    var cust_image : String?
    var cust_rating : String?
    var cust_total_rating : String?
    var cust_lat : String?
    var cust_long : String?
    var agent_lat : String?
    var agent_long : String?
    var status : Int?
    var status_des : String?

    required init?(map: Map) {

    }

    func mapping(map: Map) {

        id <- map["id"]
        order_id <- map["order_id"]
        branch_id <- map["branch_id"]
        branch_name <- map["branch_name"]
        branch_image <- map["branch_image"]
        rating <- map["rating"]
        total_rating <- map["total_rating"]
        address <- map["address"]
        bo_lat <- map["bo_lat"]
        bo_long <- map["bo_long"]
        time_display_style <- map["time_display_style"]
        time_display_code <- map["time_display_code"]
        store_time_display <- map["store_time_display"]
        is_store_open <- map["is_store_open"]
        available_time <- map["available_time"]
        show_timings <- map["show_timings"]
        delivery_times <- map["delivery_times"]
        cust_nam <- map["cust_nam"]
        cust_address <- map["cust_address"]
        cust_image <- map["cust_image"]
        cust_rating <- map["cust_rating"]
        cust_total_rating <- map["cust_total_rating"]
        cust_lat <- map["cust_lat"]
        cust_long <- map["cust_long"]
        agent_lat <- map["agent_lat"]
        agent_long <- map["agent_long"]
        status <- map["status"]
        status_des <- map["status_des"]
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


// mark - Arv


class orderDetail : Mappable {
    var error = ""
    var error_code  = ""
    var error_description = ""
    var data : OrderDetailsInfo?
    
   
    required init?(map: Map) {}

     func mapping(map: Map) {

        error <- map["error"]
        error_code <- map["error_code"]
        error_description <- map["error_description"]
        data <- map["data"]
    }

}


class OrderDetailsInfo : Mappable {
    var order_pk : Int?
    var order_id : String?
    var total_order : Int?
    var total_accepted_order : Int?
    var expected_time : String?
    var is_vat_available : Bool?
    var agent_lat : String?
    var agent_long : String?
    var is_agent_reached : Int?
    var bo_lat : String?
    var bo_long : String?
    var otp : Int?
    var bo_id : Int?
    var bo_name : String?
    var bo_mob_no : String?
    var bo_pic : String?
    var bo_address : String?
    var bo_rating : String?
    var bo_total_rating : String?
    var cust_id : Int?
    var cust_name : String?
    var cust_lat : String?
    var cust_long : String?
    var cust_mob_no : String?
    var cust_pic : String?
    var cust_rating : String?
    var cust_total_rating : String?
    var cust_address : String?
    var invoice_image : String?
    var total_amount_without_vat : Double?
    var vat_amount : Double?
    var total_amount_with_vat : Double?
    var order_qty : Int?
    var order_price : Double?
    var total_weight : Double?
    var total_size : Double?
    var payment_icon : String?
    var order_date : Int?
    var currency_id : Int?
    var user_type : String?
    var currency_code : String?
    var report_to_bo : Bool?
    var item_detail : [Item_detail]?
    var delivery_times : [Delivery_times]?
    var order_status : Int?
    var order_status_desc : String?
    var del_service_id : Int?
    var service_status : Int?

    required init?(map: Map) {

    }

    func mapping(map: Map) {

        order_pk <- map["order_pk"]
        order_id <- map["order_id"]
        total_order <- map["total_order"]
        total_accepted_order <- map["total_accepted_order"]
        expected_time <- map["expected_time"]
        is_vat_available <- map["is_vat_available"]
        agent_lat <- map["agent_lat"]
        agent_long <- map["agent_long"]
        is_agent_reached <- map["is_agent_reached"]
        bo_lat <- map["bo_lat"]
        bo_long <- map["bo_long"]
        otp <- map["otp"]
        bo_id <- map["bo_id"]
        bo_name <- map["bo_name"]
        bo_mob_no <- map["bo_mob_no"]
        bo_pic <- map["bo_pic"]
        bo_address <- map["bo_address"]
        bo_rating <- map["bo_rating"]
        bo_total_rating <- map["bo_total_rating"]
        cust_id <- map["cust_id"]
        cust_name <- map["cust_name"]
        cust_lat <- map["cust_lat"]
        cust_long <- map["cust_long"]
        cust_mob_no <- map["cust_mob_no"]
        cust_pic <- map["cust_pic"]
        cust_rating <- map["cust_rating"]
        cust_total_rating <- map["cust_total_rating"]
        cust_address <- map["cust_address"]
        invoice_image <- map["invoice_image"]
        total_amount_without_vat <- map["total_amount_without_vat"]
        vat_amount <- map["vat_amount"]
        total_amount_with_vat <- map["total_amount_with_vat"]
        order_qty <- map["order_qty"]
        order_price <- map["order_price"]
        total_weight <- map["total_weight"]
        total_size <- map["total_size"]
        payment_icon <- map["payment_icon"]
        order_date <- map["order_date"]
        currency_id <- map["currency_id"]
        user_type <- map["user_type"]
        currency_code <- map["currency_code"]
        report_to_bo <- map["report_to_bo"]
        item_detail <- map["item_detail"]
        delivery_times <- map["delivery_times"]
        order_status <- map["order_status"]
        order_status_desc <- map["order_status_desc"]
        del_service_id <- map["del_service_id"]
        service_status <- map["service_status"]
    }

}


class Item_detail : Mappable {
    var item_id : Int?
    var pro_id : Int?
    var pro_name : String?
    var pro_image_id : Int?
    var product_pic : String?
    var qty : Int?
    var price : Double?
    var currency_id : Int?
    var currency_code : String?
    var item_status : Int?
    var item_status_desc : String?
    var reason : String?

    required init?(map: Map) {

    }

    func mapping(map: Map) {

        item_id <- map["item_id"]
        pro_id <- map["pro_id"]
        pro_name <- map["pro_name"]
        pro_image_id <- map["pro_image_id"]
        product_pic <- map["product_pic"]
        qty <- map["qty"]
        price <- map["price"]
        currency_id <- map["currency_id"]
        currency_code <- map["currency_code"]
        item_status <- map["item_status"]
        item_status_desc <- map["item_status_desc"]
        reason <- map["reason"]
    }

}

class Delivery_times : Mappable {
    var distance : String?
    var time : String?

    required init?(map: Map) {

    }

    func mapping(map: Map) {

        distance <- map["distance"]
        time <- map["time"]
    }

}

// Mark--Reason for Return

class reasonlistData : Mappable {
    var error = ""
    var error_code = ""
    var error_description = ""
    var data : ReasonListInfo?

    required init?(map: Map) {

    }

    func mapping(map: Map) {

        error <- map["error"]
        error_code <- map["error_code"]
        error_description <- map["error_description"]
        data <- map["data"]
    }

}


class Reason_list : Mappable {
    var reason_id : Int?
    var reason : String?
    var reason_for : Int?
    var reason_at : Int?
    var reason_type : String?

    required init?(map: Map) {

    }

    func mapping(map: Map) {

        reason_id <- map["reason_id"]
        reason <- map["reason"]
        reason_for <- map["reason_for"]
        reason_at <- map["reason_at"]
        reason_type <- map["reason_type"]
    }

}

class ReasonListInfo : Mappable {
    var reason_list : [Reason_list]?

    required init?(map: Map) {

    }

    func mapping(map: Map) {

        reason_list <- map["reason_list"]
    }

}


//Mark- On the way TripDetails

class OnthewayTripDetailsData : Mappable {
    var error : Bool?
    var error_code : Int?
    var error_description : String?
    var data : OnTheWayDetailInfo?

    required init?(map: Map) {

    }

    func mapping(map: Map) {

        error <- map["error"]
        error_code <- map["error_code"]
        error_description <- map["error_description"]
        data <- map["data"]
    }

}

class Trip_details : Mappable {
    var id : Int?
    var bo_id : Int?
    var bo_name : String?
    var bo_image : String?
    var cust_id : Int?
    var cust_name : String?
    var user_type : String?
    var cust_mobile : String?
    var cust_image : String?
    var rating : String?
    var total_rating : String?
    var cust_lat : String?
    var cust_long : String?
    var agent_lat : String?
    var agent_long : String?
    var address : String?
    var status : Int?
    var status_des : String?
    var invoice_image : String?
    var order_id : String?
    var order_qty : Int?
    var order_price : Double?
    var order_date : String?
    var order_currency : String?
    var payment_icon : String?
    var payment_type : String?
    var del_service_id : Int?
    var service_status : Int?

    required init?(map: Map) {

    }

    func mapping(map: Map) {

        id <- map["id"]
        bo_id <- map["bo_id"]
        bo_name <- map["bo_name"]
        bo_image <- map["bo_image"]
        cust_id <- map["cust_id"]
        cust_name <- map["cust_name"]
        user_type <- map["user_type"]
        cust_mobile <- map["cust_mobile"]
        cust_image <- map["cust_image"]
        rating <- map["rating"]
        total_rating <- map["total_rating"]
        cust_lat <- map["cust_lat"]
        cust_long <- map["cust_long"]
        agent_lat <- map["agent_lat"]
        agent_long <- map["agent_long"]
        address <- map["address"]
        status <- map["status"]
        status_des <- map["status_des"]
        invoice_image <- map["invoice_image"]
        order_id <- map["order_id"]
        order_qty <- map["order_qty"]
        order_price <- map["order_price"]
        order_date <- map["order_date"]
        order_currency <- map["order_currency"]
        payment_icon <- map["payment_icon"]
        payment_type <- map["payment_type"]
        del_service_id <- map["del_service_id"]
        service_status <- map["service_status"]
    }

}


class OnTheWayDetailInfo : Mappable {
    var trip_details : Trip_details?

    required init?(map: Map) {

    }

    func mapping(map: Map) {

        trip_details <- map["trip_details"]
    }

}

//Mark -- Agent cancellation

class agentCancelationDetailData : Mappable {
    var error : Bool?
    var error_code : Int?
    var error_description : String?
    var data : agentCancelationDetail?

    required init?(map: Map) {

    }

    func mapping(map: Map) {

        error <- map["error"]
        error_code <- map["error_code"]
        error_description <- map["error_description"]
        data <- map["data"]
    }

}



class agentCancelationDetail : Mappable {
    var cus_id : Int?
    var cus_name : String?
    var cus_pic : String?
    var address : String?
    var order_id : String?
    var order_qty : Int?
    var order_price : Double?
    var order_date : Int?
    var currency_id : Int?
    var currency_code : String?
    var note : String?

    required init?(map: Map) {

    }

    func mapping(map: Map) {

        cus_id <- map["cus_id"]
        cus_name <- map["cus_name"]
        cus_pic <- map["cus_pic"]
        address <- map["address"]
        order_id <- map["order_id"]
        order_qty <- map["order_qty"]
        order_price <- map["order_price"]
        order_date <- map["order_date"]
        currency_id <- map["currency_id"]
        currency_code <- map["currency_code"]
        note <- map["note"]
    }

}


class newOrderTripData : Mappable {
    var error : Bool?
    var error_code : Int?
    var error_description : String?
    var data : NewTripDataInfo?

    required init?(map: Map) {

    }

    func mapping(map: Map) {

        error <- map["error"]
        error_code <- map["error_code"]
        error_description <- map["error_description"]
        data <- map["data"]
    }

}


struct NewOrder_Trip_details : Mappable {
    var search_id : Int?
    var service_id : Int?
    var qty : Int?
    var purchase_price : String?
    var delivery_price : String?
    var total_price : String?
    var otp_time : Int?
    var payment_mode : String?
    var payment_icon : String?
    var currency : String?
    var order_id : String?
    var weight : String?
    var size : String?
    var pick_up_time : String?
    var created_by : String?
    var rating : String?
    var total_rating : String?
    var cust_lat : String?
    var cust_long : String?
    var bo_lat : String?
    var bo_long : String?
    var agent_lat : String?
    var agent_long : String?
    var del_service_id : Int?
    var service_status : Int?
    var delivery_times : [Delivery_times]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        search_id <- map["search_id"]
        service_id <- map["service_id"]
        qty <- map["qty"]
        purchase_price <- map["purchase_price"]
        delivery_price <- map["delivery_price"]
        total_price <- map["total_price"]
        otp_time <- map["otp_time"]
        payment_mode <- map["payment_mode"]
        payment_icon <- map["payment_icon"]
        currency <- map["currency"]
        order_id <- map["order_id"]
        weight <- map["weight"]
        size <- map["size"]
        pick_up_time <- map["pick_up_time"]
        created_by <- map["created_by"]
        rating <- map["rating"]
        total_rating <- map["total_rating"]
        cust_lat <- map["cust_lat"]
        cust_long <- map["cust_long"]
        bo_lat <- map["bo_lat"]
        bo_long <- map["bo_long"]
        agent_lat <- map["agent_lat"]
        agent_long <- map["agent_long"]
        del_service_id <- map["del_service_id"]
        service_status <- map["service_status"]
        delivery_times <- map["delivery_times"]
    }

}

struct NewTripDataInfo : Mappable {
    var trip_details : NewOrder_Trip_details?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        trip_details <- map["trip_details"]
    }

}









//
//  UserData.swift
//  Fynoo
//
//  Created by SENDAN on 14/09/19.
//  Copyright © 2019 Aishwarya. All rights reserved.
//

import Foundation
import ObjectMapper

class UserData : Mappable{
    
    
    var error = ""
    var error_code  = ""
    var error_description = ""
    var data : userInfo?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        
        error <- map["error"]
        error_code <- map["error_code"]
        error_description <- map["error_description"]
        data <- map["data"]
    }
    
}

class userInfo : Mappable {
    var company_name  = ""
    var cu_language  = ""
    var email  = ""
    var fynoo_id  = ""
    var id  = 0
    var name  = ""
    var user_type  = ""
    var mobile_length  = 0
    var username  = ""
    var mobile_number = ""
    var bank_name = ""
    var city_id = 0
    var country = ""
    var country_id = 0
    var is_new_user = 9999
    var city = ""
    var dob = ""
    var education = ""
    var education_id = 0
    var education_major = ""
    var education_major_id = 0
    var gender = ""
    var iban_no = ""
    var maroof_link = ""
    var mobile_code = ""
    var profile_image = ""
    var user_id = 0
    var vat_number = ""
    var total_branch = 0
    var total_follower = 0
    var total_product = 0
    var total_likes = 0
    var country_flag = ""
    var phone_length = 0
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        phone_length <- map["phone_length"]
         country_flag <- map["country_flag"]
        total_branch <- map["total_branch"]
        total_follower <- map["total_follower"]
        total_product <- map["total_product"]
        total_likes <- map["total_likes"]
        mobile_number <- map["mobile_number"]
        company_name <- map["company_name"]
        cu_language <- map["cu_language"]
        email <- map["email"]
        fynoo_id <- map["fynoo_id"]
        id <- map["id"]
        name <- map["name"]
        user_type <- map["user_type"]
        mobile_length <- map["mobile_length"]
        username <- map["username"]
        bank_name <- map["bank_name"]
        city <- map["city"]
        city_id <- map["city_id"]
        country <- map["country"]
        country_id <- map["country_id"]
        is_new_user <- map["is_new_user"]
        dob <- map["dob"]
        education <- map["education"]
        education_id <- map["education_id"]
        education_major <- map["education_major"]
        education_major_id <- map["education_major_id"]
        gender <- map["gender"]
        maroof_link <- map["maroof_link"]
        mobile_code <- map["mobile_code"]
        profile_image <- map["profile_image"]
        user_id <- map["user_id"]
        iban_no <- map["iban_no"]
        vat_number <- map["vat_number"]
        
    }
    
}



class UserDetailss: NSObject {

  func getUserData(completion:@escaping(Bool, UserData?) -> ()) {
   
    let param  =  ["lang_code":HeaderHeightSingleton.shared.LanguageSelected,"user_id": Singleton.shared.getUserId()]
      
      print(param)
      ServerCalls.postRequest("\(Service.userProfileData)", withParameters: param) { (response, success) in
          if let value = response as? NSDictionary{
              let error = value.object(forKey: "error") as! Int
              if error == 0{
                  if let body = response as? [String: Any] {
                      
                      let inProgress  = Mapper<UserData>().map(JSON: body)
                      completion(true, inProgress)
                      return
                  }
                  completion(false,nil)
              }else{
                  let msg =  value.object(forKey: "error_description") as! String
                  ModalController.showNegativeCustomAlertWith(title: "", msg: msg)
                  completion(false, nil)
                  
              }
              
          }
      }
  }
}

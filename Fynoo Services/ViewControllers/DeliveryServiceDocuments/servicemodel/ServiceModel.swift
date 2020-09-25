//
//  ServiceModel.swift
//  Fynoo Services
//
//  Created by IND-SEN-LP-039 on 25/09/20.
//  Copyright © 2020 Aishwarya. All rights reserved.
//

import UIKit
import Foundation
import ObjectMapper

class ServiceModel: NSObject {
    func getservicedocument(completion:@escaping(Bool, SeviceDocument?) -> ()) {

           let str = "\(Service.getdocumentlist)"
           var userId = "\(AuthorisedUser.shared.user?.data?.id ?? 0)"

                       if userId == "0"{
                         userId = ""

                       }
        let parameters = ["lang_code": HeaderHeightSingleton.shared.LanguageSelected,"user_id":"308","primary_id":1] as [String : Any]
           print(str,parameters)
           ServerCalls.postRequest(str, withParameters: parameters) { (response, success) in


               if let value = response as? NSDictionary{
                   let error = value.object(forKey: "error") as! Int
                   if error == 0{
                       if let body = response as? [String: Any] {
                           let val = Mapper<SeviceDocument>().map(JSON: response as! [String : Any])
                           completion(true, val)
                           return
                       }
                       completion(false,nil)
                   }else{
                       completion(false, nil)

                   }

               }
           }
       }

}


struct SeviceDocument : Mappable {
    var error : Bool?
    var error_code : Int?
    var data : [SeviceDocumentData]?
    var error_description : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        error <- map["error"]
        error_code <- map["error_code"]
        data <- map["data"]
        error_description <- map["error_description"]
    }

}
struct SeviceDocumentData : Mappable {
    var new_upload_enable : Bool?
    var new_upload_id : Int?
    var id : Int?
    var user_id : Int?
    var national_id : String?
    var national_id_uploaded : Bool?
    var national_id_content : String?
    var driving_license : String?
    var driving_license_uploaded : Bool?
    var registration : String?
    var registration_uploaded : Bool?
    var registration_content : String?
    var insurance : String?
    var insurance_uploaded : Bool?
    var authorization : String?
    var authorization_uploaded : Bool?
    var authorization_content : String?
    var registration_type_id : Int?
    var registration_type : String?
    var vehicle_brand_id : Int?
    var vehicle_brand : String?
    var vehicle_name_id : Int?
    var vehicle_name : String?
    var production_year : String?
    var vehicle_color_id : Int?
    var vehicle_color : String?
    var vehicle_kind_id : Int?
    var vehicle_kind : String?
    var vehicle_kind_image : String?
    var maximum_load : String?
    var plate_no : String?
    var plate_no_min_length : Int?
    var plate_no_max_length : Int?
    var front_side : String?
    var reason_for_rejection : String?
    var reason_for_change : String?
    var status : Int?
    var status_value : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        new_upload_enable <- map["new_upload_enable"]
        new_upload_id <- map["new_upload_id"]
        id <- map["id"]
        user_id <- map["user_id"]
        national_id <- map["national_id"]
        national_id_uploaded <- map["national_id_uploaded"]
        national_id_content <- map["national_id_content"]
        driving_license <- map["driving_license"]
        driving_license_uploaded <- map["driving_license_uploaded"]
        registration <- map["registration"]
        registration_uploaded <- map["registration_uploaded"]
        registration_content <- map["registration_content"]
        insurance <- map["insurance"]
        insurance_uploaded <- map["insurance_uploaded"]
        authorization <- map["authorization"]
        authorization_uploaded <- map["authorization_uploaded"]
        authorization_content <- map["authorization_content"]
        registration_type_id <- map["registration_type_id"]
        registration_type <- map["registration_type"]
        vehicle_brand_id <- map["vehicle_brand_id"]
        vehicle_brand <- map["vehicle_brand"]
        vehicle_name_id <- map["vehicle_name_id"]
        vehicle_name <- map["vehicle_name"]
        production_year <- map["production_year"]
        vehicle_color_id <- map["vehicle_color_id"]
        vehicle_color <- map["vehicle_color"]
        vehicle_kind_id <- map["vehicle_kind_id"]
        vehicle_kind <- map["vehicle_kind"]
        vehicle_kind_image <- map["vehicle_kind_image"]
        maximum_load <- map["maximum_load"]
        plate_no <- map["plate_no"]
        plate_no_min_length <- map["plate_no_min_length"]
        plate_no_max_length <- map["plate_no_max_length"]
        front_side <- map["front_side"]
        reason_for_rejection <- map["reason_for_rejection"]
        reason_for_change <- map["reason_for_change"]
        status <- map["status"]
        status_value <- map["status_value"]
    }

}

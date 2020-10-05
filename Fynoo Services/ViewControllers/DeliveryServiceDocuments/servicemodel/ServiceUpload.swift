//
//  ServiceUpload.swift
//  Fynoo Services
//
//  Created by IND-SEN-LP-039 on 01/10/20.
//  Copyright © 2020 Aishwarya. All rights reserved.
//

import Foundation
import ObjectMapper

struct ServiceUpload : Mappable {
    var error : Bool?
    var error_code : Int?
    var data : ServiceUploadData?
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
struct ServiceUploadData : Mappable {
    var new_upload_enable : Bool?
    var new_upload_id : Int?
    var id : Int?
    var user_id : Int?
    var full_name : String?
    var iqama_no : String?
    var dob : String?
    var doe : String?
    var show_iqama_section : Bool?
    var iqama_length : Int?
    var national_id : String?
    var national_id_uploaded : Bool?
    var national_id_file_type : String?
    var national_id_file_size : Double?
    var national_id_content : String?
    var driving_license : String?
    var driving_license_uploaded : Bool?
    var driving_license_file_type : String?
    var driving_license_file_size : Double?
    var registration : String?
    var registration_uploaded : Bool?
    var registration_file_type : String?
    var registration_file_size : Double?
    var registration_content : String?
    var insurance : String?
    var insurance_uploaded : Bool?
    var insurance_file_type : String?
    var insurance_file_size : Double?
    var authorization : String?
    var authorization_uploaded : Bool?
    var authorization_file_type : String?
    var authorization_file_size : Double?
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
    var maximum_load_allowed : Int?
    var plate_no : String?
    var plate_no_min_length : Int?
    var plate_no_max_length : Int?
    var front_side : String?
    var front_side_file_type : String?
    var front_side_file_size : Double?
    var reason_for_rejection : String?
    var reason_for_change : String?
    var status : Int?
    var status_value : String?
    var note : String?
    var switch_vehicle : Bool?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        new_upload_enable <- map["new_upload_enable"]
        new_upload_id <- map["new_upload_id"]
        id <- map["id"]
        user_id <- map["user_id"]
        full_name <- map["full_name"]
        iqama_no <- map["iqama_no"]
        dob <- map["dob"]
        doe <- map["doe"]
        show_iqama_section <- map["show_iqama_section"]
        iqama_length <- map["iqama_length"]
        national_id <- map["national_id"]
        national_id_uploaded <- map["national_id_uploaded"]
        national_id_file_type <- map["national_id_file_type"]
        national_id_file_size <- map["national_id_file_size"]
        national_id_content <- map["national_id_content"]
        driving_license <- map["driving_license"]
        driving_license_uploaded <- map["driving_license_uploaded"]
        driving_license_file_type <- map["driving_license_file_type"]
        driving_license_file_size <- map["driving_license_file_size"]
        registration <- map["registration"]
        registration_uploaded <- map["registration_uploaded"]
        registration_file_type <- map["registration_file_type"]
        registration_file_size <- map["registration_file_size"]
        registration_content <- map["registration_content"]
        insurance <- map["insurance"]
        insurance_uploaded <- map["insurance_uploaded"]
        insurance_file_type <- map["insurance_file_type"]
        insurance_file_size <- map["insurance_file_size"]
        authorization <- map["authorization"]
        authorization_uploaded <- map["authorization_uploaded"]
        authorization_file_type <- map["authorization_file_type"]
        authorization_file_size <- map["authorization_file_size"]
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
        maximum_load_allowed <- map["maximum_load_allowed"]
        plate_no <- map["plate_no"]
        plate_no_min_length <- map["plate_no_min_length"]
        plate_no_max_length <- map["plate_no_max_length"]
        front_side <- map["front_side"]
        front_side_file_type <- map["front_side_file_type"]
        front_side_file_size <- map["front_side_file_size"]
        reason_for_rejection <- map["reason_for_rejection"]
        reason_for_change <- map["reason_for_change"]
        status <- map["status"]
        status_value <- map["status_value"]
        note <- map["note"]
        switch_vehicle <- map["switch_vehicle"]
    }

}

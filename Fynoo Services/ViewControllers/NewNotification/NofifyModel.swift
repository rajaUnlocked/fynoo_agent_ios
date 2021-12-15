//
//  NofifyModel.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-039 on 04/05/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import Foundation
import ObjectMapper

struct NofifyModel : Mappable {
    var error : Bool?
    var error_code : Int?
    var error_description : String?
    var data : NofifyModelData?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        error <- map["error"]
        error_code <- map["error_code"]
        error_description <- map["error_description"]
        data <- map["data"]
    }

}
struct NofifyModelData : Mappable {
    var unread_notif_count : Int?
    var new_order_count : Int?
    var notif_count : Int?
    var data_count : Int?
    var all_notif_list : [All_notif_list]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        unread_notif_count <- map["unread_notif_count"]
        new_order_count <- map["new_order_count"]
        notif_count <- map["notif_count"]
        data_count <- map["data_count"]
        all_notif_list <- map["all_notif_list"]
    }

}
struct All_notif_list : Mappable {
    var notif_category : String?
    var notif_list : [Notif_lists]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        notif_category <- map["notif_category"]
        notif_list <- map["notif_list"]
    }

}
struct Notif_lists : Mappable {
    var user_id : Int?
    var notification : String?
    var action_type : Int?
    var create_datetime : String?
    var create_datetime_str : String?
    var id : Int?
    var time : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        user_id <- map["user_id"]
        notification <- map["notification"]
        action_type <- map["action_type"]
        create_datetime <- map["create_datetime"]
        create_datetime_str <- map["create_datetime_str"]
        id <- map["id"]
        time <- map["time"]
    }

}

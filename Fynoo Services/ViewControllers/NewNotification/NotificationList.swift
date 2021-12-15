//
//  NotificationList.swift
//  Fynoo Business
//
//  Created by Preeti Rathore on 07/11/19.
//  Copyright © 2019 Sendan. All rights reserved.
//

import Foundation
struct NotificationList : Decodable {
let error : Bool?
let error_code : Int?
let error_description : String?
let data : Data_notification?
}
struct Data_notification : Decodable {
let unread_notif_count : Int?
let new_order_count : Int?
let notif_count : Int?
let notif_list : [Notif_list]?
}
struct Notif_list : Decodable {
let user_id : Int?
let notification : String?
let action_type : Int?
let create_datetime : String?
let create_datetime_str : String?
let id : Int?
}

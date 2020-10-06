//
//  TargetModel.swift
//  Fynoo Services
//
//  Created by IND-SEN-LP-039 on 08/09/20.
//  Copyright © 2020 Aishwarya. All rights reserved.
//

import UIKit
import Foundation
import ObjectMapper
class TargetModel: NSObject {
    func commisionlist(completion:@escaping(Bool, CommisionList?) -> ()) {

        let str = "\(Service.commisionlist)"
        var userId = "\(AuthorisedUser.shared.user?.data?.id ?? 0)"

                    if userId == "0"{
                      userId = ""

                    }
        let parameters = ["lang_code": HeaderHeightSingleton.shared.LanguageSelected,"user_id":"308"] as [String : Any]
        print(str,parameters)
        ServerCalls.postRequest(str, withParameters: parameters) { (response, success) in


            if let value = response as? NSDictionary{
                let error = value.object(forKey: "error") as! Int
                if error == 0{
                    if let body = response as? [String: Any] {
                        let val = Mapper<CommisionList>().map(JSON: response as! [String : Any])
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
    func targetlist(completion:@escaping(Bool, TargetList?) -> ()) {

           let str = "\(Service.targetlist)"
           var userId = "\(AuthorisedUser.shared.user?.data?.id ?? 0)"

                       if userId == "0"{
                         userId = ""

                       }
           let parameters = ["lang_code": HeaderHeightSingleton.shared.LanguageSelected,"user_id":"308"] as [String : Any]
           print(str,parameters)
           ServerCalls.postRequest(str, withParameters: parameters) { (response, success) in


               if let value = response as? NSDictionary{
                   let error = value.object(forKey: "error") as! Int
                   if error == 0{
                       if let body = response as? [String: Any] {
                           let val = Mapper<TargetList>().map(JSON: response as! [String : Any])
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



struct CommisionList : Mappable {
        var error : Bool?
        var error_code : Int?
        var error_description : String?
        var data : CommisionListData?

        init?(map: Map) {

        }

        mutating func mapping(map: Map) {

            error <- map["error"]
            error_code <- map["error_code"]
            error_description <- map["error_description"]
            data <- map["data"]
        }

    }
struct CommisionListData : Mappable {
    var id : Int?
    var top_content : String?
    var services : [Services]?
    var bottom_content : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["id"]
        top_content <- map["top_content"]
        services <- map["services"]
        bottom_content <- map["bottom_content"]
    }

}
struct Services : Mappable {
    var service_id : Int?
    var service_name : String?
    var service_description : String?
    var video_url : String?
    var video_file : String?
    var media_type : Int?
    var max_commision : Int?
    var min_commision : Int?
    var service_icon : String?
    var service_range :String?
    init?(map: Map) {

    }

    mutating func mapping(map: Map) {
         service_range <- map["service_range"]
         service_icon <- map["service_icon"]
        service_id <- map["service_id"]
        service_name <- map["service_name"]
        service_description <- map["service_description"]
        video_url <- map["video_url"]
        video_file <- map["video_file"]
        media_type <- map["media_type"]
        max_commision <- map["max_commision"]
        min_commision <- map["min_commision"]
    }

}

struct TargetList : Mappable {
    var error : Bool?
    var error_code : Int?
    var error_description : String?
    var data : TargetListData?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        error <- map["error"]
        error_code <- map["error_code"]
        error_description <- map["error_description"]
        data <- map["data"]
    }

}
struct TargetListData : Mappable {
    var total_target : Int?
    var target_to_be_achive : Int?
    var target_end_date : String?
    var id : Int?
    var top_content : String?
    var mid_content : String?
    var video_url : String?
    var video_file : String?
    var media_type : Int?
    var top_five_agent : [Top_five_agent]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {
        id <- map["id"]
        top_content <- map["top_content"]
        mid_content <- map["mid_content"]
        video_url <- map["video_url"]
        video_file <- map["video_file"]
        media_type <- map["media_type"]
        total_target <- map["total_target"]
        target_to_be_achive <- map["target_to_be_achive"]
        target_end_date <- map["target_end_date"]
        top_five_agent <- map["top_five_agent"]
    }

}


struct Top_five_agent : Mappable {
    var username : String?
    var currency : String?
    var commision_amount : Int?
    var user_icon:String?
    init?(map: Map) {

    }

    mutating func mapping(map: Map) {
         user_icon <- map["user_icon"]
        username <- map["username"]
        currency <- map["currency"]
        commision_amount <- map["commision_amount"]
    }

}

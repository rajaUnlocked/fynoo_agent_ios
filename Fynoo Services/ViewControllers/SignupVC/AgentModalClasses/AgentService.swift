//
//  AgentService.swift
//  Fynoo Business
//
//  Created by Sendan IT on 14/09/19.
//  Copyright © 2019 Sendan. All rights reserved.
//
//struct AgentService:Decodable {
//    var error:Bool
//    var data : [DAta]
//}
//
//struct DAta:Decodable{
//    var service_id:Int
//    var service_name:String
//    var service_icon:String
//
//    init(service_id:Int,service_name:String,service_icon:String) {
//        self.service_id = service_id
//      self.service_name = service_name
//        self.service_icon = service_icon
//    }
//
//}
struct AgentService:Decodable {
    
     let error : Bool?
     let error_description : String?
     let error_code : Int?
     let data : fynooAgentServices?
}

struct fynooAgentServices:Decodable {
    
 let services_list : [AgentServices_list]?
}

struct AgentServices_list:Decodable {
    let service_id : Int?
    let service_name : String?
    let service_icon : String?


}

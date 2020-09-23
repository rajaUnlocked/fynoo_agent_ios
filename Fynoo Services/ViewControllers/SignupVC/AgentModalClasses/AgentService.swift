//
//  AgentService.swift
//  Fynoo Business
//
//  Created by Sendan IT on 14/09/19.
//  Copyright © 2019 Sendan. All rights reserved.
//

struct AgentService:Decodable {
    
     let error : Bool?
     let error_description : String?
     let error_code : Int?
     let data : fynooAgentServices?
}

struct fynooAgentServices:Decodable {
    
    let services_list : [AgentServices_list]?
    let compare_code : String?
    let age_limit : String?
}

struct AgentServices_list:Decodable {
    let service_id : Int?
    let service_name : String?
    let service_icon : String?
    let service_code : String?


}

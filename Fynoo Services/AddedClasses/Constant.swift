//
//  Constant.swift
//  BaseProjectSwift
//                          
//  Created by Aishwarya
//  Copyright © 2019 Aishwarya. All rights reserved.
//
import UIKit

class Constant: NSObject {
    
    
//      static var BASE_URL : String = "http://43.241.61.141:9003/"
      //  static var BASE_URL : String = "http://43.241.61.141:9005/"
    
     static var BASE_URL : String = "http://61.95.220.248:9092/"
//      static var BASE_URL : String = "http://61.95.220.248:9095/"  //CLIENT URL FOR NOW
    
 
    static let getAppVersion : String = "common/getAppVersion/";
    
}

enum Service {
    static let userProfileData = Constant.BASE_URL + "businessapi/v1/GetUserDetails/"
      static let commisionlist = Constant.BASE_URL + "agentapis/v2/agent_commision/"
     static let targetlist = Constant.BASE_URL + "target_master_api/v2/target/"
}

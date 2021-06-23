//
//  CartModel.swift
//  Fynoo Services
//
//  Created by IND-SEN-LP-039 on 21/07/20.
//  Copyright © 2020 Aishwarya. All rights reserved.
//

import UIKit
import ObjectMapper

class AgentModel: NSObject {
   
    func getDistance(_ url:String, completion:@escaping(Bool, DistanceModelResponse) -> ()) {
        ServerCalls.getRequests(url) { (response, success) in
            if (response as? [String: Any]) != nil {
                    let distanceModelResponse = Mapper<DistanceModelResponse>().map(JSON: response as! [String : Any])
                completion(true, distanceModelResponse!)
                                return
                    }
            }
        
       }
    
}



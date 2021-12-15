//
//  NotificationApiModel.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-039 on 04/05/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit
import ObjectMapper

class NotificationApiModel: NSObject {
var notfid = ""
    var pageNo = 1
    func notifylist(completion:@escaping(Bool, NofifyModel?) -> ()) {
        
        let str = "\(Constant.BASE_URL)\(Constant.notiList)"
       
        let parameters = ["user_id":Singleton.shared.getUserId(),"lang_code": HeaderHeightSingleton.shared.LanguageSelected, "page_no":"\(pageNo)","user_type":"AGENT"]
        print(parameters)
        ServerCalls.postRequest(str, withParameters: parameters) { (response, success) in
            
            
            if let value = response as? NSDictionary{
                let error = value.object(forKey: "error") as! Int
                if error == 0{
                    if let body = response as? [String: Any] {
                        let val = Mapper<NofifyModel>().map(JSON: response as! [String : Any])
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
    
    func notifydeletelist(completion:@escaping(Bool, NSDictionary?) -> ()) {
        
        let str = "\(Constant.BASE_URL)\(Constant.notideleteList)"
       
        let parameters = ["user_id":Singleton.shared.getUserId(),"lang_code": HeaderHeightSingleton.shared.LanguageSelected, "notif_id":notfid]
        print(str,parameters)
        ServerCalls.postRequest(str, withParameters: parameters) { (response, success) in
            
            if let value = response as? NSDictionary{
                let error = value.object(forKey: "error") as! Int
                if error == 0{
                    if let body = response as? [String: Any] {
                      
                        completion(true, value)
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

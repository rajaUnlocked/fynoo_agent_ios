//
//  DataBankSellingProductModel.swift
//  Fynoo
//
//  Created by IND-SEN-LP-048 on 14/05/20.
//  Copyright © 2020 Aishwarya. All rights reserved.
//

import Foundation
import ObjectMapper

class DataBankSellingProductModel : NSObject{
    var catid = ""
    var subcatid = ""
    var searchval = ""
    var pageno = ""
    var pro_id = ""
    func productDetail(completion:@escaping(Bool, viewProductDetailNew?) -> ()) {
        var detail : viewProductDetailNew?
        var url = ""
        
        let  param = ["pro_id":pro_id,"lang_code":HeaderHeightSingleton.shared.LanguageSelected]
        url = Authentication.databankProductView
        print(url,param)
        ServerCalls.postRequest(url, withParameters: param, completion: { (response, success) in
            if let value = response as? NSDictionary{
                let error = value.object(forKey: "error") as! Int
                if error == 0{
                    if let body = response as? [String: Any] {
                        print(body)
                        detail = Mapper<viewProductDetailNew>().map(JSON: body)
                        completion(true, detail)
                        return
                    }
                    completion(false,nil)
                }else{
                    completion(false, nil)
                    
                }
            }
        })
    }
    func similarallproduct(completion:@escaping(Bool, SimilarDataSell?) -> ()) {
        
           var url = ""
           var userId = "\(AuthorisedUser.shared.user?.data?.id ?? 0)"

                if userId == "0" {
                    userId = ""
                  }
        let  param = ["cus_id":userId,"lang_code":HeaderHeightSingleton.shared.LanguageSelected,"category_id":catid,"sub_category_id":subcatid,"next_page_no":pageno,"search_value":searchval]
           url = Authentication.similaralllist
           print(url,param)
           ServerCalls.postRequest(url, withParameters: param, completion: { (response, success) in
               if let value = response as? NSDictionary{
                   let error = value.object(forKey: "error") as! Int
                   if error == 0{
                       if let body = response as? [String: Any] {
                          let detail = Mapper<SimilarDataSell>().map(JSON: body)
                           completion(true, detail)
                           return
                       }
                       completion(false,nil)
                   }else{
                       completion(false, nil)
                       
                   }
               }
           })
       }
 
    
}

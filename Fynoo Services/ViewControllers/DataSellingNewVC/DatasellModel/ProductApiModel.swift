//
//  ProductModel.swift
//  Fynoo
//
//  Created by IND-SEN-LP-039 on 12/05/20.
//  Copyright © 2020 Aishwarya. All rights reserved.
//

import UIKit
import ObjectMapper
class ProductApiModel: NSObject {
   var contentid = ""
    var contenttype = ""
    var pagno = 0
    static let shared = ProductApiModel()
    var subcataId:String = ""
    var productId:String = ""
    var displaytype:String = ""
    var actiontype = 0
    var lat = 0.0
    var long = 0.0
    var catid:String = ""
    var subcatid:String = ""
    var brandid:String = ""
    var country:String = ""
     var sortVal:String = ""
     var sortType:String = ""
     var search:String = ""
    var branchid:String = ""
    var filtercount = 0
   
    func getnameapi(completion:@escaping(Bool, NSDictionary?) -> ()) {
             
           let param  =  ["lang_code":HeaderHeightSingleton.shared.LanguageSelected,"content_id":contentid,"content_type":contenttype]
                 
                 print(param)
                 ServerCalls.postRequest("\(Constant.BASE_URL)\(Constant.contentname)", withParameters: param) { (response, success) in
                     if let value = response as? NSDictionary{
                         let error = value.object(forKey: "error") as! Int
                         if error == 0{
                             if let body = response as? [String: Any] {
                                 
                               completion(true, value)
                                 return
                             }
                             completion(false,nil)
                         }else{
                             let msg =  value.object(forKey: "error_description") as! String
                             ModalController.showNegativeCustomAlertWith(title: "", msg: msg)
                             completion(false, nil)
                             
                         }
                         
                     }
                 }
             }
   
    
  
}

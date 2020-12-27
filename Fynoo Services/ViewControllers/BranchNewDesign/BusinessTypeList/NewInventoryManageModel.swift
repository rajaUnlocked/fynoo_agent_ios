//
//  NewInventoryManageModel.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-048 on 20/02/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import Foundation
import ObjectMapper


class NewInventoryManageModel: NSObject {
  var branchid = ""
  var proId = ""
  var proUpdateQty = ""
 var flag = ""
    // Product List
       func getStockData(completion:@escaping(Bool, StockData?) -> ()) {
        let param  =  ["pro_id":proId,"lang_code":HeaderHeightSingleton.shared.LanguageSelected]
            print(param)
            ServerCalls.postRequest("\(Constant.BASE_URL)\(Constant.getStockDataNew)", withParameters: param) { (response, success) in
                if let value = response as? NSDictionary{
                    let error = value.object(forKey: "error") as! Int
                    if error == 0{
                        if let body = response as? [String: Any] {
                            
                            let stock_data  = Mapper<StockData>().map(JSON: body)
                            completion(true, stock_data)
                            return
                        }
                        completion(false,nil)
                    }else{
                        let msg =  value.object(forKey: "error_description") as! String
                        ModalController.showSuccessCustomAlertWith(title: "", msg: msg)
                        completion(false, nil)
                        
                    }
                    
                }
            }
        }
    func updateStock(completion:@escaping(Bool, updateStock?) -> ()) {
        let param  =  ["pro_id": proId, "pro_flag": flag , "pro_update_qty": proUpdateQty,"lang_code":HeaderHeightSingleton.shared.LanguageSelected]
           print(param)
           ServerCalls.postRequest("\(Constant.BASE_URL)\(Constant.updateStockData)", withParameters: param) { (response, success) in
               if let value = response as? NSDictionary{
                   let error = value.object(forKey: "error") as! Int
                   if error == 0{
                       if let body = response as? [String: Any] {
                           
                           let update  = Mapper<updateStock>().map(JSON: body)
                        let msg =  value.object(forKey: "error_description") as! String
                         ModalController.showSuccessCustomAlertWith(title: "", msg:msg )
                           completion(true, update)
                           return
                       }
                       completion(false,nil)
                   }else{
                       let msg =  value.object(forKey: "error_description") as! String
                       ModalController.showSuccessCustomAlertWith(title: "", msg: msg)
                       completion(false, nil)
                       
                   }
                   
               }
           }
       }
 
}

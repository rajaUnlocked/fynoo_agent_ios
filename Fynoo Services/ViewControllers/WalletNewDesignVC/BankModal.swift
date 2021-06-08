//
//  BankModal.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-046 on 22/02/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import Foundation
import ObjectMapper

class BankViewModal : NSObject{

    func getBankList(completion:@escaping(Bool, BankList?) -> ()) {

        let userid = AuthorisedUser.shared.user?.data?.id
        let param = ["user_id":"309","lang_code":HeaderHeightSingleton.shared.LanguageSelected]
        print(param)

        ServerCalls.postRequest(Service.BankList, withParameters: param, completion: { (response, success) in
            if let value = response as? NSDictionary{
                print(value)
                let error = value.object(forKey: "error") as! Int
                if error == 0{
                    if let body = response as? [String: Any] {
                        //print(body)
                       let  transactionLists = Mapper<BankList>().map(JSON: body)
                        completion(true, transactionLists)
                        return
                    }
                    completion(false,nil)
                }else{
                    completion(false, nil)
                    
                }
            }
        })
        
        
    }
    
    func TransferToBank(BankId:Int,remark:String,amount:Double,completion:@escaping(Bool, NSDictionary?) -> ()) {
        
        
        let userid = AuthorisedUser.shared.user?.data?.id
        let param = ["user_bank_id":"\(BankId)","remarks":remark,"amount":"\(amount)","user_id":"309","lang_code":HeaderHeightSingleton.shared.LanguageSelected]
        print(param)
        
        ServerCalls.postRequest(Service.transferApi, withParameters: param, completion: { (response, success) in
            if let value = response as? NSDictionary{
                print(value)
                let error = value.object(forKey: "error") as! Int
                if error == 0{
                
                    completion(true,value)
                }else{
                    completion(false, nil)
                    
                }
            }
        })
        
        
    }
    
    func AddToBank(BankId:Int,fullName:String,short_name:String,currency_id:Int,account_iban_nbr:String,confirm_account_iban_nbr:String,completion:@escaping(Bool, NSDictionary?) -> ()) {
           
       
        
           let userid = AuthorisedUser.shared.user?.data?.id
        let param = ["user_id":"\(309)","bank_id":"\(BankId)","full_name":"\(fullName)","short_name":short_name,"currency_id":"\(currency_id)","account_iban_nbr":account_iban_nbr,"confirm_account_iban_nbr":confirm_account_iban_nbr,"lang_code":HeaderHeightSingleton.shared.LanguageSelected]
           print(param)
           
           ServerCalls.postRequest(Service.AddBankDetailURL, withParameters: param, completion: { (response, success) in
               if let value = response as? NSDictionary{
                   print(value)
                   let error = value.object(forKey: "error") as! Int
                   if error == 0{
                   
                       completion(true,value)
                   }else{
                       completion(false, nil)
                       
                   }
               }
           })
           
           
       }
    
    func UpdateToBank(bankIdd:Int,BankId:Int,fullName:String,short_name:String,currency_id:Int,account_iban_nbr:String,confirm_account_iban_nbr:String,completion:@escaping(Bool, NSDictionary?) -> ()) {
             
          
            let userid = AuthorisedUser.shared.user?.data?.id
            let param = ["user_bank_id":"\(bankIdd)","user_id":"\(309)","bank_id":"\(BankId)","full_name":"\(fullName)","short_name":short_name,"currency_id":"\(currency_id)","account_iban_nbr":account_iban_nbr,"confirm_account_iban_nbr":confirm_account_iban_nbr,"lang_code":HeaderHeightSingleton.shared.LanguageSelected]
             print(param)
             
             ServerCalls.putRequest(Service.AddBankDetailURL, withParameters: param, completion: { (response, success) in
                 if let value = response as? NSDictionary{
                     print(value)
                     let error = value.object(forKey: "error") as! Int
                     if error == 0{
                     
                         completion(true,value)
                     }else{
                         completion(false, nil)
                         
                     }
                 }
             })
             
             
         }
    
    
}


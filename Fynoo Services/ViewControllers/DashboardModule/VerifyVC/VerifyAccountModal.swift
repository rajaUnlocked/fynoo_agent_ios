//
//  VerifyAccountModal.swift
//  Fynoo Business
//
//  Created by SENDAN on 17/09/19.
//  Copyright © 2019 Sendan. All rights reserved.
//

import Foundation


class VerifyAccountModal: NSObject{
    var verificationCode = ""
    var fynoo_id = ""
    
    
    func normalOPTVarificationValidation() -> (Bool, String) {
        var isFilled = false
        var message = ""
        
        if verificationCode == "" {
            return (isFilled, ValidationMessages.verifyOTP)
        }else{
            isFilled = true
            message = "get OTP Success"
        }
        return (isFilled, message)
    }

    
    func verifyOtp(completion:@escaping(Bool, String?) -> ()) {
        
        
        let param = ["fynoo_id":fynoo_id,"verification_code":verificationCode,"lang_code":HeaderHeightSingleton.shared.LanguageSelected]
        print(param)
        ServerCalls.postRequest(Authentication.verifyOtp, withParameters: param) { (response, success, resp) in
            ModalClass.stopLoading()
             let ResponseDict : NSDictionary = (response as? NSDictionary)!
            if let value = response as? NSDictionary{
                let msg = value.object(forKey: "error_description") as! String
                let error = value.object(forKey: "error_code") as! Int
                if error == 100{
                    completion(false,msg)
                }else{
                    AuthorisedUser.shared.setAuthorisedUser(with:response as Any)
                    
                     let results = (ResponseDict.object(forKey: "data") as! NSDictionary)
                    let userID:String = ModalController.toString(results.object(forKey: "id") as AnyObject)
                    Singleton.shared.setUserId(UserId: "\(userID)")
                    completion(true,msg)
                }
            }
        }
    }
    
    func resentVerificationOtp(completion:@escaping(Bool, String?) -> ()) {
        
        let param = ["fynoo_id":fynoo_id,"lang_code":HeaderHeightSingleton.shared.LanguageSelected]
        ServerCalls.postRequest(Authentication.resentVerifyOtp, withParameters: param) { (response, success, resp) in
            ModalClass.stopLoading()
            if let value = response as? NSDictionary{
                let msg = value.object(forKey: "error_description") as! String
                let error = value.object(forKey: "error_code") as! Int
                if error == 100{
                    completion(false,msg)
                }else{
                    
     //               AuthorisedUser.shared.setAuthorisedUser(with:response)
                    
                    completion(true,msg)
                }
            }
        }
    }

}

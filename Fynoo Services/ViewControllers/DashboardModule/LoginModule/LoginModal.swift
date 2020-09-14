//
//  LoginModal.swift
//  Fynoo Business
//
//  Created by SENDAN on 17/09/19.
//  Copyright © 2019 Sendan. All rights reserved.
//

import Foundation

class LoginModal : NSObject{
    
    var selectUserType = ""
    var email = ""
    var password = ""
    
    
    func normalLoginValidation() -> (Bool, String) {
        var isEmail = false
        var message = ""
        
        if selectUserType == "" {
            return (isEmail, ValidationMessages.loginUserType)
        }
        if email == "" {
            return (isEmail, "Please enter Email".localized)
        }
        
        let string  = email
        let num = Int(string);
        if num == nil {
       
            let value = ModalController.isValidEmail(testStr: email)
            if !value{
                return (isEmail, "Please enter valid Email".localized)
            }
        }
        
        if password == "" {
            return (isEmail, "Please enter password".localized)
        }else{
            isEmail = true
            message = "Login Success"
        }
        
        return (isEmail, message)
    }
    
    func loginOtp(completion:@escaping(Bool, NSDictionary?) -> ()) {
        
        let param = ["email":email,
                     "password":password,
                "user_type":selectUserType,
                "lang_code":HeaderHeightSingleton.shared.LanguageSelected]
        print(param)

        
        ServerCalls.postRequest(Authentication.login, withParameters: param) { (response, success, resp) in
            if let value = response as? NSDictionary{
                let msg = value.object(forKey: "error_description") as! String
                let error = value.object(forKey: "error_code") as! Int
                if error == 100{
                    
                        completion(false,value)
                }else{
                    
                    AuthorisedUser.shared.setAuthorisedUser(with:response as Any)
                    completion(true,value)
                }
            }else{
            ModalController.showNegativeCustomAlertWith(title: "Connection Error", msg: "")
            }
        }
    }
    
}

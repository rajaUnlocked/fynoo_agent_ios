//
//  ForgotPassword.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-048 on 07/10/19.
//  Copyright © 2019 Sendan. All rights reserved.
//

import Foundation
struct ForgotPassword : Decodable {
    let error : Bool?
    let error_description : String?
    let error_code : Int?
    let data : Data_Forgot_Pswd?
}
struct Data_Forgot_Pswd : Decodable {
    let mail_status : String?
    let fynoo_id : String?
}

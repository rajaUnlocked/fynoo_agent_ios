//
//  ResetPassword.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-048 on 07/10/19.
//  Copyright © 2019 Sendan. All rights reserved.
//

import Foundation
struct ResetPassword : Decodable {
    let error : Bool?
    let error_code : Int?
    let error_description : String?
    let data : Data_ResetPswd?
}
    
struct Data_ResetPswd : Decodable {
}


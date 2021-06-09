//
//  BankIdentifierListModal.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-040 on 10/04/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import Foundation


struct bankIdentifier_list:Decodable {
    
      let error : Bool?
     let error_code : Int?
     let error_description : String?
     let data : [bank_list]?
}

struct bank_list:Decodable {
    
    let id : Int?
    let bank_name : String?
    let bank_short_name : String?
    let identifier : String?
    
}

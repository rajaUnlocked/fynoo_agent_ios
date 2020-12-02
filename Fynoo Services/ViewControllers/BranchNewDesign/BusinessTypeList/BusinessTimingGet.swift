//
//  BusinessTimingGet.swift
//  Fynoo Business
//
//  Created by Sendan IT on 21/09/19.
//  Copyright © 2019 Sendan. All rights reserved.
//

import Foundation
struct BusinessTimingGet:Decodable {
    let error : Bool
    let error_code : Int
    let error_description : String
    let data : DatAA
    
    }
struct DatAA:Decodable {
let branch_timings_id : Int
    

}

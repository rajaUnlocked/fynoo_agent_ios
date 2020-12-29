//
//  BusinessTYPEList.swift
//  Fynoo Business
//
//  Created by Sendan IT on 17/09/19.
//  Copyright © 2019 Sendan. All rights reserved.
//

import Foundation
struct BusinessTYPEList:Decodable {
    let error : Bool?
    let error_code : Int?
    let error_description : String?
    let business_type : [Business_type]?
}
struct Business_type:Decodable {
    let id : Int
    let name : String
    let category : String
    let description : String

}

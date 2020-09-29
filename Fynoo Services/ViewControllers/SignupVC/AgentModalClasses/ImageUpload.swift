//
//  ImageUpload.swift
//  Fynoo Business
//
//  Created by Sendan IT on 24/09/19.
//  Copyright © 2019 Sendan. All rights reserved.
//

struct ImageUpload:Decodable {
    let error : Bool
    let error_code : Int
    let error_description : String
    let data : Data3?
}
struct Data3:Decodable{
    let image_id : Int
    let image_url:String?
}

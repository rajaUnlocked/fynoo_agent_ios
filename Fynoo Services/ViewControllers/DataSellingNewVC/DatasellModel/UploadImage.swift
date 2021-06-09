//
//  UploadImage.swift
//  Fynoo Business
//
//  Created by sanjay kumar on 16/01/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import Foundation
import ObjectMapper

struct UploadImage : Mappable {
    var error : Bool?
    var error_code : Int?
    var error_description : String?
    var data : UploadImageData?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        error <- map["error"]
        error_code <- map["error_code"]
        error_description <- map["error_description"]
        data <- map["data"]
    }

}
struct UploadImageData : Mappable {
    var image_id : Int?
    var image_url : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        image_id <- map["image_id"]
        image_url <- map["image_url"]
    }

}
struct UploadDocument : Mappable {
    var error : Bool?
    var error_code : Int?
    var error_description : String?
    var data : UploadDocumentData?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        error <- map["error"]
        error_code <- map["error_code"]
        error_description <- map["error_description"]
        data <- map["data"]
    }

}
struct UploadDocumentData : Mappable {
    var doc_id : Int?
    var doc_url : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        doc_id <- map["doc_id"]
        doc_url <- map["doc_url"]
    }

}

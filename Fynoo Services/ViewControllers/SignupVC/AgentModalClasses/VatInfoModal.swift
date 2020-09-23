//
//  VatInfoModal.swift
//  Fynoo Services
//
//  Created by IND-SEN-LP-040 on 23/09/20.
//  Copyright © 2020 Aishwarya. All rights reserved.
//

import Foundation
import ObjectMapper


class AgentVatInformationModal: NSObject {
   var AgentVatInfoData : VatInfoModal?
    
    func getAgentVatInfoApi(completion:@escaping(Bool, VatInfoModal?) -> ()) {
        var url = ""
        
        let param = [
                     "lang_code":HeaderHeightSingleton.shared.LanguageSelected,
            ] as [String : Any]
        
        url = "\(Constant.BASE_URL)\(Constant.vatInfo_Data)"

        print("Url:-", url)
        print(param)
        
        ServerCalls.postRequest(url, withParameters: param) { (response, success) in
            if let value = response as? NSDictionary{
                let msg = value.object(forKey: "error_description") as! String
                let error = value.object(forKey: "error_code") as! Int
                if error == 100 {
                    completion(false,nil)
                }else{
                    if let body = response as? [String: Any] {
                        
                        self.AgentVatInfoData = Mapper<VatInfoModal>().map(JSON: body)
                        completion(true, self.AgentVatInfoData)
                        return
                    }
                    completion(false,nil)
                }
            }
        }
    }
}


struct VatInfoModal : Mappable {
    
    var error : Bool?
    var error_code : Int?
    var error_description : String?
    var data : vatInfoDetail?
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        error <- map["error"]
        error_code <- map["error_code"]
        error_description <- map["error_description"]
        data <- map["data"]
    }
}

struct vatInfoDetail : Mappable {
    
    var vat_length : Int = 0
    var vat_file_size : Double = 0.0
    
    
    init?(map: Map) {
    }
    mutating func mapping(map: Map) {
        
        vat_length <- map["vat_length"]
        vat_file_size <- map["vat_file_size"]
    }
}


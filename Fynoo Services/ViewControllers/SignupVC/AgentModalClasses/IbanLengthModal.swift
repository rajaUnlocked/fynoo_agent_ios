//
//  IbanLengthModal.swift
//  Fynoo Services
//
//  Created by IND-SEN-LP-040 on 28/09/20.
//  Copyright © 2020 Aishwarya. All rights reserved.
//

import Foundation
import ObjectMapper

class AgentIbanLengthModal: NSObject {
   var AgentIBANInfoData : IbanLengthInfoModal?
    
    func getAgentIbanInfoApi(CountryCode:String, completion:@escaping(Bool, IbanLengthInfoModal?) -> ()) {
        var url = ""
        
        let param = [
                     "lang_code":HeaderHeightSingleton.shared.LanguageSelected,
                     "country_code":CountryCode,
            ] as [String : Any]
        
        url = "\(Constant.BASE_URL)\(Constant.IBANLengthInfo_Data)"

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
                        
                        self.AgentIBANInfoData = Mapper<IbanLengthInfoModal>().map(JSON: body)
                        completion(true, self.AgentIBANInfoData)
                        return
                    }
                    completion(false,nil)
                }
            }
        }
    }
}


struct IbanLengthInfoModal : Mappable {
    
    var error : Bool?
    var error_code : Int?
    var error_description : String?
    var data : IbanInfoDetail?
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        error <- map["error"]
        error_code <- map["error_code"]
        error_description <- map["error_description"]
        data <- map["data"]
    }
}

struct IbanInfoDetail : Mappable {
    
    var id : Int = 0
    var bank_no_type : String = ""
    var bank_number_length : Int = 0
    
    init?(map: Map) {
    }
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        bank_no_type <- map["bank_no_type"]
        bank_number_length <- map["bank_number_length"]
    }
}


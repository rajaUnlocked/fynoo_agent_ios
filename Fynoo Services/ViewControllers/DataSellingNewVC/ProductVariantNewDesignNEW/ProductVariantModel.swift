//
//  ProductVariantModel.swift
//  Fynoo
//
//  Created by IND-SEN-LP-048 on 06/06/20.
//  Copyright © 2020 Aishwarya. All rights reserved.
//

import Foundation
import ObjectMapper




class ProductVariantModel: NSObject {
       
     var proId = ""
    
    func getProductVariantList(completion:@escaping(Bool, ProductVariantListModel?) -> ()) {
     
     var str = ""
  
         str = Authentication.productVariantList

     var param = [String:Any]()
   
 
        param  =  ["pro_id": proId,"bo_user_id":Singleton.shared.getUserId(),"lang_code":HeaderHeightSingleton.shared.LanguageSelected]

     
         print(str)
       print(param)
         ServerCalls.postRequest(str, withParameters: param) { (response, success) in
               ModalClass.stopLoading()
             if let value = response as? NSDictionary{
                 let error = value.object(forKey: "error") as! Int
                if error == 0{
                     if let body = response as? [String: Any] {
                         
                         let product_list  = Mapper<ProductVariantListModel>().map(JSON: body)
                         completion(true, product_list)
                         
                         return
                     }
                     completion(false,nil)
                 }else{
                     completion(false, nil)
                     
                 }
                 
             }
         }
     }


 
}

class ProductVariantListModel : Mappable {
    var error : Bool?
    var error_code : Int?
    var error_description : String?
    var data : Data_VarientList?

    required init?(map: Map) {

    }

    func mapping(map: Map) {

        error <- map["error"]
        error_code <- map["error_code"]
        error_description <- map["error_description"]
        data <- map["data"]
    }

}
class Data_VarientList : Mappable {
    var pro_id : Int?
    var pro_image : String?
    var pro_name : String?
    var pro_avg_rating : Int?
    var pro_raters : String?
    var pro_price : String?
    var pro_currency_code : String?
    var pro_variant : [Pro_variant_list]?

    required init?(map: Map) {

    }

    func mapping(map: Map) {

        pro_id <- map["pro_id"]
        pro_image <- map["pro_image"]
        pro_name <- map["pro_name"]
        pro_avg_rating <- map["pro_avg_rating"]
        pro_raters <- map["pro_raters"]
        pro_price <- map["pro_price"]
        pro_currency_code <- map["pro_currency_code"]
        pro_variant <- map["pro_variant"]
    }

}

class Pro_variant_list : Mappable {
    var filter_icon : String?
    var filter_id : Int?
    var filter : String?
    var filter_value : String?
    var variant_filter_list : [Variant_filter_list]?

    required init?(map: Map) {

    }

    func mapping(map: Map) {

        filter_icon <- map["filter_icon"]
        filter_id <- map["filter_id"]
        filter <- map["filter"]
        filter_value <- map["filter_value"]
        variant_filter_list <- map["variant_filter_list"]
    }

}
class Variant_filter_list : Mappable {
    var pro_id : Int?
    var filter_value : String?
    var pro_stock : Int?

    required init?(map: Map) {

    }

    func mapping(map: Map) {

        pro_id <- map["pro_id"]
        filter_value <- map["filter_value"]
        pro_stock <- map["pro_stock"]
    }

}

//
//  DataBankSellingListModel.swift
//  Fynoo
//
//  Created by IND-SEN-LP-048 on 12/05/20.
//  Copyright © 2020 Aishwarya. All rights reserved.
//

import Foundation

import ObjectMapper

class DataBankSellingListModel : NSObject{
    var pageno = ""
    var filterid = ""
    var search = ""
    var issearchfrom = ""
    func getDataBankSellingList(completion:@escaping(Bool, DataBankSellingList?) -> ()) {
        
        var list : DataBankSellingList?
        var url = ""
        var dataprice = ""
        var filtercount = 0
        var userId = "\(AuthorisedUser.shared.user?.data?.id ?? 0)"

                     if userId == "0"{
                       userId = ""

                     }
        let pro = ProductModel.shared
        if pro.datapriceselltemp.count > 0
                      {
                      for item in pro.datapriceselltemp{
                              dataprice = "\(item),\(dataprice)"
                          }
                        filtercount = filtercount + 1
                          dataprice.removeLast()
                      }
        if pro.numsoldselltemp.count > 0
        {
          filtercount = filtercount + 1
        }
       if pro.numphotoselltemp.count > 0
              {
                filtercount = filtercount + 1
              }
        if pro.cataIdselltemp.count > 0
               {
                 filtercount = filtercount + 1
               }
        if pro.subcataIdselltemp.count > 0
               {
                 filtercount = filtercount + 1
               }
        if pro.daterangesell.count > 0
               {
                 filtercount = filtercount + 1
               }
        if pro.statusselltemp.count > 0
                      {
                        filtercount = filtercount + 1
                      }
        pro.salecount = filtercount
     
        let  param = ["user_id":userId,"lang_code":HeaderHeightSingleton.shared.LanguageSelected,"next_page_no":pageno,"filter_pks":filterid,"search_value":search,"is_search_from":issearchfrom] as [String : Any]
        url = Authentication.dataBankSelling
        print(url,param)
        ServerCalls.postRequest(url, withParameters: param, completion: { (response, success) in
            if let value = response as? NSDictionary{
                let error = value.object(forKey: "error") as! Int
                if error == 0{
                    if let body = response as? [String: Any] {
                        print(body)
                        list = Mapper<DataBankSellingList>().map(JSON: body)
                        completion(true, list)
                        return
                    }
                    completion(false,nil)
                }else{
                    completion(false, nil)
                    
                }
            }
        })
    }
    
 func getDataBankSellingFilter(completion:@escaping(Bool, DatasellingFilter?) -> ()) {
      let url = Authentication.dataBankSellingfilter
         var dataprice = ""
          var filtercount = 0
          var userId = "\(AuthorisedUser.shared.user?.data?.id ?? 0)"

                       if userId == "0"{
                         userId = ""

                       }
          let pro = ProductModel.shared
          if pro.datapricesell.count > 0
                        {
                        for item in pro.datapricesell{
                                dataprice = "\(item),\(dataprice)"
                            }
                        
                            dataprice.removeLast()
                        }
         
        
         
     let  param = ["user_id":userId,"lang_code":HeaderHeightSingleton.shared.LanguageSelected,"DATA_PRICE":dataprice,"NO_OF_SOLD":pro.numsoldsell,"NO_OF_PHOTOS":pro.numphotosell,"CATEGORY":pro.cataIdsell,"SUBCATEGORY":pro.subcataIdsell,"DATE_OF_CREATION":pro.daterangesell,"STATUS":pro.statussell
] as [String : Any]
     print(url,param)
     ServerCalls.postRequest(url, withParameters: param, completion: { (response, success) in
         if let value = response as? NSDictionary{
             let error = value.object(forKey: "error") as! Int
             if error == 0{
                 if let body = response as? [String: Any] {
                     let filterval = Mapper<DatasellingFilter>().map(JSON: body)
                     completion(true, filterval)
                     return
                 }
                 completion(false,nil)
             }else{
                 completion(false, nil)
                 
             }
         }
     })
 }
    
}


struct DatasellingFilter : Mappable {
    var error : Bool?
    var error_code : Int?
    var error_description : String?
    var data : DatasellingFilterData?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        error <- map["error"]
        error_code <- map["error_code"]
        error_description <- map["error_description"]
        data <- map["data"]
    }

}
struct DatasellingFilterData : Mappable {
    var primary_primary_keyss : String?
    var filter_count : Int?
    var filters : [Filterslist]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        primary_primary_keyss <- map["primary_keys"]
        filter_count <- map["filter_count"]
        filters <- map["filters"]
    }

}

struct Filterslist : Mappable {
    var filter_id : Int?
    var filter_code : String?
    var filter_name : String?
    var filter_description : String?
    var radio_list : [Radio_listfilter]?
    var complex_radio_list : [Complex_Radio_listfilter]?
    var checkbox_item : [Checkbox_itemfilter]?
    var range_list : String?
    var view_type : String?
    var is_selected : Bool?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        filter_id <- map["filter_id"]
        filter_code <- map["filter_code"]
        filter_name <- map["filter_name"]
        filter_description <- map["filter_description"]
        radio_list <- map["radio_list"]
        complex_radio_list <- map["complex_radio_list"]
        checkbox_item <- map["checkbox_item"]
        range_list <- map["range_list"]
        view_type <- map["view_type"]
        is_selected <- map["is_selected"]
    }

}
struct Checkbox_itemfilter : Mappable {
    var key : String?
    var value : Double?
 var is_selected :Bool?
    init?(map: Map) {

    }

    mutating func mapping(map: Map) {
      is_selected <- map["is_selected"]
        key <- map["key"]
        value <- map["value"]
    }

}
struct Radio_listfilter : Mappable {
    var key : String?
    var value : Int?
 var is_selected :Bool?
    init?(map: Map) {

    }

    mutating func mapping(map: Map) {
      is_selected <- map["is_selected"]
        key <- map["key"]
        value <- map["value"]
    }

}
struct Complex_Radio_listfilter : Mappable {
    var key : String?
    var value : Int?
     var is_selected :Bool?
    var value_list : [ComplexRadiofilter]?
    init?(map: Map) {

    }

    mutating func mapping(map: Map) {
          is_selected <- map["is_selected"]
           value_list <- map["value_list"]
        key <- map["key"]
        value <- map["value"]
    }

}
struct ComplexRadiofilter : Mappable {
    var key : String?
    var value : Int?
    var is_selected :Bool?
    init?(map: Map) {

    }

    mutating func mapping(map: Map) {
          is_selected <- map["is_selected"]
        key <- map["key"]
        value <- map["value"]
    }

}

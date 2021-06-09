//
//  FilterModel.swift
//  Fynoo
//
//  Created by IND-SEN-LP-039 on 13/06/20.
//  Copyright © 2020 Aishwarya. All rights reserved.
//

import Foundation
import ObjectMapper

struct FilterModel : Mappable {
    var error : Bool?
    var error_code : Int?
    var error_description : String?
    var data : FilterModelData?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        error <- map["error"]
        error_code <- map["error_code"]
        error_description <- map["error_description"]
        data <- map["data"]
    }

}

struct FilterModelData : Mappable {
    var filters : [Filters]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        filters <- map["filters"]
    }

}
struct Filters : Mappable {
    var filter_code : String?
    var filter_id : Int?
    var radio_list : [radiolist]?
    var complexcheckbox_item : [complexcheckbox_item]?
    var checkbox_item : [checkboxitem]?
    var cat_radio_list : [Cat_radio_list]?
    var range_list : String?
    var selected_range_list : String?
    var filter_name : String?
    var view_type : String?
  var is_selected :Bool?
    init?(map: Map) {

    }

    mutating func mapping(map: Map) {
          selected_range_list <- map["selected_range_list"]
         is_selected <- map["is_selected"]
       cat_radio_list <- map["cat_radio_list"]
        filter_code <- map["filter_code"]
        filter_id <- map["filter_id"]
        radio_list <- map["radio_list"]
        complexcheckbox_item <- map["complexcheckbox_item"]
        checkbox_item <- map["checkbox_item"]
        range_list <- map["range_list"]
        filter_name <- map["filter_name"]
        view_type <- map["view_type"]
    }

}
struct checkboxitem : Mappable {
    var name : String?
     var id : Int?
    var filter_brand_id : Int?
      var is_selected :Bool?
    init?(map: Map) {

    }

    mutating func mapping(map: Map) {
         filter_brand_id <- map["filter_brand_id"]
        name <- map["name"]
        id <- map["id"]
         is_selected <- map["is_selected"]
    }

}
struct radiolist : Mappable {
    var key : String?
     var value : Int?
    var is_selected :Bool?
    init?(map: Map) {

    }

    mutating func mapping(map: Map) {
        value <- map["value"]
        key <- map["key"]
        is_selected <- map["is_selected"]
    }

}
struct complexcheckbox_item : Mappable {
    var group_name : String?
     var list : [list]?
    init?(map: Map) {

    }

    mutating func mapping(map: Map) {
        group_name <- map["group_name"]
        list <- map["list"]
    }

}
struct list : Mappable {
    var name : String?
     var id : Int?
    var is_selected : Bool?
    init?(map: Map) {

    }

    mutating func mapping(map: Map) {
          is_selected <- map["is_selected"]
        name <- map["name"]
        id <- map["id"]
    }

}
struct Cat_radio_list : Mappable {
    var name : String?
    var filter_cat_id : Int?
    var sub_cat_list : [Sub_cat_list1]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        name <- map["name"]
        filter_cat_id <- map["filter_cat_id"]
        sub_cat_list <- map["sub_cat_list"]
    }

}

struct Sub_cat_list1 : Mappable {
    var name : String?
    var filter_sub_cat_id : Int?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        name <- map["name"]
        filter_sub_cat_id <- map["filter_sub_cat_id"]
    }

}

// filter api
class FilterApi: NSObject {
    var branchid = ""
    var catid = ""
      var subcatid = ""
     var brandid = ""
      var displaytype = ""
      var actiontype = ""
       var discount = ""
       var dropship = ""
       var like = ""
         var price = ""
       var filtercatid = ""
       var filtersubcatid = ""
    var brandarr = NSMutableArray()
    var avail = NSMutableArray()
     var payment = NSMutableArray()
func getfilterlist(completion:@escaping(Bool, FilterModel?) -> ()) {
    var available = ""
    var paymentmethod = ""
   
    var filterbrandid = ""
    if brandarr.count > 0
           {
               for item in  brandarr{
                   filterbrandid = "\(item),\(filterbrandid)"
               }
               filterbrandid.removeLast()
           }
    if avail.count > 0
             {
                 for item in  avail{
                     available = "\(item),\(available)"
                 }
                 available.removeLast()
             }
    if payment.count > 0
                {
                    for item in  payment{
                        paymentmethod = "\(item),\(paymentmethod)"
                    }
                    paymentmethod.removeLast()
                }

      var userId = "\(AuthorisedUser.shared.user?.data?.id ?? 0)"

            if userId == "0"{
              userId = ""

            }
        let url = "\(Constant.BASE_URL)\(Constant.getproductlistfilter)"
        let param  =  ["lang_code":"\(HeaderHeightSingleton.shared.LanguageSelected)",
            "branch_id":branchid,
            "cat_id":catid,
            "display_type": displaytype,
            "action_type":actiontype,
            "sub_cat_id":subcatid,
            "brand_id":brandid,
            "lat":HeaderHeightSingleton.shared.latitude,
            "long":HeaderHeightSingleton.shared.longitude,
            "DISCOUNT":discount,
            "DROP_SHIPPING":dropship,
            "LIKES_RANGE":like,
            "AVAILABILITY":available,
            "PAYMENT_MODE":paymentmethod,
            "PRICE":price,
            "filter_cat_id":filtercatid,
            "filter_sub_cat_id":filtersubcatid,
            "filter_brand_id":filterbrandid] as [String : Any]
        print(param)
        
        ServerCalls.postRequest(url, withParameters: param) { (response, success) in
            if let value = response as? NSDictionary{
                let error = value.object(forKey: "error") as! Int
                if error == 0{
                    if let body = response as? [String: Any] {
                        
                        let inProgress  = Mapper<FilterModel>().map(JSON: body)
                        completion(true, inProgress)
                        return
                    }
                    completion(false,nil)
                }else{
                    let msg =  value.object(forKey: "error_description") as! String
                    ModalController.showSuccessCustomAlertWith(title: "", msg: msg)
                    completion(false, nil)
                    
                }
                
            }
        }
    }
}


 
struct orderFilterModel : Mappable {
    var error : Bool?
    var error_code : Int?
    var error_description : String?
    var data : OrderFilterData?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        error <- map["error"]
        error_code <- map["error_code"]
        error_description <- map["error_description"]
        data <- map["data"]
    }

}
struct OrderFilterData : Mappable {
    
    var filter_list : [orderFilterList]?
    var primary_keys : String?
    

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        filter_list <- map["filter_list"]
        primary_keys <- map["primary_keys"]
       
  
    }

}
struct orderFilterList : Mappable {
    
    var code = ""
    var desc = ""
    var extra_value = ""
    var desc_ar = ""
    
    var child : [childFilter]?
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        code <- map["code"]
        desc <- map["desc"]
        extra_value <- map["extra_value"]
        desc_ar <- map["desc_ar"]
         child <- map["child"]
        
    }
    
}
struct childFilter : Mappable {
    
    var value_min = 0
    var value_max = 0
    var value_name = ""
    var value = ""
    
    var child : [childFilter]?
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        value_min <- map["value_min"]
        value_max <- map["value_max"]
        value_name <- map["value_name"]
        value <- map["value"]
        
    }
    
}

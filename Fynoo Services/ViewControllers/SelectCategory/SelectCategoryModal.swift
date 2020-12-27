//
//  SelectCategoryModal.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-046 on 19/02/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import Foundation
import ObjectMapper

class SelectCategory : NSObject{
    
    var catId = ""
    var serviceId = ""
    var serviceType = ""
    func getSelectCategory(completion:@escaping(Bool, CategoryList?) -> ()) {
        
        
        let userid:UserData = AuthorisedUser.shared.getAuthorisedUser()
        let param  =  ["lang_code":"\(HeaderHeightSingleton.shared.LanguageSelected)"]
        print(param)
         
    ServerCalls.postRequest(Service.selectCategory, withParameters: param) { (response, success) in
        if let value = response as? NSDictionary{
            let error = value.object(forKey: "error") as! Int
            if error == 0{
                if let body = response as? [String: Any] {
                    
                    let inProgress  = Mapper<CategoryList>().map(JSON: body)
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
    
    
    func getSelectSubCategory(completion:@escaping(Bool, SubCategoryList?) -> ()) {
        
        
        let userid:UserData = AuthorisedUser.shared.getAuthorisedUser()
        let param  =  ["lang_code":"\(HeaderHeightSingleton.shared.LanguageSelected)","category_id":catId]
        print(param)
        
        ServerCalls.postRequest(Service.selectSubCategory, withParameters: param) { (response, success) in
            if let value = response as? NSDictionary{
                let error = value.object(forKey: "error") as! Int
                if error == 0{
                    if let body = response as? [String: Any] {
                        
                        let inProgress  = Mapper<SubCategoryList>().map(JSON: body)
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



//Modal Class

class CategoryList : Mappable {
    var error = ""
    var error_code  = ""
    var error_description = ""
    var data : categoryData?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        
        error <- map["error"]
        error_code <- map["error_code"]
        error_description <- map["error_description"]
        data <- map["data"]
    }
    
}
class categoryData : Mappable{
    
    var cat_list : [cat_List]?
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        
        cat_list <- map["cat_list"]
    }
}

class cat_List : Mappable {
    
    var cat_id  = 0
    var cat_name  = ""
    var cat_desc  = ""
    var category_image  = ""
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        cat_id <- map["cat_id"]
        cat_name <- map["cat_name"]
        cat_desc <- map["cat_desc"]
        category_image <- map["category_image"]
        
    }
    
}


class SubCategoryList : Mappable {
    var error = ""
    var error_code  = ""
    var error_description = ""
    var data : SubcategoryData?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        
        error <- map["error"]
        error_code <- map["error_code"]
        error_description <- map["error_description"]
        data <- map["data"]
    }
    
}
class SubcategoryData : Mappable {
    
    var sub_cat_list : [sub_cat_List]?
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        
        sub_cat_list <- map["sub_cat_list"]
    }
}

class sub_cat_List : Mappable {
    
    var sub_cat_id  = 0
    var sub_cat_name  = ""
    var sub_cat_desc  = ""
    var category_image  = ""
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        sub_cat_id <- map["sub_cat_id"]
        sub_cat_desc <- map["sub_cat_desc"]
        sub_cat_name <- map["sub_cat_name"]
        category_image <- map["category_image"]
        
    }
    
}

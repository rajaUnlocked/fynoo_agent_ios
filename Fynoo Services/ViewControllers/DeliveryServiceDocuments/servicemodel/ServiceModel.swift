//
//  ServiceModel.swift
//  Fynoo Services
//
//  Created by IND-SEN-LP-039 on 25/09/20.
//  Copyright © 2020 Aishwarya. All rights reserved.
//

import UIKit
import Foundation
import ObjectMapper


class ServiceModel: NSObject {
     var vehicleId = 1
    var isType = 1
    var imgname = ""
    var imgfilereg:UIImage?
    var imgfile:UIImage?
    var docfilereg:URL?
    var docfile:URL?
    var primaryid = 0
    var username = ""
    var dob = ""
    var iqmano = ""
    var edob = ""
      var regtype = ""
      var vehicleBrand = ""
      var vehiclename = ""
      var productionyear = ""
      var vehiclecolor = ""
      var VehicleKind = ""
      var maxload = ""
      var platnumber = ""
      var reasonchange = ""
     var sendforapproval = ""
   
    func getvehicleName(completion:@escaping(Bool, VehicleName?) -> ()) {
         
                    let str = "\(Service.getvehiclename)"
                    var userId = "\(AuthorisedUser.shared.user?.data?.id ?? 0)"

                                if userId == "0"{
                                  userId = ""

                                }
                 let parameters = ["lang_code": HeaderHeightSingleton.shared.LanguageSelected,"vehicle_brand_id":vehicleId] as [String : Any]
                    print(str,parameters)
                    ServerCalls.postRequest(str, withParameters: parameters) { (response, success) in


                        if let value = response as? NSDictionary{
                            let error = value.object(forKey: "error") as! Int
                            if error == 0{
                                if let body = response as? [String: Any] {
                                    let val = Mapper<VehicleName>().map(JSON: response as! [String : Any])
                                    completion(true, val)
                                    return
                                }
                                completion(false,nil)
                            }else{
                                completion(false, nil)

                            }

                        }
                    }
                }
    func getvehicleKind(completion:@escaping(Bool, VehicleKind?) -> ()) {

                 let str = "\(Service.getvehiclekind)"
                 var userId = "\(AuthorisedUser.shared.user?.data?.id ?? 0)"

                             if userId == "0"{
                               userId = ""

                             }
              let parameters = ["lang_code": HeaderHeightSingleton.shared.LanguageSelected,"registration_type_id":1] as [String : Any]
                 print(str,parameters)
                 ServerCalls.postRequest(str, withParameters: parameters) { (response, success) in


                     if let value = response as? NSDictionary{
                         let error = value.object(forKey: "error") as! Int
                         if error == 0{
                             if let body = response as? [String: Any] {
                                 let val = Mapper<VehicleKind>().map(JSON: response as! [String : Any])
                                 completion(true, val)
                                 return
                             }
                             completion(false,nil)
                         }else{
                             completion(false, nil)

                         }

                     }
                 }
             }
        func uploadImage(completion:@escaping(Bool, SeviceDocument?) -> ()) {
            let str = "\(Service.uploadimage)"
            var userId = "\(AuthorisedUser.shared.user?.data?.id ?? 0)"

                                       if userId == "0"{
                                         userId = ""

                                       }
            let parameters =
            ["lang_code":HeaderHeightSingleton.shared.LanguageSelected,
               "user_id":userId,
               "primary_id":primaryid,
               "full_name":username,
               "dob":dob,
               "iqama_no":iqmano,
               "doe":edob,
               //Send primary_id in case of edit
               "registration_type":regtype,
               "vehicle_brand":vehicleBrand,
               "vehicle_name":vehiclename,
               "production_year":productionyear,
               "vehicle_color":vehiclecolor,
               "vehicle_kind":VehicleKind,
               "maximum_load":maxload,
               "plate_no":platnumber,
               "reason_for_change":reasonchange,
                "send_for_approval":sendforapproval
            

] as [String : Any]
            if isType == 1
                           {
                    imgname = "national_id"
                           }
             else if isType == 2
                    {
             imgname = "driving_license"
                    }
            else if isType == 3
                   {
            imgname = "car_registration"
                   }
            else if isType == 4
                   {
            imgname = "car_insurance"
                   }
            else if isType == 5
                   {
            imgname = "driving_authorization"
                   }
            else if isType == 6
                              {
                       imgname = "front_side"
                              }
               print(str,parameters,imgname
            )
            if isType > 6
            {
             ServerCalls.postRequest(str, withParameters: parameters) { (response, success) in


                         if let value = response as? NSDictionary{
                             let error = value.object(forKey: "error") as! Int
                             if error == 0{
                                 if let body = response as? [String: Any] {
                                     let val = Mapper<SeviceDocument>().map(JSON: response as! [String : Any])
                                     completion(true, val)
                                     return
                                 }
                                 completion(false,nil)
                             }else{
                                ModalController.showNegativeCustomAlertWith(title: value.object(forKey: "error_description") as! String, msg: "")
                                 completion(false, nil)

                             }

                         }
                     }
                
            }
    else if docfile == nil
    {
       
            ServerCalls.fileUploadAPINew(inputUrl: str, parameters: parameters, imageName: imgname, imageFile: imgfile!) { (response, success, resp) in
    
                   if let value = response as? NSDictionary{
    
                           if let body = response as? [String: Any] {
                            if self.isType == 5
                            {
                            let val = Mapper<SeviceDocument>().map(JSON: response as! [String : Any])
                               completion(true, val)
                            
                                ServerCalls.fileUploadAPINew(inputUrl: str, parameters: parameters, imageName: "car_registration", imageFile: self.imgfilereg!) { (response, success, resp) in
                    
                                   if let value = response as? NSDictionary{
                    
                                           if let body = response as? [String: Any] {
                                            let val = Mapper<SeviceDocument>().map(JSON: response as! [String : Any])
                                               completion(true, val)
                                            
                                               return
                                           }
                                           completion(false,nil)
                    
                                   }
                                   }
                               }
                            else{
                                let val = Mapper<SeviceDocument>().map(JSON: response as! [String : Any])
                                   completion(true, val)
                                return
                            }
                              
                           }
                           completion(false,nil)
    
    
                   }
               }
            }
    else{
          var pfurl : String? = docfile?.absoluteString
        ServerCalls.PdfFileUpload(inputUrl: str, parameters: parameters, pdfname: imgname, pdfurl: pfurl ?? "") { (response, success, resp) in
                 
                 if let value = response as? NSDictionary{
    
                         if let body = response as? [String: Any] {
                            if self.isType == 5
                            {
                                var pfurl : String? = self.docfilereg?.absoluteString
                              ServerCalls.PdfFileUpload(inputUrl: str, parameters: parameters, pdfname: "car_registration", pdfurl: pfurl ?? "") { (response, success, resp) in
                                       
                                       if let value = response as? NSDictionary{
                                          
                                               if let body = response as? [String: Any] {
                                                  let val = Mapper<SeviceDocument>().map(JSON: response as! [String : Any])
                                                   completion(true, val)
                                                   return
                                               }
                                               completion(false,nil)
                                          
                                           
                                       }
                                   }
                            }
                            else
                            {
                            let val = Mapper<SeviceDocument>().map(JSON: response as! [String : Any])
                             completion(true, val)
                             return
                            }
                         }
                         completion(false,nil)
                    
                     
                 }
             }
            }
           }
    
    func getservicetypecolor(completion:@escaping(Bool, TypeBrandColor?) -> ()) {

              let str = "\(Service.gettypecolor)"
              var userId = "\(AuthorisedUser.shared.user?.data?.id ?? 0)"

                          if userId == "0"{
                            userId = ""

                          }
           let parameters = ["lang_code": HeaderHeightSingleton.shared.LanguageSelected] as [String : Any]
              print(str,parameters)
              ServerCalls.postRequest(str, withParameters: parameters) { (response, success) in


                  if let value = response as? NSDictionary{
                      let error = value.object(forKey: "error") as! Int
                      if error == 0{
                          if let body = response as? [String: Any] {
                              let val = Mapper<TypeBrandColor>().map(JSON: response as! [String : Any])
                              completion(true, val)
                              return
                          }
                          completion(false,nil)
                      }else{
                          completion(false, nil)

                      }

                  }
              }
          }
    func getservicedocument(completion:@escaping(Bool, SeviceDocument?) -> ()) {

           let str = "\(Service.getdocumentlist)"
           var userId = "\(AuthorisedUser.shared.user?.data?.id ?? 0)"

                       if userId == "0"{
                         userId = ""

                       }
        let parameters = ["lang_code": HeaderHeightSingleton.shared.LanguageSelected,"user_id":userId,"primary_id":primaryid] as [String : Any]
           print(str,parameters)
           ServerCalls.postRequest(str, withParameters: parameters) { (response, success) in


               if let value = response as? NSDictionary{
                   let error = value.object(forKey: "error") as! Int
                   if error == 0{
                       if let body = response as? [String: Any] {
                           let val = Mapper<SeviceDocument>().map(JSON: response as! [String : Any])
                           completion(true, val)
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

struct VehicleName : Mappable {
    var error : Bool?
    var error_code : Int?
    var error_description : String?
    var data : VehicleNameData?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        error <- map["error"]
        error_code <- map["error_code"]
        error_description <- map["error_description"]
        data <- map["data"]
    }

}
struct VehicleNameData : Mappable {
    var vehicle_kind : [Brand]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        vehicle_kind <- map["vehicle_kind"]
    }

}

//vehicle kind
struct VehicleKind : Mappable {
    var error : Bool?
    var error_code : Int?
    var error_description : String?
    var data : VehicleKindData?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        error <- map["error"]
        error_code <- map["error_code"]
        error_description <- map["error_description"]
        data <- map["data"]
    }

}
struct VehicleKindData : Mappable {
    var vehicle_kind : [Vehicle_kind]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        vehicle_kind <- map["vehicle_kind"]
    }

}
struct Vehicle_kind : Mappable {
    var id : Int?
    var name : String?
    var image : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["id"]
        name <- map["name"]
        image <- map["image"]
    }

}


//type color
struct TypeBrandColor : Mappable {
    var error : Bool?
    var error_code : Int?
    var error_description : String?
    var data : TypeBrandColorData?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        error <- map["error"]
        error_code <- map["error_code"]
        error_description <- map["error_description"]
        data <- map["data"]
    }

}
struct TypeBrandColorData : Mappable {
    var registration_type : [Registration_type]?
    var brand : [Brand]?
    var vehicle_color : [Vehicle_color]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        registration_type <- map["registration_type"]
        brand <- map["brand"]
        vehicle_color <- map["vehicle_color"]
    }

}
struct Brand : Mappable {
    var id : Int?
    var name : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["id"]
        name <- map["name"]
    }

}
struct Vehicle_color : Mappable {
    var id : Int?
    var name : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["id"]
        name <- map["name"]
    }

}
struct Registration_type : Mappable {
    var id : Int?
    var name : String?
    var year_count : Int?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["id"]
        name <- map["name"]
        year_count <- map["year_count"]
    }

}




struct SeviceDocument : Mappable {
   var error : Bool?
       var error_code : Int?
       var data : SeviceDocumentData?
       var error_description : String?

       init?(map: Map) {

       }

       mutating func mapping(map: Map) {

           error <- map["error"]
           error_code <- map["error_code"]
           data <- map["data"]
           error_description <- map["error_description"]
       }

   }

struct SeviceDocumentData : Mappable  {
    var new_upload_enable : Bool?
    var new_upload_id : Int?
    var id : Int?
    var user_id : Int?
    var full_name : String?
    var iqama_no : String?
    var dob : String?
    var doe : String?
    var show_iqama_section : Bool?
    var iqama_length : Int?
    var national_id : String?
    var national_id_uploaded : Bool?
    var national_id_file_type : String?
    var national_id_file_size : Int?
    var national_id_content : String?
    var driving_license : String?
    var driving_license_uploaded : Bool?
    var driving_license_file_type : String?
    var driving_license_file_size : Int?
    var registration : String?
    var registration_uploaded : Bool?
    var registration_file_type : String?
    var registration_file_size : Int?
    var registration_content : String?
    var insurance : String?
    var insurance_uploaded : Bool?
    var insurance_file_type : String?
    var insurance_file_size : Int?
    var authorization : String?
    var authorization_uploaded : Bool?
    var authorization_file_type : String?
    var authorization_file_size : Int?
    var authorization_content : String?
    var registration_type_id : Int?
    var registration_type : String?
    var vehicle_brand_id : Int?
    var vehicle_brand : String?
    var vehicle_name_id : Int?
    var vehicle_name : String?
    var production_year : String?
    var vehicle_color_id : Int?
    var vehicle_color : String?
    var vehicle_kind_id : Int?
    var vehicle_kind : String?
    var vehicle_kind_image : String?
    var maximum_load : String?
    var plate_no : String?
    var plate_no_min_length : Int?
    var plate_no_max_length : Int?
    var maximum_load_allowed : Int?
    var front_side : String?
    var front_side_file_type : String?
    var front_side_file_size : Int?
    var reason_for_rejection : String?
    var reason_for_change : String?
    var status : Int?
    var status_value : String?
    var note : String?
    var switch_vehicle : Bool?
     var notes : String?
    init?(map: Map) {

    }

    mutating func mapping(map: Map) {
        maximum_load_allowed <- map["maximum_load_allowed"]
          notes <- map["notes"]
        new_upload_enable <- map["new_upload_enable"]
        new_upload_id <- map["new_upload_id"]
        id <- map["id"]
        user_id <- map["user_id"]
        full_name <- map["full_name"]
        iqama_no <- map["iqama_no"]
        dob <- map["dob"]
        doe <- map["doe"]
        show_iqama_section <- map["show_iqama_section"]
        iqama_length <- map["iqama_length"]
        national_id <- map["national_id"]
        national_id_uploaded <- map["national_id_uploaded"]
        national_id_file_type <- map["national_id_file_type"]
        national_id_file_size <- map["national_id_file_size"]
        national_id_content <- map["national_id_content"]
        driving_license <- map["driving_license"]
        driving_license_uploaded <- map["driving_license_uploaded"]
        driving_license_file_type <- map["driving_license_file_type"]
        driving_license_file_size <- map["driving_license_file_size"]
        registration <- map["registration"]
        registration_uploaded <- map["registration_uploaded"]
        registration_file_type <- map["registration_file_type"]
        registration_file_size <- map["registration_file_size"]
        registration_content <- map["registration_content"]
        insurance <- map["insurance"]
        insurance_uploaded <- map["insurance_uploaded"]
        insurance_file_type <- map["insurance_file_type"]
        insurance_file_size <- map["insurance_file_size"]
        authorization <- map["authorization"]
        authorization_uploaded <- map["authorization_uploaded"]
        authorization_file_type <- map["authorization_file_type"]
        authorization_file_size <- map["authorization_file_size"]
        authorization_content <- map["authorization_content"]
        registration_type_id <- map["registration_type_id"]
        registration_type <- map["registration_type"]
        vehicle_brand_id <- map["vehicle_brand_id"]
        vehicle_brand <- map["vehicle_brand"]
        vehicle_name_id <- map["vehicle_name_id"]
        vehicle_name <- map["vehicle_name"]
        production_year <- map["production_year"]
        vehicle_color_id <- map["vehicle_color_id"]
        vehicle_color <- map["vehicle_color"]
        vehicle_kind_id <- map["vehicle_kind_id"]
        vehicle_kind <- map["vehicle_kind"]
        vehicle_kind_image <- map["vehicle_kind_image"]
        maximum_load <- map["maximum_load"]
        plate_no <- map["plate_no"]
        plate_no_min_length <- map["plate_no_min_length"]
        plate_no_max_length <- map["plate_no_max_length"]
        front_side <- map["front_side"]
        front_side_file_type <- map["front_side_file_type"]
        front_side_file_size <- map["front_side_file_size"]
        reason_for_rejection <- map["reason_for_rejection"]
        reason_for_change <- map["reason_for_change"]
        status <- map["status"]
        status_value <- map["status_value"]
        note <- map["note"]
        switch_vehicle <- map["switch_vehicle"]
    }

}


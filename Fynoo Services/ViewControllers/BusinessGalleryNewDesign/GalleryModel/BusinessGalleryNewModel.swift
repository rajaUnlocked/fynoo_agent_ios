//
//  BusinessGalleryNewModel.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-048 on 03/03/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import Foundation
import ObjectMapper


class BusinessGalleryNewModel: NSObject {

  

  
 
   var img_type = ""
   var imgfile = [UIImage]()
   var uploadimg:GalleryImage?
    
   var imgIds = ""
  var branchName = ""
    var toDate = ""
    var fromDate = ""
    var image_name = ""
    var imageType = ""
    var searchText = ""

    var pageNo = 0
    // Business Gallery List
    func getBusinessGalleryList(completion:@escaping(Bool, BusinessGalleryList?) -> ()) {
        let param  =  ["user_id":Singleton.shared.getUserId(),"from_date":"","to_date":"","image_type":imageType,"lang_code":HeaderHeightSingleton.shared.LanguageSelected,"next_page_no":"\(pageNo)","search_val": searchText] as [String : Any]
        print(param)
        ServerCalls.postRequest("\(Constant.BASE_URL)\(Constant.businessGalleryList)", withParameters: param) { (response, success) in
            if let value = response as? NSDictionary{
                let error = value.object(forKey: "error") as! Int
                if error == 0{
                    if let body = response as? [String: Any] {
                        
                        let gallery_list  = Mapper<BusinessGalleryList>().map(JSON: body)
                        completion(true, gallery_list)
                        return
                    }
                    completion(false,nil)
                }else{
                    //                        let msg =  value.object(forKey: "error_description") as! String
                    //                        ModalController.showSuccessCustomAlertWith(title: "", msg: msg)
                    completion(false, nil)
                    
                }
                
            }
        }
    }
    func uploadGalleryImg(completion:@escaping(Bool, GalleryImage?) -> ()) {
        
        let str = "\(Constant.BASE_URL)\(Constant.uploadGalleryImg)"
        let parameters =
            ["image_name": image_name,"img_type":imageType,
         "user_id":Singleton.shared.getUserId(),"lang_code": HeaderHeightSingleton.shared.LanguageSelected] as [String : Any]

        print(parameters)

        ServerCalls.fileUploadAPINewMultipleImage(inputUrl: str, parameters: parameters, imageName: "images[]", imageFile: imgfile) { (response, success, resp) in
            
            if (response as? NSDictionary) != nil{
                
                if (response as? [String: Any]) != nil {
                    self.uploadimg = Mapper<GalleryImage>().map(JSON: response as! [String : Any])
                  
                    ModalController.showSuccessCustomAlertWith(title: "Image uploaded Successfully", msg: "")
                    completion(true, self.uploadimg)
                    return
                }
                completion(false,nil)
                
                
            }
        }


//
//        let parameters =
//            ["image_name": branchName,
//             "user_id":Singleton.shared.getUserId(),"lang_code": HeaderHeightSingleton.shared.LanguageSelected] as [String : Any]
//
//        print(parameters)
//
//        ServerCalls.fileUploadAPINew(inputUrl: str, parameters: parameters, imageName: "image", imageFile: imgfile) { (response, success, resp) in
//
//            if (response as? NSDictionary) != nil{
//
//                if (response as? [String: Any]) != nil {
//                    self.uploadimg = Mapper<GalleryImage>().map(JSON: response as! [String : Any])
//                    completion(true, self.uploadimg)
//                    return
//                }
//                completion(false,nil)
//
//
//            }
//        }
    }
    
    // delete gallery
    func deleteBusinessGalleryImg(completion:@escaping(Bool, DeleteBusinessGallery?) -> ()) {
        let param  =  ["image_ids": imgIds,"lang_code": HeaderHeightSingleton.shared.LanguageSelected]
        print(param)
        ServerCalls.postRequest("\(Constant.BASE_URL)\(Constant.deleteBusinessGallery)", withParameters: param) { (response, success) in
            if let value = response as? NSDictionary{
                let error = value.object(forKey: "error") as! Int
                if error == 0{
                    if let body = response as? [String: Any] {
                        
                        let delete_gallery  = Mapper<DeleteBusinessGallery>().map(JSON: body)
                        let msg =  value.object(forKey: "error_description") as! String
                        ModalController.showSuccessCustomAlertWith(title: "", msg: msg)
                        completion(true, delete_gallery)
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

//
        

    }
    // filter gallery
    func galleryFilter(completion:@escaping(Bool, BusinessGalleryList?) -> ()) {
        
        let param  =  ["from_date":fromDate,"to_date":toDate,"profile_img":"" , "product_img":"" , "branch_img":"" , "user_ids":"" , "bo_id": "309","lang_code": HeaderHeightSingleton.shared.LanguageSelected]
        print(param)
        
        ServerCalls.postRequest("\(Constant.BASE_URL)\(Constant.filterGallery)", withParameters: param) { (response, success) in
            if let value = response as? NSDictionary{
                let error = value.object(forKey: "error") as! Int
                if error == 0{
                    if let body = response as? [String: Any] {
                        
                        let filter_gallery  = Mapper<BusinessGalleryList>().map(JSON: body)
                        completion(true, filter_gallery)
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
    func galleryFilterList(completion:@escaping(Bool, galleryFilterList?) -> ()) {
        
        let param  =  ["bo_id": "309","lang_code":HeaderHeightSingleton.shared.LanguageSelected]
        print(param)
        
        ServerCalls.postRequest("\(Constant.BASE_URL)\(Constant.filterList)", withParameters: param) { (response, success) in
            if let value = response as? NSDictionary{
                let error = value.object(forKey: "error") as! Int
                if error == 0{
                    if let body = response as? [String: Any] {
                        
                        let list  = Mapper<galleryFilterList>().map(JSON: body)
                        completion(true, list)
                        return
                    }
                    completion(false,nil)
                }else{
//                    let msg =  value.object(forKey: "error_description") as! String
//                    ModalController.showSuccessCustomAlertWith(title: "", msg: msg)
                    completion(false, nil)
                    
                }
                
            }
        }
    }
    
}

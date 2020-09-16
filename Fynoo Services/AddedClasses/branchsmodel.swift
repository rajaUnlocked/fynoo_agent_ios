//
//  BranchModel.swift
//  Fynoo Business
//
//  Created by sanjay kumar on 14/01/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import Foundation
import ObjectMapper

class branchsmodel:NSObject {
    var vatnumber = ""
    var specialbranch = ""
    var pfurl:URL?
    var indeximg = 0
    var isproduct = false
    var branchfrom = "Branch"
   
    var uploadimg:UploadImage?
    var uploaddoc:UploadDocument?
    var imageType = ""
    var imgfile = UIImage()
    var mediaId = ""
    var branchid = ""
    var status = "0"
    var lat = 0.0
    var long = 0.0
    var sortType = ""
    var sortValue = ""
      var searchTxt = ""
    var fromgallery = false
    var galleryid = ""
    var contentid = ""
    var contenttype = ""
    var imgtype = ""
    let lang = UserDefaults.standard.object(forKey: "AppleLanguages") as! Array<String>
    // get API

    func vatlength(completion:@escaping(Bool, NSDictionary?) -> ()) {
        
        let str = "\(Constant.BASE_URL)\(Constant.vatlengthlist)"
        
        let parameters = ["lang_code": HeaderHeightSingleton.shared.LanguageSelected]
        print(str,parameters)
        ServerCalls.postRequest(str, withParameters: parameters) { (response, success) in
            
            
            if let value = response as? NSDictionary{
                let error = value.object(forKey: "error") as! Int
                if error == 0{
                    if let body = response as? [String: Any] {
                        completion(true, value)
                        return
                    }
                    completion(false,nil)
                }else{
                    completion(false, nil)
                    
                }
                
            }
        }
    }
//    func uploadImage(completion:@escaping(Bool, UploadImage?) -> ()) {
//           var str = ""
//            str = "\(Constant.BASE_URL)\(Constant.uploadBranchImage)"
//        if fromgallery
//               {
//               str = "\(Constant.BASE_URL)\(Constant.uploadgalleryImage)"
//               }
//           var parameters =
//           ["image_from":branchfrom,"image_type":imageType,"branch_id":AddBranch.shared.BranchId,
//            "user_id":Singleton.shared.getUserId(),"lang_code": HeaderHeightSingleton.shared.LanguageSelected] as [String : Any]
//           if isproduct
//           {
//             parameters["is_featured"] = true
//              parameters["index"] = indeximg
//           }
//           else{
//            parameters["is_featured"] = false
//                 parameters["index"] = indeximg
//           }
//           
//           print(str,parameters)
//           
//           ServerCalls.fileUploadAPINew(inputUrl: str, parameters: parameters, imageName: "image", imageFile: imgfile) { (response, success, resp) in
//               
//               if let value = response as? NSDictionary{
//                  
//                       if let body = response as? [String: Any] {
//                           self.uploadimg = Mapper<UploadImage>().map(JSON: response as! [String : Any])
//                           completion(true, self.uploadimg)
//                           return
//                       }
//                       completion(false,nil)
//                  
//                   
//               }
//           }
//       }
}


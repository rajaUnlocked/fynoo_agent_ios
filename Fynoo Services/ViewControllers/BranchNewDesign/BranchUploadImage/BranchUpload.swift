//
//  BranchUpload.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-046 on 01/04/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import Foundation
import ObjectMapper

class BranchUploadss : NSObject{
    
    var imageType = ""
    var branchId = ""
    var mediaId = ""
    
    func showGallery(completion:@escaping(Bool, ShowImageList?) -> ()) {
        
        let str = "\(Constant.BASE_URL)\(Constant.showimglist)"
    
            let parameters =
                ["image_type":imageType,"branch_id":branchId,
                        "user_id":Singleton.shared.getUserId(),"lang_code": HeaderHeightSingleton.shared.LanguageSelected]
        
        print("url\(str)\n param \(parameters)")
        ServerCalls.postRequest(str, withParameters: parameters) { (response, success) in
            
            if let value = response as? NSDictionary{
                let error = value.object(forKey: "error") as! Int
                if error == 0{
                    if let body = response as? [String: Any] {
                        let howimgList = Mapper<ShowImageList>().map(JSON: response as! [String : Any])
                        completion(true, howimgList)
                        return
                    }
                    completion(false,nil)
                }else{
                    completion(false, nil)
                    
                }
                
            }
        }
    }
    
    func deleteImg(completion:@escaping(Bool, NSDictionary?) -> ()) {
        
        let str = "\(Constant.BASE_URL)\(Constant.deleteImg)"
        let parameters = [
            "image_from":"branch",
            "media_id":mediaId,"lang_code": HeaderHeightSingleton.shared.LanguageSelected
            ] as [String : Any]
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
    
    func saveGallery(completion:@escaping(Bool, NSDictionary?) -> ()) {
        
        let str = "\(Constant.BASE_URL)\(Constant.branchStoreSave)"
    
            let parameters =
                ["img_ids":mediaId,"branch_id":branchId,
                        "user_id":Singleton.shared.getUserId(),"lang_code": HeaderHeightSingleton.shared.LanguageSelected]
        
        print("url\(str)\n param \(parameters)")
        ServerCalls.postRequest(str, withParameters: parameters) { (response, success) in
            
            if let value = response as? NSDictionary{
                let error = value.object(forKey: "error") as! Int
                if error == 0{
                    completion(true,value)
                }else{
                    completion(false, nil)
                    
                }
                
            }
        }
    }
}

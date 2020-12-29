//
//  BranchModel.swift
//  Fynoo Business
//
//  Created by sanjay kumar on 04/12/19.
//  Copyright © 2019 Sendan. All rights reserved.
//

import Foundation
import UIKit
class AddBranchModel : NSObject{
    var latitude = 0.0
    var longitude = 0.0
    var City = ""
    var Country = ""
    var ZipCode = ""
    var platformtype = ""
    var  medianew = ""
    var imageId = ""
    var Video = ""
    var locationLbl = ""
    var str = ""
    var image_type = ""
    var videoUrl:URL?
    var selImg:UIImage?
    var thumnail:UIImage?
    var imgParam = [String:String]()
    var imgStr = ""
    var videoParam = [String:Any]()
    var videoStr = ""
    var imgName = ""
    var selectId = ""
    var ismain = ""
    var formstep = ""
    var branchdetail:BranchDetail?
      var is24Open:Int?
       var isClose:Int?
       var timing =  [Business_timings]()
       var slot =  [SlotArrayList1]()
    var selectedCheck = AddBranch.shared.displayId
    var SelectedIndex1:NSMutableArray = AddBranch.shared.SelectedCheck
    //var array1:NSMutableDictionary = AddBranch.shared.BTimeDict
     var days = ["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]
    func getBranch(completion:@escaping(Bool, NSDictionary?) -> ()) {
        if AddBranch.shared.BType.count > 0
        {
            medianew.removeAll()
            for item in AddBranch.shared.BType{
                medianew = "\(item),\(medianew)"
            }
            medianew.removeLast()
        }
        if AddBranch.shared.showImgId.count > 0
        {
            for item in AddBranch.shared.showImgId{
                imageId = "\(item),\(imageId)"
            }
            imageId.removeLast()
        }
       
       if AddBranch.shared.platformType.count > 0
              {
                platformtype.removeAll()
                  for item in AddBranch.shared.platformType{
                      platformtype = "\(item),\(platformtype)"
                  }
                  platformtype.removeLast()
              }
          str = "\(Constant.BASE_URL)\(Constant.addbranch)"
        if AddBranch.shared.BranchId.count > 0
        {
           str = "\(Constant.BASE_URL)\(Constant.updateBranch)"
        }
      
       
         
         
        let branch = AddBranch.shared
        var branchrequest = AddBRANCH(agent_id: Singleton.shared.getUserId(), special_main_branch: branch.isSpecial, user_id:Singleton.shared.getBoId(),branch_id: branch.BranchId, branch_logo: branch.branchLogoId, business_name: branch.bName, mobile_code: branch.mobileCode, is_main_branch: branch.ismain == false ? "0":"1", mobile_no: branch.MobileNo, phone_code: branch.phoneCode, phone_no: branch.Phone, description: branch.Descrip, business_type_id: medianew, email: branch.mail, whats_app_mob_code: branch.whatsappCode, whats_app_number: branch.whatsappNumber, platform_type: platformtype, branch_location: branch.location, latitude: "\(branch.lat)", longitude:  "\(branch.long)", branch_images: imageId, video_url: branch.video_url, address_type_id: branch.addTypeId, zip_code: branch.ZipCode, country: branch.Country, state: branch.State, area: branch.area, city: branch.City, address_master_id: "\(AddBranch.shared.BusId)", other_name: AddBranch.shared.BusName, location_details: branch.addTypeId == "9" ? branch.locationdetails : "", time_display_style: "\(branch.displayId)", lang_code: HeaderHeightSingleton.shared.LanguageSelected, branch_status:"0", branch_timings_id: branch.timingId, business_timings: branch.BTimeDict)
      
       let data = try! JSONEncoder().encode(branchrequest.self)
                         let string = String(data: data, encoding: .utf8)!
                         print(string)
      ServerCalls.postRequestRAW(str, JsonString: string) { (response, success,resp) in
            if let value = response as? NSDictionary{
                let error = value.object(forKey: "error") as! Int
                
                    if let body = response as? [String: Any] {
                        
                        completion(true, value)
                        return
                    }
               else{
                    completion(false, nil)
                    
                }
                
            }
        }
    }
 
}


struct AddBRANCH:Encodable {
    let agent_id:String?
    let special_main_branch : String?
    let user_id : String?
    let branch_id:String?
    var branch_logo :String?
    let business_name : String?
    let mobile_code : String?
    let is_main_branch:String?
    let mobile_no : String?
    let phone_code : String?
    let phone_no : String?
    let description : String?
    let business_type_id : String?
    let email : String?
    let whats_app_mob_code : String?
    let whats_app_number : String?
    let platform_type : String?
    let branch_location : String?
    let latitude : String?
    let longitude : String?
    let branch_images : String?
    let video_url : String?
    let address_type_id : String?
    let zip_code : String?
    let country : String?
    let state : String?
    let area : String?
    let city : String?
    let address_master_id : String?
    let other_name : String?
    let location_details : String?
    let time_display_style : String?
    let lang_code : String?
    let branch_status : String?
    let branch_timings_id : String?
    let business_timings : [Business_timings]?
}
struct Business_timings:Encodable {
    let dayName : String?
    let is24Open : Int?
    let isClose : Int?
    let slotArrayList : [SlotArrayList1]?
}
struct SlotArrayList1:Encodable{
    let time_slot : String?
}

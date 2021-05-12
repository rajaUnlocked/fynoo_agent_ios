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
    var pfurl:URL?
    var indeximg = 0
    var isproduct = false
    var branchfrom = "Branch"
//    var platformType:PlatFormType?
//    var displaytype:DisplayType?
 var uploadimg:UploadImage?

    var uploaddoc:UploadDocument?
//    var showimgList:ShowImageList?
    var imageType = ""
    var imgfile = UIImage()
    var mediaId = ""
    var branchid = ""
    var status = "0"
//    var branchlogo:UploadBranchLogo?
//    var branchdetail:BranchDetailList?
//    var timing =  [Business_timings]()
//    var slot =  [SlotArrayList1]()
//    var branchlist:NewBranchList?
//    var descriplist:DescriptionValueList?
    var lat = 0.0
    var long = 0.0
    var sortType = ""
    var sortValue = ""
      var searchTxt = ""
    let lang = UserDefaults.standard.object(forKey: "AppleLanguages") as! Array<String>
    // get API
  
    
    //post api
    
    func uploadImage(completion:@escaping(Bool, UploadImage?) -> ()) {
  let userid:UserData = AuthorisedUser.shared.getAuthorisedUser()
        let str = "\(Constant.BASE_URL)\(Constant.uploaddatabankimage)"

        var parameters = [
            "image_from":"DataBank",
            "user_id":(userid.data?.id)!,
        "index":indeximg,
        "lang_code":"en"] as [String : Any]

       if isproduct
       {
        parameters["is_featured"] = true
        }
       else{
         parameters["is_featured"] = false
        }
        print(parameters)

        ServerCalls.fileUploadAPINew(inputUrl: str, parameters: parameters, imageName: "image", imageFile: imgfile) { (response, success, resp) in

            if let value = response as? NSDictionary{

                    if let body = response as? [String: Any] {
                        self.uploadimg = Mapper<UploadImage>().map(JSON: response as! [String : Any])
                        completion(true, self.uploadimg)
                        return
                    }
                    completion(false,nil)


            }
        }
    }
    func uploadDocumentImage(completion:@escaping(Bool, UploadDocument?) -> ()) {

         let str = "\(Constant.BASE_URL)\(Constant.pdfupload)"
        let userid:UserData = AuthorisedUser.shared.getAuthorisedUser()
        let parameters = ["user_id":(userid.data?.id)!, "image_from":"databank","lang_code": HeaderHeightSingleton.shared.LanguageSelected] as [String : Any]
         print(parameters)

         ServerCalls.fileUploadAPINew(inputUrl: str, parameters: parameters, imageName: "document", imageFile: imgfile) { (response, success, resp) in

             if let value = response as? NSDictionary{

                     if let body = response as? [String: Any] {
                          self.uploaddoc = Mapper<UploadDocument>().map(JSON: response as! [String : Any])
                         completion(true, self.uploaddoc)
                         return
                     }
                     completion(false,nil)


             }
         }
     }
    func uploadPdfImage(completion:@escaping(Bool, UploadDocument?) -> ()) {

        let str = "\(Constant.BASE_URL)\(Constant.pdfupload)"
               let userid:UserData = AuthorisedUser.shared.getAuthorisedUser()
               let parameters = ["user_id":(userid.data?.id)!, "image_from":"databank","lang_code": HeaderHeightSingleton.shared.LanguageSelected] as [String : Any]

        ServerCalls.PdfFileUpload(inputUrl: str, parameters: parameters, pdfname: "document", pdfurl: pfurl!) { (response, success, resp) in

            if let value = response as? NSDictionary{

                    if let body = response as? [String: Any] {
                        self.uploaddoc = Mapper<UploadDocument>().map(JSON: response as! [String : Any])
                        completion(true, self.uploaddoc)
                        return
                    }
                    completion(false,nil)


            }
        }
    }
//    func uploadBranchLogo(completion:@escaping(Bool, UploadBranchLogo?) -> ())
//    {
//
//        let str = "\(Constant.BASE_URL)\(Constant.addbranchlogo)"
//        var parameters = [String:String]()
//               if AddBranch.shared.BranchId == ""
//               {
//          parameters = ["user_id":Singleton.shared.getUserId(),"lang_code": HeaderHeightSingleton.shared.LanguageSelected]
//        }
//        else
//               {
//                parameters = ["user_id":Singleton.shared.getUserId(),"branch_id":AddBranch.shared.BranchId,"lang_code": HeaderHeightSingleton.shared.LanguageSelected]
//        }
//
//        ServerCalls.fileUploadAPINew(inputUrl: str, parameters: parameters, imageName: "branch_logo", imageFile: imgfile) { (response, success, resp) in
//
//            if let value = response as? NSDictionary{
//                let error = value.object(forKey: "error") as! Int
//                if error == 0{
//                    if let body = response as? [String: Any] {
//                        self.branchlogo = Mapper<UploadBranchLogo>().map(JSON: response as! [String : Any])
//                        completion(true, self.branchlogo)
//                        return
//                    }
//                    completion(false,nil)
//                }else{
//                    completion(false, nil)
//
//                }
//
//            }
//        }
//    }
//    func deleteImg(completion:@escaping(Bool, NSDictionary?) -> ()) {
//
//        let str = "\(Constant.BASE_URL)\(Constant.deleteImg)"
//        let parameters = [
//            "image_from":"branch",
//            "media_id":mediaId,"lang_code": HeaderHeightSingleton.shared.LanguageSelected
//            ] as [String : Any]
//        ServerCalls.postRequest(str, withParameters: parameters) { (response, success) in
//
//            if let value = response as? NSDictionary{
//                let error = value.object(forKey: "error") as! Int
//                if error == 0{
//                    if let body = response as? [String: Any] {
//
//                        completion(true, value)
//                        return
//                    }
//                    completion(false,nil)
//                }else{
//                    completion(false, nil)
//
//                }
//
//            }
//        }
//    }
//    func branchDetail(completion:@escaping(Bool, BranchDetailList?) -> ()) {
//
//        let str = "\(Constant.BASE_URL)\(Constant.branchdetaillist)"
//        let parameters = [
//            "id":branchid,
//            "user_id":Singleton.shared.getUserId(),
//            "lang_code":HeaderHeightSingleton.shared.LanguageSelected,
//            "latitude":lat,
//            "longitude":long
//            ] as [String : Any]
//        print(parameters)
//        print(str)
//        ServerCalls.postRequest(str, withParameters: parameters) { (response, success) in
//
//            if let value = response as? NSDictionary{
//                let error = value.object(forKey: "error") as! Int
//                if error == 0{
//                    if let body = response as? [String: Any] {
//                        self.branchdetail = Mapper<BranchDetailList>().map(JSON: response as! [String : Any])
//                        let branch = AddBranch.shared
//
//                        let br = self.branchdetail?.data
//                        branch.isedit = true
//                        branch.branchLogoId = "\(br?.branch_logo ?? 0)"
//                        branch.branchStatus = br?.is_branch_active ?? 0
//                        branch.BranchId = "\(br?.branch_id ?? 0)"
//                        branch.bName = br?.branch_name ?? ""
//                        branch.mail = br?.email ?? ""
//                        branch.video_url = br?.videos ?? ""
//                        branch.mobileCode = br?.mobile_code ?? ""
//                        branch.MobileNo = br?.mobile_number ?? ""
//                        branch.phoneCode = br?.phone_code ?? ""
//                        branch.Phone = br?.phone_number ?? ""
//                        branch.whatsappCode = br?.whats_app_mob_code ?? ""
//                        branch.whatsappNumber = br?.whats_app_number ?? ""
//                        branch.Country = br?.country ?? ""
//                        branch.City = br?.city ?? ""
//                        branch.area = br?.area ?? ""
//                        branch.State = br?.state ?? ""
//                        branch.ZipCode = br?.zipcode ?? ""
//                        branch.location = br?.address ?? ""
//                        branch.displayId = (br?.time_display_style ?? 0)
//                        branch.branchImgUrl = (br?.branch_image ?? "")
//                        branch.Descrip = (br?.description ?? "")
//                        branch.video_url = (br?.videos ?? "")
//                        branch.locationdetails = br?.markets_notes ?? ""
//                        branch.lat = ((br?.lat ?? "") as NSString).doubleValue
//                        branch.long = ((br?.long ?? "") as NSString).doubleValue
//                        branch.branchImgUrl = br?.branch_image ?? ""
//                        branch.ismain = (br?.is_main_branch ?? 0) == 0 ? false : true
//                        branch.timingId = "\(br?.branch_timings_id ?? 0)"
//                        branch.avg_rating = br?.avg_rating ?? 0.0
//                        branch.distance = br?.distance ?? 0.0
//                        branch.review_count = br?.review_count ?? 0
//                        branch.qr_code = br?.qr_code ?? ""
//                        branch.followers = br?.total_followers ?? 0
//                        branch.store_time_display = br?.store_time_display ?? ""
//                        branch.videos = br?.videos ?? "0"
//                        branch.videos_thumb = br?.videos_thumb ?? ""
//                        self.timing.removeAll()
//                        branch.BTimeDict.removeAll()
//                        for i in 0...6
//                        {
//                            self.slot.removeAll()
//
//                            let arrr:Timings = (br?.timings![i])!
//                            if (arrr.slotArrayList?.count ?? 0) > 0
//                            {
//                                for j in 0...((arrr.slotArrayList?.count ?? 0) - 1)
//                                {
//                                    let sl = arrr.slotArrayList![j].time_slot
//                                    self.slot.append(SlotArrayList1(time_slot: sl))
//                                }
//                            }
//                            self.timing.append(Business_timings(dayName:arrr.dayName ?? "", is24Open: arrr.is24Open == false ? 0 : 1, isClose: arrr.isClose == false ? 0 : 1, slotArrayList: self.slot))
//                        }
//
//                        branch.BTimeDict = self.timing
//                        let addtype:Address_type = br!.address_type!
//                        branch.addTypeId = "\(addtype.id ?? 0)"
//                        branch.addTypeName = addtype.address_type_name ?? ""
//
//                        let mname:Market_name = br!.market_name!
//                        branch.BusId = mname.mall_market_id ?? 0
//                        branch.BusName = mname.market_name ?? ""
//                        if br!.business_type!.count > 0
//                        {
//                            branch.BType.removeAllObjects()
//                            branch.BussName.removeAllObjects()
//                            for i in 0...br!.business_type!.count - 1
//                            {
//                                let btype:Business_types = br!.business_type![i]
//                                branch.BType.add(btype.id!)
//                                branch.BussName.add(btype.name!)
//                            }
//
//                        }
//                        if br!.branch_platform!.count > 0
//                        {
//                            branch.platformType.removeAllObjects()
//                            branch.branchPlatformName.removeAllObjects()
//                            for i in 0...br!.branch_platform!.count - 1
//                            {
//                                let ptype:Branch_platform = br!.branch_platform![i]
//                                branch.platformType.add(ptype.id!)
//                                branch.branchPlatformName.add(ptype.platform!)
//                            }
//
//                        }
//                         branch.Interior.removeAllObjects()
//                        if br!.interior_img!.count > 0
//                        {
//
//                            for i in 0...br!.interior_img!.count - 1
//                            {
//                                let ptype:Interior_imgs = br!.interior_img![i]
//                                branch.Interior.add(ptype.image_name!)
//                            }
//
//                        }
//                        if br!.exterior_img!.count > 0
//                        {
//
//                            for i in 0...br!.exterior_img!.count - 1
//                            {
//                                let ptype:Exterior_imgs = br!.exterior_img![i]
//                                branch.Interior.add(ptype.image_name!)
//                            }
//
//                        }
////                        if br!.product_data!.count > 0
////                        {
////
////                            for i in 0...br!.product_data!.count - 1
////                            {
////                                let ptype:product_data = br!.product_data![i]
////                                branch.Product_data.add(ptype.id!)
////
////
////                            }
////
////                        }
//
//                        if (br?.videos!.count)! > 0 {
//                            if br?.videos_thumb != "" {
//                                branch.Interior.add(br?.videos_thumb ?? "")
//                            }
//                        }
//
//                        if br!.category_list!.count > 0
//                        {
//                            branch.category_list.removeAllObjects()
//                            branch.category_listId.removeAllObjects()
//                            for i in 0...br!.category_list!.count - 1
//                            {
//                                let ptype:Category_list = br!.category_list![i]
//                                branch.category_list.add(ptype.category_image!)
//                                branch.category_listId.add(ptype.id ?? 0)
//                            }
//
//                        }
//
//
//
//
//
//
//                        completion(true, self.branchdetail)
//                        return
//                    }
//                    completion(false,nil)
//                }else{
//                    completion(false, nil)
//
//                }
//
//            }
//        }
//    }
//    // branch list
//    func getBranchList(completion:@escaping(Bool, NewBranchList?) -> ()) {
//        var param = [String:Any]()
//        var active = ""
//        var busstype = ""
//        var plateformtype = ""
//        let pro = ProductModel.shared
//       if pro.activatebranchIndex.count > 0
//              {
//                active.removeAll()
//                  for item in pro.activatebranchIndex{
//                      active = "\(item),\(active)"
//                  }
//                  active.removeLast()
//              }
//        if pro.busstypeIndex.count > 0
//               {
//                busstype.removeAll()
//                   for item in pro.busstypeIndex{
//                       busstype = "\(item),\(busstype)"
//                   }
//                   busstype.removeLast()
//               }
//        if pro.platformIndex.count > 0
//               {
//                plateformtype.removeAll()
//                   for item in pro.platformIndex{
//                       plateformtype = "\(item),\(plateformtype)"
//                   }
//                   plateformtype.removeLast()
//               }
//        param  =  ["user_id": Singleton.shared.getUserId(),"lang_code":HeaderHeightSingleton.shared.LanguageSelected,"sort_type":sortType,"sort_val":sortValue,"search":searchTxt,"ACTIVATION":active,"BUSINESS_TYPE":busstype,"PLATFORM_TYPE":plateformtype,"BRANCH_DATE_RANGE":pro.timestamp,"RATING_RANGE":pro.rating,"FOLLOWER_RANGE":pro.follower,"LIKES_RANGE":pro.likerangebranch,"ITEM_RANGE":pro.availitembranch]
//
//          print(param)
//          ServerCalls.postRequest("\(Constant.BASE_URL)\(Constant.Branch_List)", withParameters: param) { (response, success) in
//              if let value = response as? NSDictionary{
//                  let error = value.object(forKey: "error") as! Int
//                  if error == 0{
//                      if let body = response as? [String: Any] {
//
//                        self.branchlist  = Mapper<NewBranchList>().map(JSON: body)
//                        completion(true, self.branchlist)
//                          return
//                      }
//                      completion(false,nil)
//                  }else{
//                      let msg =  value.object(forKey: "error_description") as! String
//                      ModalController.showNegativeCustomAlertWith(title: "", msg: msg)
//                      completion(false, nil)
//
//                  }
//
//              }
//          }
//      }
//    func getBranchListfilter(completion:@escaping(Bool, NewBranchList?) -> ()) {
//
//         let param  =  ["user_id": Singleton.shared.getUserId(),"lang_code":HeaderHeightSingleton.shared.LanguageSelected]
//
//           print(param)
//           ServerCalls.postRequest("\(Constant.BASE_URL)\(Constant.Branch_List)", withParameters: param) { (response, success) in
//               if let value = response as? NSDictionary{
//                   let error = value.object(forKey: "error") as! Int
//                   if error == 0{
//                       if let body = response as? [String: Any] {
//
//                         self.branchlist  = Mapper<NewBranchList>().map(JSON: body)
//                         completion(true, self.branchlist)
//                           return
//                       }
//                       completion(false,nil)
//                   }else{
//                       let msg =  value.object(forKey: "error_description") as! String
//                       ModalController.showNegativeCustomAlertWith(title: "", msg: msg)
//                       completion(false, nil)
//
//                   }
//
//               }
//           }
//       }
//      //status change api
//      func statusChange(completion:@escaping(Bool, NSDictionary?) -> ()) {
//
//          let param  =  [ "branch_id":branchid,"branch_status":status,"lang_code":HeaderHeightSingleton.shared.LanguageSelected]
//
//          print(param)
//          ServerCalls.putRequest("\(Constant.BASE_URL)\(Constant.addbranch)", withParameters: param) { (response, success) in
//              if let value = response as? NSDictionary{
//
//                      if let body = response as? [String: Any] {
//
//                          completion(true, value)
//
//                      }
//                      completion(false,nil)
//
//
//              }
//          }
//      }
//
//    func showGallery(completion:@escaping(Bool, ShowImageList?) -> ()) {
//
//        let str = "\(Constant.BASE_URL)\(Constant.showimglist)"
//
//            let parameters =
//                ["image_type":imageType,"branch_id":AddBranch.shared.BranchId,
//                        "user_id":Singleton.shared.getUserId(),"lang_code": HeaderHeightSingleton.shared.LanguageSelected]
//
//        print("url\(str)\n param \(parameters)")
//        ServerCalls.postRequest(str, withParameters: parameters) { (response, success) in
//
//            if let value = response as? NSDictionary{
//                let error = value.object(forKey: "error") as! Int
//                if error == 0{
//                    if let body = response as? [String: Any] {
//                        self.showimgList = Mapper<ShowImageList>().map(JSON: response as! [String : Any])
//                        completion(true, self.showimgList)
//                        return
//                    }
//                    completion(false,nil)
//                }else{
//                    completion(false, nil)
//
//                }
//
//            }
//        }
//    }
//    func description(completion:@escaping(Bool, DescriptionValueList?) -> ()) {
//
//               let str = "\(Constant.BASE_URL)\(Constant.descriptionVal)"
//
//          ServerCalls.getRequest(str){ (response, success, resp) in
//
//                             if let value = response as? NSDictionary{
//                       let error = value.object(forKey: "error") as! Int
//                       if error == 0{
//                           if let body = response as? [String: Any] {
//                             self.descriplist = Mapper<DescriptionValueList>().map(JSON: response as! [String : Any])
//
//                               completion(true,self.descriplist)
//                               return
//                           }
//                           completion(false,nil)
//                       }else{
//                           completion(false, nil)
//
//                       }
//
//                   }
//               }
//           }

}


//
//  AddProductModel.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-039 on 19/02/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import Foundation

import ObjectMapper
class AddProductModel: NSObject {
    var checkbar:CheckBarCode?
    var editpronew:EditProductnew?
    var filterlist:ProductFilterList?
    var prolimit:ProductLimit?
    var prodetail:ProductDetailNew?
    var storepayment:StorePayment?
    var subcataid = ""
    var barcode = ""
    var step = 1
     var isdraft = false
    var isVarient = false
     var isSimilar = false
    var vatnum = ""
    var proid = ""
    var serviceid = ""
    func addProductNew(completion:@escaping(Bool, EditProductnew?) -> ()) {
        let pro = ProductModel.shared
        var mediaid = ""
        var branchesid = ""
        let mediaImg:NSMutableArray = NSMutableArray()
        mediaImg.removeAllObjects()
        for i in 0...pro.galleryId.count - 1 {
            if "\(pro.galleryId[i])" != ""
            {
                mediaImg.add(pro.galleryId[i])
            }
            else{
            
            }
            
        }
       
        if pro.branchIdnew.count > 0
        {
            for item in pro.branchIdnew{
                branchesid = "\(item),\(branchesid)"
            }
            branchesid.removeLast()
        }
        if mediaImg.count > 0
        {
            for item in mediaImg{
                mediaid = "\(item),\(mediaid)"
            }
            mediaid.removeLast()
        }
        let str = "\(Constant.BASE_URL)\(Constant.addproductNew)"
       
        let parameters =
            ["lang_code": HeaderHeightSingleton.shared.LanguageSelected,
             "pro_bo_id":Singleton.shared.getBoId(),
               "pro_agent_id":Singleton.shared.getUserId(),
             "pro_barcode":pro.barcode,
             "pro_currency":pro.currencyId,
             "pro_name":pro.productTitle,
             "pro_branch_id":branchesid,
             "pro_desc":pro.productDecription,
             "pro_online":pro.isOnline,
             "pro_store":pro.isoffline,
             "pro_video_url":pro.videoUrl,
             "pro_purchased_product_id":pro.purchaseId,
             "pro_image_id":pro.purchaseId == "" ? mediaid : "",
             "service_id" : serviceid,
             "pro_purchased_image_id":pro.purchaseId == "" ? "" : mediaid] as [String : Any]
        print(str,parameters)
        ServerCalls.postRequest(str, withParameters: parameters)
        { (response, success) in
            if let value = response as? NSDictionary{
                let error = value.object(forKey: "error") as! Int
                if error == 0{
                    if let body = response as? [String: Any] {
                        self.editpronew = Mapper<EditProductnew>().map(JSON: response as! [String : Any])
                        completion(true, self.editpronew)
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
    func filterlist(completion:@escaping(Bool, ProductFilterList?) -> ()) {

        let str = "\(Constant.BASE_URL)\(Constant.filterlistnew)"
        let parameters = ["lang_code": HeaderHeightSingleton.shared.LanguageSelected,"sub_category_id":subcataid,"bo_user_id":Singleton.shared.getUserId()]
        print(parameters)
        ServerCalls.postRequest(str, withParameters: parameters) { (response, success) in


            if let value = response as? NSDictionary{
                let error = value.object(forKey: "error") as! Int
                if error == 0{
                    if let body = response as? [String: Any] {
                        self.filterlist = Mapper<ProductFilterList>().map(JSON: response as! [String : Any])
                        completion(true, self.filterlist)
                        return
                    }
                    completion(false,nil)
                }else{
                    completion(false, nil)

                }

            }
        }
    }
//    func approvallistupdate(completion:@escaping(Bool, NSDictionary?) -> ()) {
//       let pro = ProductModel.shared
//         var filterid = ""
//         var filteridVal = ""
//         var mediaid = ""
//        var docid = ""
//         let indexSet = NSMutableIndexSet()
//         //let mediaImg =  NSMutableArray(array:pro.galleryId)
//         let mediaImg1:Array = pro.galleryId as! Array<Any>
//         let mediaImg:NSMutableArray = NSMutableArray(array: mediaImg1)
//         for i in 0...mediaImg.count - 1 {
//             if "\(mediaImg[i])" == ""
//             {
//                 indexSet.add(i)
//             }
//             else{
//
//             }
//
//         }
//         print(indexSet)
//       mediaImg.removeObjects(at: IndexSet(indexSet))
//
//         if pro.documentId.count > 0
//         {
//             docid.removeAll()
//             for item in pro.documentId{
//                 docid = "\(item),\(docid)"
//             }
//             docid.removeLast()
//         }
//
//         if mediaImg.count > 0
//         {
//             mediaid.removeAll()
//             for item in mediaImg{
//                 mediaid = "\(item),\(mediaid)"
//             }
//             mediaid.removeLast()
//         }
//         if pro.filterId.count > 0
//         {
//             filterid.removeAll()
//             for item in pro.filterId{
//                 filterid = "\(item),\(filterid)"
//             }
//             filterid.removeLast()
//         }
//         if pro.filterIdValue.count > 0
//         {
//             filteridVal.removeAll()
//             for item in pro.filterIdValue{
//                 filteridVal = "\(item),\(filteridVal)"
//             }
//             filteridVal.removeLast()
//         }
//
//
//
//          let str = "\(Constant.BASE_URL)\(Constant.updatedatabank)"
//          let parameters = ["lang_code":"en",
//                            "pro_id":pro.productId,
//                   "pro_bo_id":Singleton.shared.getUserId(),
//                   "pro_name":pro.productTitle,
//                   "pro_desc":pro.productDecription,
//                   "pro_image_id":mediaid,
//                   "pro_video_url":pro.videoUrl,
//                   "pro_parent_cat":pro.cataId,
//                   "pro_sub_cat":pro.subcataId,
//                   "pro_filter_id":filterid,
//                   "pro_filter_value_id":filteridVal,
//                   "pro_technical_specification":pro.descriptions,
//                   "pro_doc_id":docid]
//          print(parameters)
//          ServerCalls.postRequest(str, withParameters: parameters) { (response, success) in
//
//
//              if let value = response as? NSDictionary{
//                  let error = value.object(forKey: "error") as! Int
//                  if error == 0{
//                      if let body = response as? [String: Any] {
//                        //  self.filterlist = Mapper<ProductFilterList>().map(JSON: response as! [String : Any])
//                          completion(true, value)
//                          return
//                      }
//                      completion(false,nil)
//                  }else{
//                      completion(false, nil)
//
//                  }
//
//              }
//          }
//      }
    func productlimit(completion:@escaping(Bool, ProductLimit?) -> ()) {
        
        let str = "\(Constant.BASE_URL)\(Constant.productlimit)"
        let parameters = ["lang_code": HeaderHeightSingleton.shared.LanguageSelected]
        ServerCalls.postRequest(str, withParameters: parameters) { (response, success) in
            
            
            if let value = response as? NSDictionary{
                let error = value.object(forKey: "error") as! Int
                if error == 0{
                    if let body = response as? [String: Any] {
                        self.prolimit = Mapper<ProductLimit>().map(JSON: response as! [String : Any])
                        completion(true, self.prolimit)
                        return
                    }
                    completion(false,nil)
                }else{
                    completion(false, nil)
                    
                }
                
            }
        }
    }
    func selproductinfo(completion:@escaping(Bool, NSDictionary?) -> ()) {
          
          let str = "\(Constant.BASE_URL)\(Constant.productsellinfo)"
   let parameters = ["lang_code": HeaderHeightSingleton.shared.LanguageSelected,"bo_user_id":Singleton.shared.getUserId(),"pro_id":proid]
        print(str,parameters)
          ServerCalls.postRequest(str, withParameters: parameters) { (response, success) in
              
              
              if let value = response as? NSDictionary{
                  let error = value.object(forKey: "error") as! Int
                  if error == 0{
                      if let body = response as? [String: Any] {
                       
                          completion(true,value)
                          return
                      }
                      completion(false,nil)
                  }else{
                      completion(false, nil)
                      
                  }
                  
              }
          }
      }
    func getproductcode(completion:@escaping(Bool, NSDictionary?) -> ()) {
                  
                  let str = "\(Constant.BASE_URL)\(Constant.productcode)"
                    let parameters = ["lang_code": HeaderHeightSingleton.shared.LanguageSelected]
             ServerCalls.postRequest(str, withParameters: parameters) { (response, success) in

                                if let value = response as? NSDictionary{
                          let error = value.object(forKey: "error") as! Int
                          if error == 0{
                              if let body = response as? [String: Any] {
                               
                   
                                  completion(true,value)
                                  return
                              }
                              completion(false,nil)
                          }else{
                              completion(false, nil)
                              
                          }
                          
                      }
                  }
              }
    func checkbarcode(completion:@escaping(Bool, CheckBarCode?) -> ()) {
        
        let str = "\(Constant.BASE_URL)\(Constant.checkbar)"
        let parameters = ["user_id":Singleton.shared.getUserId(),
                          "pro_barcode":barcode,"pro_id":ProductModel.shared.productId,"lang_code": HeaderHeightSingleton.shared.LanguageSelected]
        print(str,parameters)
        ServerCalls.postRequest(str, withParameters: parameters) { (response, success) in
            
            
            if let value = response as? NSDictionary{
                let error = value.object(forKey: "error") as! Int
                if error == 0{
                    if let body = response as? [String: Any] {
                        self.checkbar = Mapper<CheckBarCode>().map(JSON: response as! [String : Any])
                        completion(true, self.checkbar)
                        return
                    }
                    completion(false,nil)
                }else{
                    completion(false, nil)
                    
                }
                
            }
        }
    }
//    func checkVatPopupNotify(completion:@escaping(Bool, NSDictionary?) -> ()) {
//
//          let str = "\(Constant.BASE_URL)\(Constant.checkpopup)"
//          let parameters = ["bo_user_id":Singleton.shared.getUserId(),
//                            "lang_code": HeaderHeightSingleton.shared.LanguageSelected]
//        print(parameters)
//          ServerCalls.postRequest(str, withParameters: parameters) { (response, success) in
//
//
//              if let value = response as? NSDictionary{
//                  let error = value.object(forKey: "error") as! Int
//                  if error == 0{
//                      if let body = response as? [String: Any] {
//                          completion(true, value)
//                          return
//                      }
//                      completion(false,nil)
//                  }else{
//                      completion(false, nil)
//
//                  }
//
//              }
//          }
//      }
    func storePaymentList(completion:@escaping(Bool, StorePayment?) -> ()) {
            
            let str = "\(Constant.BASE_URL)\(Constant.storepay)"
            let parameters = ["lang_code": HeaderHeightSingleton.shared.LanguageSelected]
          print(parameters)
            ServerCalls.postRequest(str, withParameters: parameters) { (response, success) in
                
                
                if let value = response as? NSDictionary{
                    let error = value.object(forKey: "error") as! Int
                    if error == 0{
                        if let body = response as? [String: Any] {
                        self.storepayment = Mapper<StorePayment>().map(JSON: response as! [String : Any])
                            completion(true, self.storepayment)
                            return
                        }
                        completion(false,nil)
                    }else{
                        completion(false, nil)
                        
                    }
                    
                }
            }
        }
//    func haveVatPopupNotify(completion:@escaping(Bool, NSDictionary?) -> ()) {
//
//            let str = "\(Constant.BASE_URL)\(Constant.havepopup)"
//        let parameters = ["user_id":Singleton.shared.getUserId(),"vat_number":vatnum,
//                              "lang_code": HeaderHeightSingleton.shared.LanguageSelected]
//          print(parameters)
//            ServerCalls.postRequest(str, withParameters: parameters) { (response, success) in
//
//
//                if let value = response as? NSDictionary{
//                    let error = value.object(forKey: "error") as! Int
//                    if error == 0{
//                        if let body = response as? [String: Any] {
//                            completion(true, value)
//                            return
//                        }
//                        completion(false,nil)
//                    }else{
//                        completion(false, nil)
//
//                    }
//
//                }
//            }
//        }
    func editProductNew(completion:@escaping(Bool, EditProductnew?) -> ()) {
        let pro = ProductModel.shared
        var varientid = ""
        var filterid = ""
        var filteridVal = ""
        var mediaid = ""
        var branchesid = ""
        var onlineqtyfrom = ""
        var onlineqtyto = ""
        var wholesaleprice = ""
        var wholenetsell = ""
        var wholesalediscount = ""
        var wholesaledisper = ""
        var wholesalevat = ""
        var wholesalevatper = ""
        var wholesalefinal = ""
        var paymentid = ""
       var docid = ""
        let indexSet = NSMutableIndexSet()
        //let mediaImg =  NSMutableArray(array:pro.galleryId)
        let mediaImg1:Array = pro.galleryId as! Array<Any>
        let mediaImg:NSMutableArray = NSMutableArray(array: mediaImg1)
        for i in 0...mediaImg.count - 1 {
            if "\(mediaImg[i])" == ""
            {
                indexSet.add(i)
            }
            else{
                
            }
            
        }
        print(indexSet)
      mediaImg.removeObjects(at: IndexSet(indexSet))
        if pro.varientId.count > 0
               {
                   varientid.removeAll()
                   for item in pro.varientId{
                       varientid = "\(item),\(varientid)"
                   }
                   varientid.removeLast()
               }
        if pro.storePayArr.count > 0
               {
                   paymentid.removeAll()
                   for item in pro.storePayArr{
                       paymentid = "\(item),\(paymentid)"
                   }
                   paymentid.removeLast()
               }
        if pro.documentId.count > 0
        {
            docid.removeAll()
            for item in pro.documentId{
                docid = "\(item),\(docid)"
            }
            docid.removeLast()
        }
        if pro.branchIdnew.count > 0
        {
            branchesid.removeAll()
            for item in pro.branchIdnew{
                branchesid = "\(item),\(branchesid)"
            }
            branchesid.removeLast()
        }
        if mediaImg.count > 0
        {
            mediaid.removeAll()
            for item in mediaImg{
                mediaid = "\(item),\(mediaid)"
            }
            mediaid.removeLast()
        }
        if pro.filterId.count > 0
        {
            filterid.removeAll()
            for item in pro.filterId{
                filterid = "\(item),\(filterid)"
            }
            filterid.removeLast()
        }
        if pro.filterIdValue.count > 0
        {
            filteridVal.removeAll()
            for item in pro.filterIdValue{
                filteridVal = "\(item),\(filteridVal)"
            }
            filteridVal.removeLast()
        }
        if pro.OnlineQuantityFrom.count > 0
        {
            onlineqtyfrom.removeAll()
            for item in pro.OnlineQuantityFrom{
                onlineqtyfrom = "\(item),\(onlineqtyfrom)"
            }
            onlineqtyfrom.removeLast()
        }
        if pro.OnlineQuantityto.count > 0
        {
            onlineqtyto.removeAll()
            for item in pro.OnlineQuantityto{
                onlineqtyto = "\(item),\(onlineqtyto)"
            }
            onlineqtyto.removeLast()
        }
        if pro.OnlineWholeSalePriceFrom.count > 0
        {
            wholesaleprice.removeAll()
            for item in pro.OnlineWholeSalePriceFrom{
                wholesaleprice = "\(item),\(wholesaleprice)"
            }
            wholesaleprice.removeLast()
        }
        if pro.OnlineWholeSalePriceTo.count > 0
        {
            wholenetsell.removeAll()
            for item in pro.OnlineWholeSalePriceTo{
                wholenetsell = "\(item),\(wholenetsell)"
            }
            wholenetsell.removeLast()
        }
        if pro.OnlinediscountWhole.count > 0
        {
            wholesalediscount.removeAll()
            for item in pro.OnlinediscountWhole{
                wholesalediscount = "\(item),\(wholesalediscount)"
            }
            wholesalediscount.removeLast()
        }
        if pro.OnlinediscountWholePercent.count > 0
        {
            wholesaledisper.removeAll()
            for item in pro.OnlinediscountWholePercent{
                wholesaledisper = "\(item),\(wholesaledisper)"
            }
            wholesaledisper.removeLast()
        }
        if pro.OnlineVatValue.count > 0
        {
            wholesalevat.removeAll()
            for item in pro.OnlineVatValue{
                wholesalevat = "\(item),\(wholesalevat)"
            }
            wholesalevat.removeLast()
        }
        if pro.OnlineVatPercent.count > 0
        {
            wholesalevatper.removeAll()
            for item in pro.OnlineVatPercent{
                wholesalevatper = "\(item),\(wholesalevatper)"
            }
            wholesalevatper.removeLast()
        }
        if pro.OnlineFinalPrice.count > 0
        {
            wholesalefinal.removeAll()
            for item in pro.OnlineFinalPrice{
                wholesalefinal = "\(item),\(wholesalefinal)"
            }
            wholesalefinal.removeLast()
        }
        var str = ""
        if isVarient || isSimilar
        {
         //str = "\(Constant.BASE_URL)\(Constant.varientproduct)"
        }
        else
        {
        str = "\(Constant.BASE_URL)\(Constant.editproductNew)"
        }
        
       
        
        var parameters =
            ["lang_code": HeaderHeightSingleton.shared.LanguageSelected,
             "pro_agent_id":Singleton.shared.getUserId(),
             "pro_bo_id":Singleton.shared.getBoId(),
             "pro_id":pro.productId,
             "pro_filled_step":step,
             "pro_barcode":pro.barcode,
             "pro_currency":pro.currencyId,
             "pro_name":pro.productTitle,
             "pro_branch_id":branchesid,
             "pro_desc":pro.productDecription,
             "pro_online":pro.isOnline,
             "pro_store":pro.isoffline,
             "pro_video_url":pro.videoUrl,
             "pro_image_id":pro.purchaseId == "" ? mediaid : "",
             "pro_purchased_image_id":pro.purchaseId == "" ? "" : mediaid,
             "pro_online_retail":pro.Onlineretail,
             "pro_online_wholesale":pro.OnlineWhole,
             "pro_online_payment":pro.Online,
             "pro_cod_payment":pro.Cash,
             "pro_online_retail_return_days":pro.OnlineReturnDays,
             "pro_online_wholesale_return_days":pro.OnlineReturnDays1,
             "pro_stock":pro.stockQuan,
             "pro_delivery_days":pro.deliveryDays,
             "pro_online_retail_price":pro.OnlineRegular,
             "pro_online_retail_dis_price":pro.Onlinediscount,
             "pro_online_retail_dis_percentage":pro.OnlinediscountPer,
             "pro_online_retail_net_sell_price":pro.Onlinesell,
             "pro_online_retail_vat":pro.OnlineVat,
             "pro_online_retail_vat_percentage":pro.OnlineVatPer,
             "pro_online_retail_final_price":pro.OnlineFinal,
             "pro_online_retail_min_qty":pro.OnlineMin,
             "pro_online_retail_max_qty":pro.OnlineMax,
             "online_wholesale_min_qty":onlineqtyfrom,
             "online_wholesale_max_qty":onlineqtyto,
             "online_wholesale_price":wholesaleprice,
             "online_wholesale_discount":wholesalediscount,
             "online_wholesale_discount_per":wholesaledisper,
             "online_wholesale_net_sell_price":wholenetsell,
             "online_wholesale_vat":wholesalevat,
             "online_wholesale_vat_per":wholesalevatper,
             "online_wholesale_final_price":wholesalefinal,
             "pro_store_retail":pro.retail,
             "pro_store_wholesale":pro.Whole,
             "pro_store_retail_price":pro.RetailRegular,
             "pro_store_retail_dis_price":pro.Retaildiscount,
             "pro_store_retail_dis_percentage":pro.RetaildiscountPer,
             "pro_store_retail_net_sell_price":pro.Retailsell,
             "pro_store_retail_vat":pro.RetailVat,
             "pro_store_retail_vat_percentage":pro.RetailVatPer,
             "pro_store_retail_final_price":pro.RetailFinal,
             "pro_store_retail_min_qty":pro.RetailMin,
             "pro_store_retail_max_qty":pro.RetailMax,
             "pro_store_retail_return_days":pro.RetailReturnDays,
             "pro_store_wholesale_price":pro.RetailProductRegular,
             "pro_store_wholesale_dis_price":pro.RetailProductdiscount,
             "pro_store_wholesale_dis_percentage":pro.RetailProductdiscountPer,
             "pro_store_wholesale_net_sell_price":pro.RetailProductsell,
             "pro_store_wholesale_vat":pro.RetailProductVat,
             "pro_store_wholesale_vat_percentage":pro.RetailProductVatPer,
             "pro_store_wholesale_final_price":pro.RetailProductFinal,
             "pro_store_wholesale_min_qty":pro.RetailProducteMin,
             "pro_store_wholesale_max_qty":pro.RetailProducteMax,
             "pro_store_wholesale_return_days":pro.RetailReturnDays1,
             "pro_online_payment_store":pro.Online1,
             "pro_cod_payment_store":pro.Cash1,
             "pro_store_payment_id":paymentid,
             "pro_parent_cat":pro.cataId,
             "pro_sub_cat":pro.subcataId,
             "pro_weight":pro.weight,
             "pro_length":pro.length,
             "pro_width":pro.width,
             "pro_height":pro.height,
             "pro_dimension":pro.dimension,
             "pro_technical_specification":pro.descriptions,
             "pro_warranty_section":pro.supportdescriptions,
               "pro_doc_id": docid,
             "pro_filter_id":filterid,
             "pro_filter_variant":varientid,
             "pro_filter_value_id":filteridVal,
            "save_as_draft":isdraft] as [String : Any]
              if isVarient
              {
                parameters["pro_parent_id"] = pro.productId
              }
      
        print(str,parameters)
        ServerCalls.postRequest(str, withParameters: parameters) { (response, success) in
            
            
            if let value = response as? NSDictionary{
                let error = value.object(forKey: "error") as! Int
                if error == 0{
                    if let body = response as? [String: Any] {
                        self.editpronew = Mapper<EditProductnew>().map(JSON: response as! [String : Any])
                        completion(true, self.editpronew)
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
    
    func productDetails(completion:@escaping(Bool, ProductDetailNew?) -> ()) {
        
        let str = "\(Constant.BASE_URL)\(Constant.productdetailnew)"
        let parameters = ["lang_code": HeaderHeightSingleton.shared.LanguageSelected,"pro_bo_id":Singleton.shared.getUserId(),
                          "pro_id":ProductModel.shared.productId]
        print(parameters)
        ServerCalls.postRequest(str, withParameters: parameters) { (response, success) in
            
            
            if let value = response as? NSDictionary{
                let error = value.object(forKey: "error") as! Int
                if error == 0{
                    let pro = ProductModel.shared
                    if let body = response as? [String: Any] {
                        self.prodetail = Mapper<ProductDetailNew>().map(JSON: response as! [String : Any])
                        let pr = self.prodetail?.data?.product_details
                        //page 1
                        pro.filledstep = pr?.pro_filled_step ?? 0
                        pro.barcode = pr?.pro_barcode_val ?? ""
                        pro.Currencyname = pr?.pro_currency_code ?? ""
                        pro.currencyId = "\(pr?.pro_currency_id ?? 0)"
                        pro.productTitle = pr?.pro_name ?? ""
                        pro.branchIdnew.removeAllObjects()
                        pro.BranchName.removeAll()
                        if (pr?.pro_branch?.count ?? 0) > 0
                        {
                            
                            for i in 0...(pr?.pro_branch?.count ?? 0) - 1
                            {
                                let br:Pro_branch = (pr?.pro_branch![i])!
                                pro.branchIdnew.add(br.branch_id!)
                                pro.BranchNamenew.add(br.branch_name!)
                            }
                         
                            
                        }
                        
                        pro.galleryId = ["","","","","","","","","",""]
                        pro.galleryIdImageNew = [#imageLiteral(resourceName: "category_placeholder"),#imageLiteral(resourceName: "category_placeholder"),#imageLiteral(resourceName: "category_placeholder"),#imageLiteral(resourceName: "category_placeholder"),#imageLiteral(resourceName: "category_placeholder"),#imageLiteral(resourceName: "category_placeholder"),#imageLiteral(resourceName: "category_placeholder"),#imageLiteral(resourceName: "category_placeholder"),#imageLiteral(resourceName: "category_placeholder"),#imageLiteral(resourceName: "category_placeholder")]
                        if (pr?.pro_image?.count ?? 0) > 0
                        {
                            
                            for i in 0...(pr?.pro_image?.count ?? 0) - 1
                            {
                                let br:Pro_image = (pr?.pro_image![i])!
                              
                                let url = URL(string:br.image!)
                                    if let data = try? Data(contentsOf: url!)
                                    {
                                        let image: UIImage = UIImage(data: data)!
                                        pro.galleryIdImageNew[br.index!] = image
                                        pro.galleryFeatureImage = br.image ?? ""
                                    }
                                    pro.galleryId.replaceObject(at: br.index!, with: br.id!)
                                    
                                }
                                
                            
                            
                            
                        }
                        pro.productcode = pr?.pro_code ?? ""
                        pro.productDecription = pr?.pro_description ?? ""
                        pro.videoUrl = pr?.pro_video_url ?? ""
                        pro.isOnline = pr?.pro_online ?? false
                        pro.isoffline = pr?.pro_store ?? false
                        pro.pro_reference_id = pr?.pro_reference_id ?? ""
                        //page2
                        pro.cataId = "\(pr?.pro_parent_cat_id ?? 0)"
                        pro.cataIdname = pr?.pro_parent_cat_name ?? ""
                        pro.cataImage = pr?.pro_parent_cat_image ?? ""
                        pro.subcataImage = pr?.pro_sub_cat_image ?? ""
                        pro.subcataId = "\(pr?.pro_sub_cat_id ?? 0)"
                        pro.subcataIdName = pr?.pro_sub_cat_name ?? ""
                        pro.dimension = pr?.pro_dimension ?? 0
                        pro.length = pr?.pro_length ?? 0
                        pro.width = pr?.pro_width ?? 0
                        pro.height = pr?.pro_height ?? 0
                        pro.weight = pr?.pro_weight ?? 0
                        pro.descriptions = pr?.pro_technical_specification ?? ""
                        pro.documentId.removeAllObjects()
                         pro.documentImage.removeAllObjects()
                          pro.documentImageSize.removeAllObjects()
                        if (pr?.pro_pdf?.count ?? 0) > 0
                                              
                        {
                                                   
                                                   for i in 0...(pr?.pro_pdf?.count ?? 0) - 1
                                                   {
                                                       let br:Pro_pdf = (pr?.pro_pdf![i])!
                                                       pro.documentId.add(br.id!)
                                                       pro.documentImage.add(br.pdf!)
                                                       pro.documentImageSize.add(br.size!)
                                                   }
                                                
                                                   
                                               }
                        pro.storePayArr.removeAllObjects()
                        if (pr?.store_payment_list?.count ?? 0) > 0
                                                                     
                                               {
                                                                          
                                for i in 0...(pr?.store_payment_list?.count ?? 0) - 1
                                                                          {
                                        let br:Store_payment_list = (pr?.store_payment_list![i])!
                                                    pro.storePayArr.add(br.payment_id!)
                                                                        }
                                                                       
                                                                          
                                                                      }
                        pro.filterId.removeAllObjects()
                        pro.filterIdValue.removeAllObjects()
                        pro.filterIdName.removeAllObjects()
                        pro.filterIdValueName.removeAllObjects()
                        if (pr?.pro_filter?.count ?? 0) > 0
                        {
                            
                            for i in 0...(pr?.pro_filter?.count ?? 0) - 1
                            {
                                let br:Pro_filter = (pr?.pro_filter![i])!
                                pro.filterId.add(br.filter_id!)
                                pro.filterIdValue.add(br.filter_value_id!)
                                pro.filterIdName.add(br.filter_name!)
                                pro.filterIdValueName.add(br.filter_value_name!)
                                  if br.filter_variant!
                                  {
                                    pro.SelectedVarientIndex.add(br.filter_id!)
                                }
                            }
                            
                            
                        }
                        pro.supportdescriptions = pr?.pro_warranty_section ?? ""
                        //page3
                        pro.Onlineretail = pr?.pro_online_retail ?? false
                        pro.OnlineWhole = pr?.pro_online_wholesale ?? false
                        pro.Online = pr?.online_payment_mode?.oNLINE ?? false
                        pro.Cash = pr?.online_payment_mode?.cOD ?? false
                        pro.OnlineReturnDays = "\(pr?.pro_online_retail_return_days ?? 0)"
                        pro.OnlineReturnDays1 = "\(pr?.pro_online_wholesale_return_days ?? 0)"
                        pro.stockQuan = "\(pr?.pro_stock ?? 0)"
                        pro.deliveryDays = "\(pr?.pro_delivery_days ?? 0)"
                        pro.OnlineMin = "\(pr?.pro_online_retail_min_qty ?? 0)"
                        pro.onlineQuanTo = (pr?.pro_online_retail_max_qty ?? 0) + 1
                                         pro.OnlineMax = "\(pr?.pro_online_retail_max_qty ?? 0)"
                                         pro.OnlineRegular = "\(pr?.pro_online_retail_price ?? 0)"
                                        pro.Onlinediscount = "\(pr?.pro_online_retail_dis_price ?? 0)"
                                         pro.OnlinediscountPer = "\(pr?.pro_online_retail_dis_percentage ?? 0)"
                                         pro.Onlinesell = "\(pr?.pro_online_retail_net_sell_price ?? 0)"
                                         pro.OnlineVat = "\(pr?.pro_online_retail_vat ?? 0)"
                                         pro.OnlineVatPer = "\(pr?.pro_online_retail_vat_percentage ?? 0)"
                                         pro.OnlineFinal = "\(pr?.pro_online_retail_final_price ?? 0)"
                        
                        if (pr?.online_wholesale_mapping?.count ?? 0) > 0
                        {
                            
                            for i in 0...(pr?.online_wholesale_mapping?.count ?? 0) - 1
                            {
                                let br:Online_wholesale_mapping = (pr?.online_wholesale_mapping![i])!
                             
                                pro.OnlineQuantityFrom.add(br.online_wholesale_min_qty!)
                                pro.OnlineQuantityto.add(br.online_wholesale_max_qty!)
                                pro.OnlineWholeSalePriceFrom.add(br.online_wholesale_price!)
                                pro.OnlineWholeSalePriceTo.add(br.online_wholesale_net_sell_price!)
                                pro.OnlinediscountWhole.add(br.online_wholesale_discount!)
                                pro.onlineQuanTo = pro.OnlineQuantityto.lastObject as! Int + 1
                                pro.OnlinediscountWholePercent.add(br.online_wholesale_discount_per!)
                                pro.OnlineVatValue.add(br.online_wholesale_vat!)
                                
                                pro.OnlineVatPercent.add(br.online_wholesale_vat_per!)
                                
                                pro.OnlineFinalPrice.add(br.online_wholesale_final_price!)
                              
                            }
                        }
                        //page4
                        pro.Online1 = pr?.store_payment_mode?.oNLINE ?? false
                        pro.Cash1 = pr?.store_payment_mode?.cOD ?? false
                        pro.retail = pr?.pro_store_retail ?? false
                        pro.Whole = pr?.pro_store_wholesale ?? false
                         pro.pro_final_status = pr?.pro_final_status ?? 0
        
                         pro.statusActive = pr?.pro_status ?? 0
                         pro.filledstep  = pr?.pro_filled_step ?? 0
                        pro.RetailRegular = "\(pr?.pro_store_retail_price ?? 0)"
                        pro.Retaildiscount = "\(pr?.pro_store_retail_dis_price ?? 0)"
                        pro.RetaildiscountPer = "\(pr?.pro_store_retail_dis_percentage ?? 0)"
                        pro.Retailsell = "\(pr?.pro_store_retail_net_sell_price ?? 0)"
                        pro.RetailVatPer = "\(pr?.pro_store_retail_vat_percentage ?? 0)"
                        pro.RetailVat = "\(pr?.pro_store_retail_vat ?? 0)"
                        pro.RetailFinal = "\(pr?.pro_store_retail_final_price ?? 0)"
                        pro.RetailMax = "\(pr?.pro_store_retail_max_qty ?? 0)"
                        pro.RetailMin = "\(pr?.pro_store_retail_min_qty ?? 0)"
                        pro.RetailReturnDays = "\(pr?.pro_store_retail_return_days ?? 0)"
                        
                        pro.RetailProductRegular = "\(pr?.pro_store_wholesale_price ?? 0)"
                        pro.RetailProductdiscount = "\(pr?.pro_store_wholesale_dis_price ?? 0)"
                        pro.RetailProductdiscountPer = "\(pr?.pro_store_wholesale_dis_percentage ?? 0)"
                        pro.RetailProductsell = "\(pr?.pro_store_wholesale_net_sell_price ?? 0)"
                        pro.RetailProductVatPer = "\(pr?.pro_store_wholesale_vat_percentage ?? 0)"
                        pro.RetailProductVat = "\(pr?.pro_store_wholesale_vat ?? 0)"
                        pro.RetailProductFinal = "\(pr?.pro_store_wholesale_final_price ?? 0)"
                        pro.RetailProducteMax = "\(pr?.pro_store_wholesale_max_qty ?? 0)"
                        pro.RetailProducteMin = "\(pr?.pro_store_wholesale_min_qty ?? 0)"
                        pro.RetailReturnDays1 = "\(pr?.pro_online_wholesale_return_days ?? 0)"
                        
                        
                        completion(true, self.prodetail)
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


// wholesale Slab

class AddWholesaleSlab: NSObject {
    func getVat(completion:@escaping(Bool, NSDictionary?) -> ()) {
        
        let param = ["user_id" : Singleton.shared.getUserId() ]
        print(param)
        ServerCalls.postRequest(Authentication.vat, withParameters: param, completion: { (response, success) in
            if let value = response as? NSDictionary{
                let error = value.object(forKey: "error") as! Int
                if error == 0{
                 
                    completion(true,value)
                }else{
                    completion(false, nil)
                    
                }
            }
        })
    }
    
}


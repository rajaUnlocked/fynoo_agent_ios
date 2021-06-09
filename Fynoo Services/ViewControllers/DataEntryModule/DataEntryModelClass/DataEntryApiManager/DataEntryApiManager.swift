//
//  DataEntryApiManager.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-040 on 04/12/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit
import ObjectMapper

class DataEntryApiManager: NSObject {
    var businessOwnerServicesData : BOServicesData?
    var serviceRequestList : DataEntryOrderRequestDatas?
    var dataEntryOrderSummeryData : DataEntryPriceBifercationModal?
    var dataEntryTypeList : dataEntryFormTypeModal?
    var rejectReason : ReasonRejectData?
    var dataEntryServiceDetail : serviceDetailData?
    var serviceType : ServiceTypeData?
    
    func agentServicesOrderListing(serviceID:String, tabStatus:String,searchStr:String,pageNumber:Int, filter : [ChooseFilters], completion:@escaping(Bool, DataEntryOrderRequestDatas?) -> ()) {
        
//        var param = [String:String]()
        var url = ""
        
        var  param = [
            "service_id": serviceID,
            "agent_id": Singleton.shared.getUserId(),
            "lang_code":HeaderHeightSingleton.shared.LanguageSelected,
            "status" : tabStatus,
            "search":searchStr,
            "next_page_no": pageNumber
            
            ]as [String : Any]
        
        for item in filter{
                   
                   if item.range.isEmpty == false{
                       param[item.filter_code] = item.range
                   }
               }
        
        url = dataEntryModuleApi.agentServicesOrder_list
        print(param)
        print(url)
        ServerCalls.postRequest(url, withParameters: param, completion: { (response, success) in
            ModalClass.stopLoading()
            if let value = response as? NSDictionary{
                let msg = value.object(forKey: "error_description") as! String
                let error = value.object(forKey: "error_code") as! Int
                if error == 100{
                    completion(false,nil)
                }else{
                    if let body = response as? [String: Any] {
                        self.serviceRequestList = Mapper<DataEntryOrderRequestDatas>().map(JSON: body)
                        completion(true, self.serviceRequestList)
                        return
                    }
                    completion(false,nil)
                }
            }
        })
    }
    
    func dataEntryFormType(completion:@escaping(Bool, dataEntryFormTypeModal?) -> ()) {
        
        var param = [String:String]()
        var url = ""
        
        param = [ "bo_id": Singleton.shared.getUserId(),
                  "lang_code":HeaderHeightSingleton.shared.LanguageSelected,
                  
        ]
        url = dataEntryModuleApi.serviceType_list
        print(param)
        print(url)
        ServerCalls.postRequest(url, withParameters: param, completion: { (response, success) in
            ModalClass.stopLoading()
            if let value = response as? NSDictionary{
                let msg = value.object(forKey: "error_description") as! String
                let error = value.object(forKey: "error_code") as! Int
                if error == 100{
                    completion(false,nil)
                }else{
                    if let body = response as? [String: Any] {
                        self.dataEntryTypeList = Mapper<dataEntryFormTypeModal>().map(JSON: body)
                        completion(true, self.dataEntryTypeList)
                        return
                    }
                    completion(false,nil)
                }
            }
        })
    }


    func addDataEntryForm(serviceID:String, completion:@escaping(Bool, NSDictionary?) -> ()) {
        
        let param = ["agent_id":Singleton.shared.getUserId(),
                     "service_id": serviceID,
                     "lang_code":HeaderHeightSingleton.shared.LanguageSelected
            ] as [String : Any]
        
        print(param)
        
        ServerCalls.postRequest(dataEntryModuleApi.save_newDataEntry, withParameters: param) { (response, success, resp) in
            ModalClass.stopLoading()
            if let value = response as? NSDictionary{
                let msg = value.object(forKey: "error_description") as! String
                let error = value.object(forKey: "error_code") as! Int
                if error == 100 {
                    completion(false,value)
                }else{
                    completion(true,value)
                }
            }
        }
    }
    
    func getDataEntryOrderSummery(entryID:String, payAmount:String, completion:@escaping(Bool, DataEntryPriceBifercationModal?) -> ()) {
          
          let param = ["user_id": Singleton.shared.getUserId(),
                       "lang_code":HeaderHeightSingleton.shared.LanguageSelected,
                       "entry_id":entryID,
                       "amount_to_pay":payAmount
              ] as [String : Any]
          
          print(param)
          
          ServerCalls.postRequest(dataEntryModuleApi.newDataEntry_orderSummery, withParameters: param) { (response, success) in
              if let value = response as? NSDictionary{
                  let msg = value.object(forKey: "error_description") as! String
                  let error = value.object(forKey: "error_code") as! Int
                  if error == 100{
                      completion(false,nil)
                  }else{
                      if let body = response as? [String: Any] {
                          
                          self.dataEntryOrderSummeryData = Mapper<DataEntryPriceBifercationModal>().map(JSON: body)
                          completion(true, self.dataEntryOrderSummeryData)
                          return
                      }
                      completion(false,nil)
                  }
              }
          }
      }
      
    func dataEntryCancelReason(completion:@escaping(Bool, ReasonRejectData?) -> ()) {
        
        var param = [String:String]()
        var url = ""
        
        param = ["user_type": "AGENT",
                 "lang_code":HeaderHeightSingleton.shared.LanguageSelected,
                 
        ]
        url = dataEntryModuleApi.dataEntryCancel_Reason
        print(param)
        print(url)
        ServerCalls.postRequest(url, withParameters: param, completion: { (response, success) in
            ModalClass.stopLoading()
            if let value = response as? NSDictionary{
                let msg = value.object(forKey: "error_description") as! String
                let error = value.object(forKey: "error_code") as! Int
                if error == 100{
                    completion(false,nil)
                }else{
                    if let body = response as? [String: Any] {
                        print(body)
                        self.rejectReason = Mapper<ReasonRejectData>().map(JSON: body)
                        completion(true, self.rejectReason)
                        return
                    }
                    completion(false,nil)
                }
            }
        })
    }
    
    
    func cancelDataEntryFromList(serviceID:String,reasonID:String, completion:@escaping(Bool, NSDictionary?) -> ()) {
        
        var param = [String:String]()
        var url = ""
        
        param = ["agent_id":Singleton.shared.getUserId(),
                 "service_id":serviceID,
                 "reason":reasonID,
                 "lang_code":HeaderHeightSingleton.shared.LanguageSelected
        ]
        
        url = dataEntryModuleApi.cancelDataEntry_BO
        print(param)
        print(url)
        ServerCalls.postRequest(url, withParameters: param, completion: { (response, success) in
            ModalClass.stopLoading()
            if let value = response as? NSDictionary{
                let error = value.object(forKey: "error") as! Int
                if error == 0{
                    if let body = response as? [String: Any] {
                        print(body)
                    }
                    completion(true,value)
                }else{
                    completion(false, value)
                }
            }
        })
    }

    
    func dataEntryDetail(serviceID:String, completion:@escaping(Bool, serviceDetailData?) -> ()) {
        
        var param = [String:String]()
        var url = ""
        
        param = ["agent_id": Singleton.shared.getUserId(),
                 "service_id": serviceID,
                 "lang_code":HeaderHeightSingleton.shared.LanguageSelected,
                 
        ]
        url = dataEntryModuleApi.DataEntry_Detail
        print(param)
        print(url)
        ServerCalls.postRequest(url, withParameters: param, completion: { (response, success) in
            ModalClass.stopLoading()
            if let value = response as? NSDictionary{
                let msg = value.object(forKey: "error_description") as! String
                let error = value.object(forKey: "error_code") as! Int
                if error == 100{
                    completion(false,nil)
                }else{
                    if let body = response as? [String: Any] {
//                        print(body)
                        self.dataEntryServiceDetail = Mapper<serviceDetailData>().map(JSON: body)
                        completion(true, self.dataEntryServiceDetail)
                        return
                    }
                    completion(false,nil)
                }
            }
        })
    }

    func BOStartWork(serviceID:String, completion:@escaping(Bool, NSDictionary?) -> ()) {
         
         var param = [String:String]()
         var url = ""
         
         param = ["service_id":serviceID,
                  "agent_id": Singleton.shared.getUserId(),
                  "lang_code":HeaderHeightSingleton.shared.LanguageSelected
        ]
         
         url = dataEntryModuleApi.DataEntry_Agent_StartWork
         print(param)
         print(url)
         ServerCalls.postRequest(url, withParameters: param, completion: { (response, success) in
             ModalClass.stopLoading()
             if let value = response as? NSDictionary{
                 let error = value.object(forKey: "error") as! Int
                 if error == 0{
                     if let body = response as? [String: Any] {
                         print(body)
                     }
                     completion(true,value)
                 }else{
                     completion(false, value)
                 }
             }
         })
     }
    
    func BOWorkConfirmation(serviceID:String, completion:@escaping(Bool, NSDictionary?) -> ()) {
            
            var param = [String:String]()
            var url = ""
            
            param = ["service_id":serviceID,
                     "agent_id": Singleton.shared.getUserId(),
                     "lang_code":HeaderHeightSingleton.shared.LanguageSelected]
            
            url = dataEntryModuleApi.DataEntry_Agent_WorkConfirmation
            print(param)
            print(url)
            ServerCalls.postRequest(url, withParameters: param, completion: { (response, success) in
                ModalClass.stopLoading()
                if let value = response as? NSDictionary{
                    let error = value.object(forKey: "error") as! Int
                    if error == 0{
                        if let body = response as? [String: Any] {
                            print(body)
                        }
                        completion(true,value)
                    }else{
                        completion(false, value)
                    }
                }
            })
        }
    
    func agentSubmitServiceTask(entryID:String, completion:@escaping(Bool, NSDictionary?) -> ()) {
         
         var param = [String:String]()
         var url = ""
         
         param = ["entry_id":entryID,
                  "agent_id": Singleton.shared.getUserId(),
                  "lang_code":HeaderHeightSingleton.shared.LanguageSelected
        ]
         
         url = dataEntryModuleApi.otherService_SubmitService_task
         print(param)
         print(url)
         ServerCalls.postRequest(url, withParameters: param, completion: { (response, success) in
             ModalClass.stopLoading()
             if let value = response as? NSDictionary{
                 let error = value.object(forKey: "error") as! Int
                 if error == 0{
                     if let body = response as? [String: Any] {
                         print(body)
                     }
                     completion(true,value)
                 }else{
                     completion(false, value)
                 }
             }
         })
     }

    
    
    func dataEntryTypeListing(serviceId:String, dataEntryType:String, searchStr:String, completion:@escaping(Bool, ServiceTypeData?) -> ()) {
           
           var param = [String:String]()
           var url = ""
           
           param = ["data_entry_type": dataEntryType,
                    "service_id": serviceId,
                    "search": searchStr,
                    "lang_code":HeaderHeightSingleton.shared.LanguageSelected,
                    
           ]
           url = dataEntryModuleApi.DataEntry_serviceType
           print(param)
           print(url)
           ServerCalls.postRequest(url, withParameters: param, completion: { (response, success) in
               ModalClass.stopLoading()
               if let value = response as? NSDictionary{
                   let msg = value.object(forKey: "error_description") as! String
                   let error = value.object(forKey: "error_code") as! Int
                   if error == 100{
                       completion(false,nil)
                   }else{
                       if let body = response as? [String: Any] {
                           print(body)
                           self.serviceType = Mapper<ServiceTypeData>().map(JSON: body)
                           completion(true, self.serviceType)
                           return
                       }
                       completion(false,nil)
                   }
               }
           })
       }
       
    func giveRatingToAgent(serviceID:String,AgentID:String,rating:String, completion:@escaping(Bool, NSDictionary?) -> ()) {
         
         var param = [String:String]()
         var url = ""
         
         param = ["service_id":serviceID,
                  "from_user": Singleton.shared.getUserId(),
                  "to_id": AgentID,
                  "rating": rating,
                  "lang_code":HeaderHeightSingleton.shared.LanguageSelected]
         
         url = dataEntryModuleApi.DataEntry_agentRating
         print(param)
         print(url)
         ServerCalls.postRequest(url, withParameters: param, completion: { (response, success) in
             ModalClass.stopLoading()
             if let value = response as? NSDictionary{
                 let error = value.object(forKey: "error") as! Int
                 if error == 0{
                     if let body = response as? [String: Any] {
                         print(body)
                     }
                     completion(true,value)
                 }else{
                     completion(false, value)
                 }
             }
         })
     }
}

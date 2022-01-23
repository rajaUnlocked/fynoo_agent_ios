//
//  ProfileDetailsSingleton.swift
//  Fynoo Business
//
//  Created by Sendan IT on 09/10/19.
//  Copyright © 2019 Sendan. All rights reserved.
//

import Foundation
class Singleton {
    var UserId:String = ""
    var BoId:String = ""
     var RetailArr:NSMutableArray = NSMutableArray()
    var userType:String = ""
    var userProfileImageStr:String = ""
    var selectedTab:Int = 1
    var delServiceID:String = ""
    static let shared = Singleton()
    private init(){}
    
  
    func getUserId() -> String{
        return UserId;
    }
    
    func setUserId(UserId:String) {
        self.UserId = UserId;
    }
    func getBoId() -> String{
           return BoId;
       }
       
       func setBoId(BoId:String) {
           self.BoId = BoId;
       }
    
    func getLoggedInUserType() -> String{
        return userType;
    }
    
    func setLoggedInUserType(UserType:String) {
        self.userType = UserType;
    }
  
    func getUserProfileImage() -> String{
        
        return userProfileImageStr;
    }
    
    func setUserProfileImage(profilePic:String) {
        
        self.userProfileImageStr = profilePic;
    }
    
    func getDeliveryDashBoardTabID() -> Int{
        
        return selectedTab;
    }
    
    func setDeliveryDashBoardTabID(tabId:Int) {
        self.selectedTab = tabId;
    }
    
    func getDelServiceID() -> String{
        
        return delServiceID;
    }
    
    func setDelServiceID(delServiceId:String) {
        self.delServiceID = delServiceId;
    }
    
}


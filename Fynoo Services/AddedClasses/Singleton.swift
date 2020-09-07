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
     var RetailArr:NSMutableArray = NSMutableArray()
    var userType:String = ""
    var userProfileImageStr:String = ""
    
    static let shared = Singleton()
    private init(){}
    func getUserId() -> String{
        return UserId;
    }
    
    func setUserId(UserId:String) {
        self.UserId = UserId;
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
}


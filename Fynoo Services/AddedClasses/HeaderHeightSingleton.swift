//
//  HeaderHeightSingleton.swift
//  Fynoo Business
//
//  Created by Aishwarya Gupta on 19/07/19.
//  Copyright © 2019 Sendan. All rights reserved.
//

import Foundation
import ObjectMapper
final class HeaderHeightSingleton {
    
    private init() { }
    
    // MARK: Shared Instance
    static let shared = HeaderHeightSingleton()
    
    // MARK: Local Variable
    var businessName = ""
    var headerHeight : Int = 0
    var LanguageSelected = "EN"
    var isOpen = false
    var Currency = "SAR".localized
    var longitude  = 0.0
    var latitude = 0.0
    var viewControl = UIViewController()
}

class AuthorisedUser {

    var isAuthorised = false
    var user: UserData?
     static let shared = AuthorisedUser()
    
    func setAuthorisedUser(with data: Any) {
        self.user = Mapper<UserData>().map(JSON: data as! [String : Any])
        self.isAuthorised = true
        let userData = NSKeyedArchiver.archivedData(withRootObject: data)
        print(self.user?.data?.id)
        UserDefaults.standard.set(userData, forKey: "UserDetail")
        
        UserDefaults.standard.synchronize()
    }
    
    func getAuthorisedUser()->UserData {
        if let recovedUserJsonData = UserDefaults.standard.object(forKey: "UserDetail") as? Data{
            print(recovedUserJsonData)
            if let recovedUserJson = NSKeyedUnarchiver.unarchiveObject(with: recovedUserJsonData as? Data ?? Data()) {
                self.user = Mapper<UserData>().map(JSON: recovedUserJson as! [String : Any])
            }
        }
         return self.user!
    }
    
    func getAuthorisedUserCheck(){
        if let recovedUserJsonData = UserDefaults.standard.object(forKey: "UserDetail") as? Data{
            if recovedUserJsonData.count > 0
            {
                 self.isAuthorised = true
            }
            else{
                  self.isAuthorised = false
            }
        }
    }
    func removeAuthorisedUser() {
        self.user = nil
        self.isAuthorised = false
        //self.token = ""
        UserDefaults.standard.removeObject(forKey: "vat_num")
        UserDefaults.standard.removeObject(forKey: "UserDetail")
        UserDefaults.standard.removeObject(forKey: "UserToken")
    }
}

extension UITextField {
    open override func awakeFromNib() {
        super.awakeFromNib()
        
       
        if let value = UserDefaults.standard.value(forKey: "AppleLanguages") as? [String]{
            if value[0]=="ar"{
                self.textAlignment = .right
                self.semanticContentAttribute = .forceRightToLeft
            }
            else if value[0]=="en"{
                self.semanticContentAttribute = .forceLeftToRight
                self.textAlignment = .left
            }
        }
    }
}

//
//  selecting_local.swift
//  Fynoo Business
//
//  Created by SENDAN on 11/09/19.
//  Copyright © 2019 Sendan. All rights reserved.
//

import UIKit

class selecting_local: NSObject {
    class func DoTheSwizzling() {
        
        // 1
        MethodSwizzleGivenClassName(cls: Bundle.self, originalSelector: #selector(Bundle.localizedString(forKey:value:table:)), overrideSelector: #selector(Bundle.specialLocalizedStringForKey(key:value:table:)))
        
    }
}

extension Bundle {
    
  
    @objc func specialLocalizedStringForKey(key: String, value: String?, table tableName: String?) -> String {
        let userlang=UserDefaults.standard
        
                /*2*/ let lang = userlang.object(forKey: "AppleLanguages") as! Array<String>
                let currentLanguage=lang[0];
    //    let currentLanguage = CSLanguage.currentAppleLanguage()
        print(currentLanguage)
        var bundle = Bundle.main
        if let path = Bundle.main.path(forResource: currentLanguage, ofType: "lproj") {
            bundle = Bundle.init(path: path)!
        } else {
            let basePath = Bundle.main.path(forResource: "Base", ofType: "lproj")
            bundle = Bundle.init(path: basePath!)!
        }
        if let name = tableName, name == "CameraUI"{
            let values = NSLocalizedString(key, comment: name)
            if values == "API_CANCEL_TITLE" {
                return "Cancel".localized
            }
            if values == "USE_PHOTO" {
                return "USE PHOTO".localized
            }
       //     print("value \(values)")
            return values
        }
        if let name = tableName, name == "PhotoLibrary"{
            let values = NSLocalizedString(key, comment: name)
            
            return values
        }
        if let name = tableName, name == "PhotoLibraryServices"{
            let values = NSLocalizedString(key, comment: name)
            
            return values
        }
        if let name = tableName, name == "PhotosUI"
        {
            let values = NSLocalizedString(key, comment: name)
            
            return values
        }
 /*4*/return (bundle.specialLocalizedStringForKey(key: key, value: value, table: tableName))
    }
    //    @objc func specialLocalizedStringForKey(key: String, value: String?, table tableName: String?) -> String {
    //        let userlang=UserDefaults.standard
    //
    //        /*2*/ let lang = userlang.object(forKey: "AppleLanguages") as! Array<String>
    //        let currentLanguage=lang[0];
    //        var bundle = Bundle();
    //
    //        /*3*/if let _path = Bundle.main.path(forResource: currentLanguage, ofType: "lproj") {
    //
    //            bundle = Bundle(path: _path)!
    //
    //        } else {
    //
    //            let _path = Bundle.main.path(forResource: "Base", ofType: "lproj")!
    //
    //            bundle = Bundle(path: _path)!
    //
    //        }
    //
    //        /*4*/return (bundle.specialLocalizedStringForKey(key: key, value: value, table: tableName))
    //
    //    }
    
}

/// Exchange the implementation of two methods for the same Class

func MethodSwizzleGivenClassName(cls: AnyClass, originalSelector: Selector, overrideSelector: Selector) {
    print(cls)
    let origMethod: Method = class_getInstanceMethod(cls, originalSelector)!;
    
    let overrideMethod: Method = class_getInstanceMethod(cls, overrideSelector)!;
    
    if (class_addMethod(cls, originalSelector, method_getImplementation(overrideMethod), method_getTypeEncoding(overrideMethod))) {
        
        class_replaceMethod(cls, overrideSelector, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
        
    } else {
        
        method_exchangeImplementations(origMethod, overrideMethod);
        
    }
}

extension String {
//    var capitalizingFirstLetter: String {
//        let first = String(self.characters.prefix(1)).capitalized
//        let other = String(self.characters.dropFirst())
//        return first + other
//    }
//
    var localized: String {
        let lang = "ar";//let lang = "fr";
        let path = Bundle.main.path(forResource: lang, ofType: "lproj");
        let bundle = Bundle(path: path!);
        return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "");
    }
}

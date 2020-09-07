//
//  ModalClass.swift
//  ApiDemo
//
//  Created by gaurav on 11/30/17.
//  Copyright © 2017 gaurav. All rights reserved.
//

import UIKit
import MBProgressHUD

class ModalClass: NSObject {
static var progressView : MBProgressHUD?
    static func showHud()
    {
   //     KRProgressHUD.show()
    }

    static func hideHud()
    {
    //    KRProgressHUD.dismiss()

    }
    static func startLoading(_ view : UIView){
        
        progressView = MBProgressHUD.showAdded(to: view, animated: true);
        
    }
    static func stopLoading(){
        
        if self.progressView != nil {
            self.progressView!.hide(true);
        }
    }
    
    static func stopLoadingAllLoaders(_ view : UIView){
        MBProgressHUD.hideAllHUDs(for: view, animated: true)
    }
}



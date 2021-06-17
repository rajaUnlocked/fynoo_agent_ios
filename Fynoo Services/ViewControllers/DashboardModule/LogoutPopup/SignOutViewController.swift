//
//  SignOutViewController.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-046 on 18/03/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit

protocol  signOutDelegate {
      func popViewController()
}

class SignOutViewController: UIViewController {

    var  delegate : signOutDelegate?
    @IBOutlet weak var logoutBtnOutlet: UIButton!
    @IBOutlet weak var dismissBtnOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         self.logoutBtnOutlet.setAllSideShadowForFields(shadowShowSize: 3.0, sizeFloat: 100)
         self.dismissBtnOutlet.setAllSideShadowForFields(shadowShowSize: 3.0, sizeFloat: 100)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
          let touch = touches.first
               if touch?.view == self.view {
               dismiss(animated: true, completion: nil)
              }
        }
    
    @IBAction func logOutClicked(_ sender: Any) {
        
            ModalClass.startLoading(self.view)
            let device_id = UIDevice.current.identifierForVendor!.uuidString
            let str = "\(Constant.BASE_URL)\(Constant.firebase_token)"
            let parameters = [
                "user_id":Singleton.shared.getUserId(),
                "device_id":device_id,
                "device_type":"ios",
                "firebase_token":"",
                "lang_code":HeaderHeightSingleton.shared.LanguageSelected
            ]
            print("request -",parameters)
            print("Url -",str)
            ServerCalls.postRequest(str, withParameters: parameters) { (response, success, resp) in
                ModalClass.stopLoading()
                if let value = response as? NSDictionary{
                    let msg = value.object(forKey: "error_description") as! String
                    let error = value.object(forKey: "error_code") as! Int
                    if error == 100{
                    }else{
                        AuthorisedUser.shared.removeAuthorisedUser()
                        ModalController.removeTheContentForKey("AgentDashboardData")
                        self.delegate?.popViewController()
                        self.hidesBottomBarWhenPushed = true
                          self.dismiss(animated: true, completion: nil)
                        
                    }
                }
            }
//        HeaderHeightSingleton.shared.longitude = 0.0
//        HeaderHeightSingleton.shared.latitude = 0.0
 //       HeaderHeightSingleton.shared.address = ""
               
//        AuthorisedUser.shared.removeAuthorisedUser()
//        ModalController.removeTheContentForKey("AgentDashboardData")
//        ModalController.removeTheContentForKey("profile_img")
//        self.hidesBottomBarWhenPushed = true
//        self.dismiss(animated: true, completion: nil)
//        self.delegate?.popViewController()
    }
    
    @IBAction func DISMISS(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

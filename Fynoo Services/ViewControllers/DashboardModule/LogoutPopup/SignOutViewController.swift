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
//        HeaderHeightSingleton.shared.longitude = 0.0
//        HeaderHeightSingleton.shared.latitude = 0.0
 //       HeaderHeightSingleton.shared.address = ""
               
        AuthorisedUser.shared.removeAuthorisedUser()
        ModalController.removeTheContentForKey("AgentDashboardData")
        ModalController.removeTheContentForKey("profile_img")
        self.hidesBottomBarWhenPushed = true
        self.dismiss(animated: true, completion: nil)
        self.delegate?.popViewController()
    }
    
    @IBAction func DISMISS(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

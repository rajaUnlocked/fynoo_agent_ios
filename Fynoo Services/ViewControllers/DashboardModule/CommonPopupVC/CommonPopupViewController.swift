//
//  CommonPopupViewController.swift
//  Fynoo Services
//
//  Created by Aishwarya on 18/09/20.
//  Copyright © 2020 Aishwarya. All rights reserved.
//

import UIKit

protocol  CommonPopupViewControllerDelegate {
    func yesBtnClicked(name : String , id : Int)
    func yesBtnForActivate(name : String , id : Int , forActivate : Bool)
}

class CommonPopupViewController: UIViewController {

    var  delegate : CommonPopupViewControllerDelegate?
    @IBOutlet weak var yesOutlet: UIButton!
    @IBOutlet weak var noOutlet: UIButton!
    @IBOutlet weak var popupBG: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    var name = ""
    var serviceID = 0
    var showActive = false
    var isForActivate = false
    @IBOutlet weak var serviceImg: UIImageView!
    var imgURL = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.yesOutlet.setAllSideShadowForFields(shadowShowSize: 3.0, sizeFloat: 100)
        self.noOutlet.setAllSideShadowForFields(shadowShowSize: 3.0, sizeFloat: 100)
    }
    
    func setUI() {
        if showActive {
            self.titleLbl.text = name
        }else{
            self.titleLbl.text = "Do you want to opt for \(name) service?"
        }
        
        if showActive {
            self.serviceImg.isHidden = true
            if isForActivate {
                self.popupBG.image = UIImage(named: "activate_service_popup")
            }else{
                self.popupBG.image = UIImage(named: "deactivate_service_popup")
            }
        }else{
            self.popupBG.image = UIImage(named: "blank_service_popup")
            self.serviceImg.isHidden = false
            
            self.serviceImg.setImageSDWebImage(imgURL: imgURL, placeholder: "")
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
              let touch = touches.first
                   if touch?.view == self.view {
                   dismiss(animated: true, completion: nil)
                  }
            }
        
        @IBAction func yesClicked(_ sender: Any) {
            self.dismiss(animated: true, completion: nil)
            
            if showActive {
                if isForActivate {
                    self.delegate?.yesBtnForActivate(name: name, id: serviceID, forActivate: true)
                }else{
                    self.delegate?.yesBtnForActivate(name: name, id: serviceID, forActivate: false)
                }
            }else{
                self.delegate?.yesBtnClicked(name: name, id: serviceID)
            }
        }
        
        @IBAction func noClicked(_ sender: Any) {
            self.dismiss(animated: true, completion: nil)
        }
}
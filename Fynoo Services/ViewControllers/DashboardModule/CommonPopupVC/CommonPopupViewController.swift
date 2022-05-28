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
     var isRemove = false
    var  delegate : CommonPopupViewControllerDelegate?
    @IBOutlet weak var yesOutlet: UIButton!
    @IBOutlet weak var noOutlet: UIButton!
    @IBOutlet weak var popupBG: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    var isDoc = false
    var name = ""
    var serviceID = 0
    var showActive = false
    var isForActivate = false
    @IBOutlet weak var serviceImg: UIImageView!
    var imgURL = ""
    
    override func viewDidLoad() {
        ModalController.watermark(self.view)
        super.viewDidLoad()
        self.yesOutlet.setAllSideShadowForFields(shadowShowSize: 3.0, sizeFloat: 100)
        self.noOutlet.setAllSideShadowForFields(shadowShowSize: 3.0, sizeFloat: 100)
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        titleLbl.font = UIFont(name: "\(fontNameLight)", size: 15)!
        yesOutlet.titleLabel?.font = UIFont(name: "\(fontNameLight)", size: 14)!
        noOutlet.titleLabel?.font = UIFont(name: "\(fontNameLight)", size: 14)!
        
        
    }
    
    func setUI() {
        if isRemove
        {
            self.titleLbl.text = "Do you want to delete this file? ".localized
            self.popupBG.image = UIImage(named: "blank_service_popup")
            self.serviceImg.isHidden = false
            self.serviceImg.image = UIImage(named: "delete_grey")
            return
        }
        if isDoc
        {
          self.titleLbl.text = "Are you sure you want to submit for Approval?"
            self.popupBG.image = UIImage(named: "popop")
            self.serviceImg.isHidden = true
            return
        }
        if showActive {
            self.titleLbl.text = name
        }else{
            
            let opt = "Do you want to opt for".localized
            let service = "service?".localized
            if name == "Delivery Service"{
                self.titleLbl.text = "\(opt) \(name)?"
            }else{
                self.titleLbl.text = "\(opt) \(name) \(service)"
            }
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
            if isRemove
            {
                self.delegate?.yesBtnClicked(name: "-100", id: serviceID)
                return
            }
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

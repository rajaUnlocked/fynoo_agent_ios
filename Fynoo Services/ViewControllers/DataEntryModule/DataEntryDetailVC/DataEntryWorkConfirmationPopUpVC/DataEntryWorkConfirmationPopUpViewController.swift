//
//  DataEntryWorkConfirmationPopUpViewController.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-040 on 27/12/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit

protocol  DataEntryWorkConfirmationPopUpViewControllerDelegate {
    
    func popUpYesClicked(_ sender: Any, fromWhere:String)
     func popUpNoClicked(_ sender: Any)
}

class DataEntryWorkConfirmationPopUpViewController: UIViewController {
    var  delegate : DataEntryWorkConfirmationPopUpViewControllerDelegate?
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var noBtn: UIButton!
    @IBOutlet weak var yesBtn: UIButton!
    @IBOutlet weak var textLbl: UILabel!
    
    var messageTxtStr:String = ""
    var comeFromStr:String = ""
    
    override func viewDidLoad() {
        ModalController.watermark(self.view)
        super.viewDidLoad()
        self.SetFont()
        
        
        self.textLbl.text = messageTxtStr
        
        if comeFromStr == "workConfirmation" || comeFromStr == "startWork" || comeFromStr == "agentSubmitServiceTask" {
            self.backgroundImageView.image = UIImage(named: "workConfirmationBackGround")
            
        }else if comeFromStr == "acceptOrder"  {
            self.backgroundImageView.image = UIImage(named: "acceptService_backgroundPopUp")
            
        }
        
        self.noBtn.setAllSideShadowForFields(shadowShowSize: 3.0, sizeFloat: 100)
        self.yesBtn.setAllSideShadowForFields(shadowShowSize: 3.0, sizeFloat: 100)
    }
    
    func SetFont() {
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        
        self.textLbl.font = UIFont(name:"\(fontNameLight)",size:16)
        self.yesBtn.titleLabel?.font = UIFont(name:"\(fontNameLight)",size:12)
        self.noBtn.titleLabel?.font = UIFont(name:"\(fontNameLight)",size:12)
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        if touch?.view == self.view {
            dismiss(animated: true, completion: nil)
        }
    }
    @IBAction func noBtnClicked(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        self.delegate?.popUpNoClicked(self)
        
    }
    @IBAction func yesBtnClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
        self.delegate?.popUpYesClicked(self, fromWhere: comeFromStr)
        
    }
}

//
//  DataEntryAgentRatingViewController.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-040 on 28/12/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit
import Cosmos

protocol DataEntryAgentRatingViewControllerDelegate: class {
    func refreshDataEntryCompleteServiceList()
}
class DataEntryAgentRatingViewController: UIViewController {
    
    weak var delegate: DataEntryAgentRatingViewControllerDelegate?
    @IBOutlet weak var agentProfileImageView: UIImageView!
    @IBOutlet weak var agentNameLbl: UILabel!
    @IBOutlet weak var agentLanguageLbl: UILabel!
    @IBOutlet weak var staticTxtLbl: UILabel!
    
    @IBOutlet weak var ratingView: CosmosView!
    var dataEntryApiMnagagerModal = DataEntryApiManager()
    
    var serviceID:String = ""
    var agentID:String = ""
    var agentName:String = ""
    var agentLanguage:String = ""
    var agentProfilePic:String = "" 
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.agentProfileImageView.sd_setImage(with: URL(string:(agentProfilePic)), placeholderImage: UIImage(named: "agent_indivdual.png"))
        self.agentNameLbl.text = self.agentName
        self.agentLanguageLbl.text = self.agentLanguage
        
        self.SetFont()
        
        ratingView.didFinishTouchingCosmos = {
            rating in
            self.ratingAPI(rating: rating)
        }
        
        
        
    }

    func SetFont() {
            let fontNameLight = NSLocalizedString("LightFontName", comment: "")
            
            self.agentNameLbl.font = UIFont(name:"\(fontNameLight)",size:16)
        self.agentLanguageLbl.font = UIFont(name:"\(fontNameLight)",size:12)
        self.staticTxtLbl.font = UIFont(name:"\(fontNameLight)",size:16)
           
        }

   override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
           let touch = touches.first
           if touch?.view == self.view {
               dismiss(animated: true, completion: nil)
           }
       }

    func ratingAPI(rating:Double) {
        
        dataEntryApiMnagagerModal.giveRatingToAgent(serviceID: self.serviceID,AgentID: self.agentID, rating: ModalController.toString(rating as Any)  ) { (success, response) in
            ModalClass.stopLoading()
            if success{
                if let value = (response?.object(forKey: "error_description") as? String) {
                    ModalController.showSuccessCustomAlertWith(title: "", msg: value)
                }
                self.delegate?.refreshDataEntryCompleteServiceList()
                self.dismiss(animated: true, completion: nil)
                
            }else{
                if let value = response?.object(forKey: "error_description") as? String {
                    ModalController.showNegativeCustomAlertWith(title: "", msg: value)
                }
            }
        }
    }
    
    
}

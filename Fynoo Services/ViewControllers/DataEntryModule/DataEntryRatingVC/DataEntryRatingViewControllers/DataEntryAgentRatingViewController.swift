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
    var isFromService = false
    @IBOutlet weak var submit: UIButton!
    weak var delegate: DataEntryAgentRatingViewControllerDelegate?
    @IBOutlet weak var agentProfileImageView: UIImageView!
    @IBOutlet weak var agentNameLbl: UILabel!
    @IBOutlet weak var agentLanguageLbl: UILabel!
    @IBOutlet weak var staticTxtLbl: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    var dataEntryApiMnagagerModal = DataEntryApiManager()
    var ratingval = 0.0
    var Orderid:String = ""
    var serviceID:String = ""
    var agentID:String = ""
    var custID:String = ""
    var boID:String = ""
    var custName:String = ""
    var boName:String = ""
    var agentName:String = ""
    var agentLanguage:String = ""
    var agentProfilePic:String = "" 

    
    var CustProfilePic:String = ""
    var BoProfilePic:String = ""
    var usertype:String = ""
  

    override func viewDidLoad() {
        ModalController.watermark(self.view)
        super.viewDidLoad()
        submit.isHidden = true
        if let value = UserDefaults.standard.value(forKey: "AppleLanguages") as? [String]{
            if value[0]=="ar"{
                self.agentNameLbl.textAlignment = .right
                self.staticTxtLbl.textAlignment = .right
                
            }else if value[0]=="en"{
                self.agentNameLbl.textAlignment = .left
                self.staticTxtLbl.textAlignment = .left
                
            }
        }
       
        ratingView.settings.minTouchRating = 0.5
        
        self.agentProfileImageView.sd_setImage(with: URL(string:(agentProfilePic)), placeholderImage: UIImage(named: "agent_indivdual.png"))
        self.agentNameLbl.text = self.agentName
        self.agentLanguageLbl.text = self.agentLanguage
        let staticText = "How was your experience with".localized
        
        self.staticTxtLbl.text = "\(staticText) \(agentName)"
        
        self.SetFont()
        
        ratingView.didFinishTouchingCosmos = {
            rating in
            self.ratingval = rating
        }
        if isFromService
        {
            
            submit.isHidden = false
            let staticText = "How was your experience with".localized
            //self.staticTxtLbl.text = "\(staticText) \(usertype)"
            if usertype == "CUSTOMER"
            {
                self.staticTxtLbl.text = "\(staticText) \(custName)"
                self.agentNameLbl.text = custName
                self.agentLanguageLbl.text = ""
                self.agentProfileImageView.sd_setImage(with: URL(string: CustProfilePic), placeholderImage: UIImage(named: "agent_indivdual"))
            }
            else{
                self.staticTxtLbl.text = "\(staticText) \(boName)"
                self.agentNameLbl.text = boName
                self.agentLanguageLbl.text = ""
                self.agentProfileImageView.sd_setImage(with: URL(string: BoProfilePic), placeholderImage: UIImage(named: "agent_indivdual"))
            }
           
        }
        else{
            ratingView.didFinishTouchingCosmos = {
                rating in
                self.ratingAPI(rating: rating)
            }
        }
    }

    func SetFont() {
        
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        self.agentNameLbl.font = UIFont(name:"\(fontNameLight)",size:16)
        self.agentLanguageLbl.font = UIFont(name:"\(fontNameLight)",size:12)
        self.staticTxtLbl.font = UIFont(name:"\(fontNameLight)",size:16)
        self.submit.setTitle("Submit".localized, for: .normal)
        self.submit.titleLabel?.font = UIFont(name:"\(fontNameLight)",size:16)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        if touch?.view == self.view {
            dismiss(animated: true, completion: nil)
        }
    }

    @IBAction func submitClicked(_ sender: Any) {
        self.ratingserviceAPI(rating: self.ratingval)
    }
    func ratingserviceAPI(rating:Double)
    {
        if rating == 0.0
        {
            return
        }
        ModalClass.startLoading(self.view)
        var str = ""
        var parameters = [String:Any]()
        parameters = [
            "agent_id":Singleton.shared.getUserId(),
            "order_id": Orderid,
            "rating":rating,
            "lang_code":HeaderHeightSingleton.shared.LanguageSelected
        ]
        if usertype == "CUSTOMER"
        {
            parameters["customer_id"] = custID
            str = "\(Constant.BASE_URL)\(Constant.custratingapi)"
        }
        else{
            parameters["bo_id"] = custID
            str = "\(Constant.BASE_URL)\(Constant.boratingapi)"
        }
       
        print("request -",parameters)
        ServerCalls.postRequest(str, withParameters: parameters) { (response, success, resp) in
            ModalClass.stopLoading()
            if let value = response as? NSDictionary{
                let msg = value.object(forKey: "error_description") as! String
                let error = value.object(forKey: "error_code") as! Int
                if error == 100{
                    ModalController.showNegativeCustomAlertWith(title: "", msg: msg)
                    self.dismiss(animated: true, completion: nil)
                }else{
                    ModalController.showSuccessCustomAlertWith(title: "", msg: msg)
                    self.dismiss(animated: true, completion: nil)
                }
            }
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
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

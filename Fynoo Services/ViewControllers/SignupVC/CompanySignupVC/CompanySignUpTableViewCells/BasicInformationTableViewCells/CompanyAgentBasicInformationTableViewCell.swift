//
//  CompanyAgentBasicInformationTableViewCell.swift
//  Fynoo Business
//
//  Created by Sendan IT on 07/01/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit

protocol CompanyAgentBasicInformationTableViewCellDelegate: class {
    
    func AgentselectCountry(_ sender: Any)
    func AgentselectCity(_ sender: Any)
    func showHidePassword(_ sender: Any)
    func showHideConfirmPassword(_ sender: Any)    
}
class CompanyAgentBasicInformationTableViewCell: UITableViewCell {
    @IBOutlet var mainView: UIView!
     weak var delegate: CompanyAgentBasicInformationTableViewCellDelegate?
    @IBOutlet var nameHeaderLbl: UILabel!
    @IBOutlet var nameTxtFld: UITextField!
    @IBOutlet var emailTxtFld: UITextField!
    @IBOutlet weak var confirmTxtFld: CustomUITextField!
    @IBOutlet var countryBtn: UIButton!
    @IBOutlet var cityBtn: UIButton!
    @IBOutlet var mobileTxtFld: UITextField!
    @IBOutlet var phoneNumberTxtFld: UITextField!
    @IBOutlet var maroofTxtFld: UITextField!
    @IBOutlet var passwordTxtFld: UITextField!
    @IBOutlet var hideShowPassword: UIButton!
    @IBOutlet var confirmPasswordTxtFld: UITextField!
    @IBOutlet var confirmPasswordMatchBtn: UIButton!
    @IBOutlet var mobileCodeTxtFld: UITextField!
    @IBOutlet var mobileCodeFlagImageView: UIImageView!
    @IBOutlet var phoneCodeTxtFld: UITextField!
    @IBOutlet var phoneCodeImageView: UIImageView!
    @IBOutlet var showConfirmPassword: UIButton!
    @IBOutlet var showPassword: UIButton!
    
    @IBOutlet weak var businessNameView: UIView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var confirmEmailView: UIView!
    @IBOutlet weak var countyView: UIView!
    @IBOutlet weak var cityView: UIView!
    @IBOutlet weak var contactNumberView: UIView!
    @IBOutlet weak var phoneNumberView: UIView!
    @IBOutlet weak var maroofView: UIView!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var confirmPasswordView: UIView!
     
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setShadowsInFields()
        
        self.emailTxtFld.keyboardType = .asciiCapable
        self.confirmTxtFld.keyboardType = .asciiCapable
        self.passwordTxtFld.keyboardType = .asciiCapable
        self.confirmPasswordTxtFld.keyboardType = .asciiCapable
        self.maroofTxtFld.keyboardType = .asciiCapableNumberPad
        self.mobileTxtFld.keyboardType = .asciiCapableNumberPad
        self.phoneNumberTxtFld.keyboardType = .asciiCapableNumberPad
        
        
        self.nameTxtFld.textColor = UIColor(red: 56/255, green: 56/255, blue: 56/255, alpha: 1)
          self.emailTxtFld.textColor = UIColor(red: 56/255, green: 56/255, blue: 56/255, alpha: 1)
          self.confirmTxtFld.textColor = UIColor(red: 56/255, green: 56/255, blue: 56/255, alpha: 1)
        self.mobileTxtFld.textColor = UIColor(red: 56/255, green: 56/255, blue: 56/255, alpha: 1)
        self.phoneNumberTxtFld.textColor = UIColor(red: 56/255, green: 56/255, blue: 56/255, alpha: 1)
        self.maroofTxtFld.textColor = UIColor(red: 56/255, green: 56/255, blue: 56/255, alpha: 1)
        self.passwordTxtFld.textColor = UIColor(red: 56/255, green: 56/255, blue: 56/255, alpha: 1)
         self.confirmPasswordTxtFld.textColor = UIColor(red: 56/255, green: 56/255, blue: 56/255, alpha: 1)
        self.mobileCodeTxtFld.textColor = UIColor(red: 56/255, green: 56/255, blue: 56/255, alpha: 1)
        self.phoneCodeTxtFld.textColor = UIColor(red: 56/255, green: 56/255, blue: 56/255, alpha: 1)
        self.nameTxtFld.tintColor = UIColor(red: 56/255, green: 56/255, blue: 56/255, alpha: 1)
        
         ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: businessNameView)
         ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: emailView)
         ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: confirmEmailView)
         ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: countyView)
         ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: cityView)
         ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: contactNumberView)
         ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: passwordView)
         ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: confirmPasswordView)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func countryBtnClicked(_ sender: Any) {
        self.delegate?.AgentselectCountry(self)
       }
    @IBAction func cityBtnClicked(_ sender: Any) {
        self.delegate?.AgentselectCity(self)
       }
    @IBAction func hideShowPasswordClicked(_ sender: Any) {
        self.delegate?.showHidePassword(self)
    }
    @IBAction func cofirmPasswordmatchBtnClicked(_ sender: Any) {
        self.delegate?.showHideConfirmPassword(self)
       }
    
    func setShadowsInFields(){
        
         let screenSize = UIScreen.main.bounds
         let screenWidth = screenSize.width - 20
         let wid = (screenWidth / 2) - 24
        
        let countryView1 = self.countyView.frame.size.width
          let cityView1 = self.cityView.frame.size.width
        
        print("wid:-", wid)
        print("countryViewWidth:-", countryView1)
        print("cityViewWidth:-", cityView1)
        
       self.businessNameView.setAllSideShadowForFields(shadowShowSize: 2.0, sizeFloat: UIScreen.main.bounds.size.width - 36)
        self.emailView.setAllSideShadowForFields(shadowShowSize: 2.0, sizeFloat: UIScreen.main.bounds.size.width - 36)
        self.confirmEmailView.setAllSideShadowForFields(shadowShowSize: 2.0, sizeFloat: UIScreen.main.bounds.size.width - 36)
        self.countyView.setAllSideShadowForFields(shadowShowSize: 2.0, sizeFloat: wid)
        self.cityView.setAllSideShadowForFields(shadowShowSize: 2.0, sizeFloat: wid + 20)
        self.contactNumberView.setAllSideShadowForFields(shadowShowSize: 2.0, sizeFloat: UIScreen.main.bounds.size.width - 36)
        self.phoneNumberView.setAllSideShadowForFields(shadowShowSize: 2.0, sizeFloat: UIScreen.main.bounds.size.width - 36)
        self.maroofView.setAllSideShadowForFields(shadowShowSize: 2.0, sizeFloat: UIScreen.main.bounds.size.width - 36)
        self.passwordView.setAllSideShadowForFields(shadowShowSize: 2.0, sizeFloat: UIScreen.main.bounds.size.width - 36)
        self.confirmPasswordView.setAllSideShadowForFields(shadowShowSize: 2.0, sizeFloat: UIScreen.main.bounds.size.width - 36)
    }
}

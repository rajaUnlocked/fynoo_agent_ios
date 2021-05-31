//
//  PersonalAgentBasicInformationTableViewCell.swift
//  Fynoo Business
//
//  Created by Sendan IT on 10/01/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit
protocol PersonalAgentBasicInformationTableViewCellDelegate: class {
    
    func AgentselectCountry(_ sender: Any)
    func AgentselectCity(_ sender: Any)
    func showHidePassword(_ sender: Any)
    func showHideConfirmPassword(_ sender: Any)
      func mobileCodeClicked(_ sender: Any)
}
class PersonalAgentBasicInformationTableViewCell: UITableViewCell {
    
    @IBOutlet var mainView: UIView!
    weak var delegate: PersonalAgentBasicInformationTableViewCellDelegate?
    @IBOutlet var emailTxtFld: UITextField!
    @IBOutlet weak var confirmTxtFld: CustomUITextField!
    @IBOutlet var countryBtn: UIButton!
    @IBOutlet var cityBtn: UIButton!
    @IBOutlet var mobileTxtFld: UITextField!
    @IBOutlet var maroofTxtFld: UITextField!
    @IBOutlet var passwordTxtFld: UITextField!
    @IBOutlet var hideShowPassword: UIButton!
    @IBOutlet var confirmPasswordTxtFld: UITextField!
    @IBOutlet var confirmPasswordMatchBtn: UIButton!
    @IBOutlet var mobileCodeTxtFld: UITextField!
    @IBOutlet var mobileCodeFlagImageView: UIImageView!
    @IBOutlet var showConfirmPassword: UIButton!
    @IBOutlet var showPassword: UIButton!
    
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var confirmEmailView: UIView!
    @IBOutlet weak var countryView: UIView!
    @IBOutlet weak var cityView: UIView!
    @IBOutlet weak var mobileNumberView: UIView!
    @IBOutlet weak var maroofView: UIView!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var confirmPasswordView: UIView!
    
    @IBOutlet weak var confirmPasswordGreenTickWIdhtConstant: NSLayoutConstraint!
    @IBOutlet weak var mobileCodeDropDownBtn: UIButton!
    
    @IBOutlet weak var emailHeaderLbl: UILabel!
    @IBOutlet weak var confirmEmailHeaderLbl: UILabel!
    @IBOutlet weak var countryHeaderLbl: UILabel!
    @IBOutlet weak var cityHeaderLbl: UILabel!
    @IBOutlet weak var mobileHeaderLbl: UILabel!
    @IBOutlet weak var maroofHeaderLbl: UILabel!
    @IBOutlet weak var passwordHeaderLbl: UILabel!
    
    @IBOutlet weak var confirmPassHeaderLbl: UILabel!
    
    
    @IBOutlet weak var confirmTxtFldTrailingConstant: NSLayoutConstraint!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setShadowsInFields()
        
        self.emailTxtFld.keyboardType = .asciiCapable
        self.confirmTxtFld.keyboardType = .asciiCapable
        self.maroofTxtFld.keyboardType = .asciiCapableNumberPad
        self.mobileTxtFld.keyboardType = .asciiCapableNumberPad
        self.passwordTxtFld.keyboardType = .asciiCapable
        self.confirmPasswordTxtFld.keyboardType = .asciiCapable
        
        self.SetFontAndTextColor()
        
        ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: emailView)
        ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: confirmEmailView)
        ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: countryView)
        ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: cityView)
        ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: mobileNumberView)
        ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: passwordView)
        ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: confirmPasswordView)
        
    }
    func SetFontAndTextColor(){
        
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        
        self.emailHeaderLbl.font = UIFont(name:"\(fontNameLight)",size:12)
        self.emailTxtFld.font = UIFont(name:"\(fontNameLight)",size:14)
        
        self.confirmEmailHeaderLbl.font = UIFont(name:"\(fontNameLight)",size:12)
        self.confirmTxtFld.font = UIFont(name:"\(fontNameLight)",size:14)
        
        self.countryHeaderLbl.font = UIFont(name:"\(fontNameLight)",size:12)
        self.countryBtn.titleLabel?.font = UIFont(name:"\(fontNameLight)",size:14)
        
        self.cityHeaderLbl.font = UIFont(name:"\(fontNameLight)",size:12)
        self.cityBtn.titleLabel?.font = UIFont(name:"\(fontNameLight)",size:14)
        
        self.mobileHeaderLbl.font = UIFont(name:"\(fontNameLight)",size:12)
        self.mobileTxtFld.font = UIFont(name:"\(fontNameLight)",size:14)
        self.mobileCodeTxtFld.font = UIFont(name:"\(fontNameLight)",size:14)
                
        self.maroofHeaderLbl.font = UIFont(name:"\(fontNameLight)",size:12)
        self.maroofTxtFld.font = UIFont(name:"\(fontNameLight)",size:14)
        
        self.confirmEmailHeaderLbl.font = UIFont(name:"\(fontNameLight)",size:12)
        self.confirmTxtFld.font = UIFont(name:"\(fontNameLight)",size:14)
        
        self.passwordHeaderLbl.font = UIFont(name:"\(fontNameLight)",size:12)
        self.passwordTxtFld.font = UIFont(name:"\(fontNameLight)",size:14)
        
        self.confirmPassHeaderLbl.font = UIFont(name:"\(fontNameLight)",size:12)
        self.confirmPasswordTxtFld.font = UIFont(name:"\(fontNameLight)",size:14)
        
       
        self.emailHeaderLbl.textColor = Constant.Black_TEXT_COLOR
        self.emailTxtFld.textColor = Constant.Black_TEXT_COLOR
        self.confirmEmailHeaderLbl.textColor = Constant.Black_TEXT_COLOR
        self.confirmTxtFld.textColor = Constant.Black_TEXT_COLOR
        self.countryHeaderLbl.textColor = Constant.Black_TEXT_COLOR
        self.countryBtn.setTitleColor(Constant.Black_TEXT_COLOR, for: .normal)
        self.cityHeaderLbl.textColor = Constant.Black_TEXT_COLOR
        self.cityBtn.setTitleColor(Constant.Black_TEXT_COLOR, for: .normal)
        self.mobileHeaderLbl.textColor = Constant.Black_TEXT_COLOR
        self.mobileTxtFld.textColor = Constant.Black_TEXT_COLOR
        self.mobileCodeTxtFld.textColor = Constant.Black_TEXT_COLOR
        self.maroofHeaderLbl.textColor = Constant.Black_TEXT_COLOR
        self.maroofTxtFld.textColor = Constant.Black_TEXT_COLOR
        self.passwordHeaderLbl.textColor = Constant.Black_TEXT_COLOR
        self.passwordTxtFld.textColor = Constant.Black_TEXT_COLOR
        self.confirmPassHeaderLbl.textColor = Constant.Black_TEXT_COLOR
        self.confirmPasswordTxtFld.textColor = Constant.Black_TEXT_COLOR
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
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
    
    @IBAction func mobileCodeDropDownClicked(_ sender: Any) {
        self.delegate?.mobileCodeClicked(self)
    }
    
    func setShadowsInFields(){
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width - 20
        let wid = (screenWidth / 2) - 24        
        
        self.emailView.setAllSideShadowForFields(shadowShowSize: 2.0, sizeFloat: UIScreen.main.bounds.size.width - 36)
        self.confirmEmailView.setAllSideShadowForFields(shadowShowSize: 2.0, sizeFloat: UIScreen.main.bounds.size.width - 36)
        self.countryView.setAllSideShadowForFields(shadowShowSize: 2.0, sizeFloat: wid)
        self.cityView.setAllSideShadowForFields(shadowShowSize: 2.0, sizeFloat: wid + 20)
        self.mobileNumberView.setAllSideShadowForFields(shadowShowSize: 2.0, sizeFloat: UIScreen.main.bounds.size.width - 36)
        self.maroofView.setAllSideShadowForFields(shadowShowSize: 2.0, sizeFloat: UIScreen.main.bounds.size.width - 36)
        self.passwordView.setAllSideShadowForFields(shadowShowSize: 2.0, sizeFloat: UIScreen.main.bounds.size.width - 36)
        self.confirmPasswordView.setAllSideShadowForFields(shadowShowSize: 2.0, sizeFloat: UIScreen.main.bounds.size.width - 36)
    }
    
}

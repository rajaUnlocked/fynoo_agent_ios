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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setShadowsInFields()
        
        self.emailTxtFld.keyboardType = .asciiCapable
        self.confirmTxtFld.keyboardType = .asciiCapable
        self.maroofTxtFld.keyboardType = .asciiCapableNumberPad
        self.mobileTxtFld.keyboardType = .asciiCapableNumberPad
        self.passwordTxtFld.keyboardType = .asciiCapable
        self.confirmPasswordTxtFld.keyboardType = .asciiCapable
        
        self.emailTxtFld.textColor = UIColor(red: 56/255, green: 56/255, blue: 56/255, alpha: 1)
        self.confirmTxtFld.textColor = UIColor(red: 56/255, green: 56/255, blue: 56/255, alpha: 1)
        self.mobileTxtFld.textColor = UIColor(red: 56/255, green: 56/255, blue: 56/255, alpha: 1)
        
        self.maroofTxtFld.textColor = UIColor(red: 56/255, green: 56/255, blue: 56/255, alpha: 1)
        self.passwordTxtFld.textColor = UIColor(red: 56/255, green: 56/255, blue: 56/255, alpha: 1)
        self.confirmPasswordTxtFld.textColor = UIColor(red: 56/255, green: 56/255, blue: 56/255, alpha: 1)
        self.mobileCodeTxtFld.textColor = UIColor(red: 56/255, green: 56/255, blue: 56/255, alpha: 1)
        
        ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: emailView)
        ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: confirmEmailView)
        ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: countryView)
        ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: cityView)
        ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: mobileNumberView)
        ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: passwordView)
        ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: confirmPasswordView)
        
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

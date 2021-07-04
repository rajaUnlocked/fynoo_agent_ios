//
//  LoginNewSecondTableViewCell.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-049 on 02/01/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit
import iOSDropDown

protocol LoginNewSecondTableViewCellDelegate: class {
    func userTypeBtnClicked()
    func eyeBtnClicked()
    func rememberMeBtnClicked()
    func loginBtnClicked()
    func signupBtnClicked()
    func forgotPasswordBtnClicked()
}

class LoginNewSecondTableViewCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var pleaseLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordLbl: UILabel!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var rememberLbl: UILabel!
    @IBOutlet weak var loginBtnOutlet: UIButton!
    @IBOutlet weak var signUp: UIButton!
    @IBOutlet weak var forgotPass: UIButton!
    
    
    
    
    @IBOutlet weak var userTypeView: UIView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var passwordView: UIView!
    
    @IBOutlet weak var userTypeImage: UIImageView!
    weak var delegate: LoginNewSecondTableViewCellDelegate?
    
    
    @IBOutlet weak var userTypeField: DropDown!
    
    
    @IBOutlet weak var eyeBtnOutlet: UIButton!
    @IBOutlet weak var rememberMeBtnOutlet: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
 //       let fontNameBold = NSLocalizedString("BoldFontName", comment: "")
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        
        forgotPass.setTitle("Forgot Password".localized, for: .normal)
        signUp.setTitle("Sign Up".localized, for: .normal)
        
        let attrs = [
            NSAttributedString.Key.font :  UIFont(name:"\(fontNameLight)",size:12),
            NSAttributedString.Key.foregroundColor :  UIColor(red: 28/255, green: 157/255, blue: 213/255, alpha: 1.0),
            NSAttributedString.Key.underlineStyle : 1] as [NSAttributedString.Key : Any] as [NSAttributedString.Key : Any]
        let attributedString = NSMutableAttributedString(string:"")
        let buttonTitleStr = NSMutableAttributedString(string:"Sign Up".localized, attributes:attrs)
        attributedString.append(buttonTitleStr)
        signUp.setAttributedTitle(attributedString, for: .normal)
        
        let attrss = [
                NSAttributedString.Key.font :  UIFont(name:"\(fontNameLight)",size:12),
                NSAttributedString.Key.foregroundColor :  UIColor(red: 127/255, green: 127/255, blue: 128/255, alpha: 1.0),
                NSAttributedString.Key.underlineStyle : 1] as [NSAttributedString.Key : Any] as [NSAttributedString.Key : Any]
            let attributedStrings = NSMutableAttributedString(string:"")
            let buttonTitleStrs = NSMutableAttributedString(string:"Forget Password".localized, attributes:attrss)
            attributedStrings.append(buttonTitleStrs)
            forgotPass.setAttributedTitle(attributedStrings, for: .normal)
        
        
        pleaseLbl.font = UIFont(name:"\(fontNameLight)",size:12)
        emailLbl.font = UIFont(name:"\(fontNameLight)",size:12)
        passwordLbl.font = UIFont(name:"\(fontNameLight)",size:12)
        rememberLbl.font = UIFont(name:"\(fontNameLight)",size:12)
        loginBtnOutlet.titleLabel?.font =  UIFont(name: "\(fontNameLight)", size: 12)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func makeShadowMethod(){
         self.loginBtnOutlet.setAllSideShadow(shadowShowSize: 3.0)
        
         self.userTypeView.setAllSideShadowForFields(shadowShowSize: 2.0, sizeFloat: UIScreen.main.bounds.size.width - 40)
         self.emailView.setAllSideShadowForFields(shadowShowSize: 2.0, sizeFloat: UIScreen.main.bounds.size.width - 40)
         self.passwordView.setAllSideShadowForFields(shadowShowSize: 2.0, sizeFloat: UIScreen.main.bounds.size.width - 40)
    }
    
    func checkLoginColor(){
        if emailField.text!.isEmpty || passwordField.text!.isEmpty || userTypeField.text!.isEmpty {
            loginBtnOutlet.isUserInteractionEnabled = false
                loginBtnOutlet.setTitleColor(#colorLiteral(red: 0.9254901961, green: 0.2901960784, blue: 0.3254901961, alpha: 1), for: .normal)
                loginBtnOutlet.layer.borderColor = #colorLiteral(red: 0.9254901961, green: 0.2901960784, blue: 0.3254901961, alpha: 1)
                      }else{
            loginBtnOutlet.isUserInteractionEnabled = true
                loginBtnOutlet.setTitleColor(#colorLiteral(red: 0.3803921569, green: 0.7529411765, blue: 0.5333333333, alpha: 1), for: .normal)
            loginBtnOutlet.layer.borderColor = #colorLiteral(red: 0.3803921569, green: 0.7529411765, blue: 0.5333333333, alpha: 1)
                }
    }
    
    @IBAction func userTypeBtn(_ sender: Any) {
        self.delegate?.userTypeBtnClicked()
    }
    
    @IBAction func eyeBtn(_ sender: Any) {
        self.delegate?.eyeBtnClicked()
    }
    
    @IBAction func rememberMeBtn(_ sender: Any) {
        self.delegate?.rememberMeBtnClicked()
    }
    
    @IBAction func loginBtn(_ sender: Any) {
        self.delegate?.loginBtnClicked()
    }
    
    @IBAction func signupBtn(_ sender: Any) {
        self.delegate?.signupBtnClicked()
    }
    
    @IBAction func forgotPasswordBtn(_ sender: Any) {
        self.delegate?.forgotPasswordBtnClicked()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
    }
    
    @IBAction func emailAction(_ sender: Any) {
    }
    
    @IBAction func passwordAction(_ sender: Any) {
    }
}



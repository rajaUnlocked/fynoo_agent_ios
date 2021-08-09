//
//  AgentCompanyUserPolicyTableViewCell.swift
//  Fynoo Business
//
//  Created by Sendan IT on 06/01/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit
protocol AgentCompanyUserPolicyTableViewCellDelegate {
    
    func userPolicySelected(_ sender: Any)
    func signUpBtnClicked(_ sender: Any)
     func loginClickedd(_ sender: Any)
    func userPolicyClicked(_ sender: Any)
}

class AgentCompanyUserPolicyTableViewCell: UITableViewCell {
    var delegate :AgentCompanyUserPolicyTableViewCellDelegate?
    @IBOutlet var checkBoxBtn: UIButton!
    @IBOutlet var signUpBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var usrPolicy: UIButton!
    @IBOutlet weak var agreeLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.SetFontAndTextColor()
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        self.signUpBtn.layer.cornerRadius = 5
        self.signUpBtn.clipsToBounds = true
         self.signUpBtn.setAllSideShadow(shadowShowSize: 3.0)
        self.agreeLbl.text = "I've agreed to the".localized
        
//        let attrss = [
//            NSAttributedString.Key.font :  UIFont(name:"\(fontNameLight)",size:14),
//            NSAttributedString.Key.foregroundColor :  UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0),
//            NSAttributedString.Key.underlineStyle : 1] as [NSAttributedString.Key : Any] as [NSAttributedString.Key : Any]
//        let attributedStrings = NSMutableAttributedString(string:"")
//        let buttonTitleStrs = NSMutableAttributedString(string:"User Policy".localized, attributes:attrss)
//        attributedStrings.append(buttonTitleStrs)
//        usrPolicy.setAttributedTitle(attributedStrings, for: .normal)
//
//        let attrs = [
//            NSAttributedString.Key.font :  UIFont(name:"\(fontNameLight)",size:12),
//            NSAttributedString.Key.foregroundColor :  UIColor(red: 28/255, green: 157/255, blue: 213/255, alpha: 1.0),
//            NSAttributedString.Key.underlineStyle : 1] as [NSAttributedString.Key : Any] as [NSAttributedString.Key : Any]
//        let attributedString = NSMutableAttributedString(string:"")
//        let buttonTitleStr = NSMutableAttributedString(string:"Login".localized, attributes:attrs)
//        attributedString.append(buttonTitleStr)
//        loginBtn.setAttributedTitle(attributedString, for: .normal)
        
        usrPolicy.setTitle("User Policy".localized, for: .normal)
        loginBtn.setTitle("Login".localized, for: .normal)
        
        if HeaderHeightSingleton.shared.LanguageSelected == "AR"
        {
            let lineView1 = UIView(frame: CGRect(x: 0, y: loginBtn.frame.size.height - 0.6, width: loginBtn.frame.size.width , height: 0.6))
            lineView1.backgroundColor = #colorLiteral(red: 0.1098039216, green: 0.6156862745, blue: 0.8352941176, alpha: 1)
            loginBtn.addSubview(lineView1)
            
            let lineView = UIView(frame: CGRect(x: 0, y: usrPolicy.frame.size.height - 0.6, width: usrPolicy.frame.size.width + 15, height: 0.6))
            lineView.backgroundColor = #colorLiteral(red: 0.3764705882, green: 0.3764705882, blue: 0.3764705882, alpha: 1)
            usrPolicy.addSubview(lineView)
            
        }else{
            let lineView1 = UIView(frame: CGRect(x: 0, y: loginBtn.frame.size.height - 0.6, width: loginBtn.frame.size.width, height: 0.6))
            lineView1.backgroundColor = #colorLiteral(red: 0.1098039216, green: 0.6156862745, blue: 0.8352941176, alpha: 1)
            loginBtn.addSubview(lineView1)
            
            
            let lineView = UIView(frame: CGRect(x: 0, y: usrPolicy.frame.size.height - 0.6, width: usrPolicy.frame.size.width - 3 , height: 0.6))
            lineView.backgroundColor = #colorLiteral(red: 0.3764705882, green: 0.3764705882, blue: 0.3764705882, alpha: 1)
            usrPolicy.addSubview(lineView)
        }
        
        
    }

    func SetFontAndTextColor(){
        
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        
        self.agreeLbl.font = UIFont(name:"\(fontNameLight)",size:12)
        self.usrPolicy.titleLabel?.font = UIFont(name:"\(fontNameLight)",size:12)
        self.signUpBtn.titleLabel?.font = UIFont(name:"\(fontNameLight)",size:12)
        self.loginBtn.titleLabel?.font = UIFont(name:"\(fontNameLight)",size:12)
        
        self.agreeLbl.textColor = Constant.Black_TEXT_COLOR
        self.usrPolicy.setTitleColor(Constant.Black_TEXT_COLOR, for: .normal)
        self.loginBtn.setTitleColor(Constant.Blue_TEXT_COLOR, for: .normal)
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func loginCicked(_ sender: Any) {
        self.delegate?.loginClickedd(self)
    }
    @IBAction func checkBoxBtnClicked(_ sender: Any) {
        self.delegate?.userPolicySelected(self)
      }
    @IBAction func signUpBtnClicked(_ sender: Any) {
        self.delegate?.signUpBtnClicked(self)
       }
    
    @IBAction func userPolicyClicked(_ sender: Any) {
        self.delegate?.userPolicyClicked(self)
    }
    
}


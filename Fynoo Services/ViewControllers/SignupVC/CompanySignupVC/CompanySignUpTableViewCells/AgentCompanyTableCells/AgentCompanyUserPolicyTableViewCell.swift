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
        
        self.signUpBtn.layer.cornerRadius = 5
        self.signUpBtn.clipsToBounds = true
         self.signUpBtn.setAllSideShadow(shadowShowSize: 3.0)
        self.agreeLbl.text = "I've agreed to the".localized
        let attrss = [
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12.0),
            NSAttributedString.Key.foregroundColor :  UIColor(red: 112/255, green: 112/255, blue: 112/255, alpha: 1.0),
            NSAttributedString.Key.underlineStyle : 1] as [NSAttributedString.Key : Any] as [NSAttributedString.Key : Any]
        let attributedStrings = NSMutableAttributedString(string:"")
        let buttonTitleStrs = NSMutableAttributedString(string:"User Policy".localized, attributes:attrss)
        attributedStrings.append(buttonTitleStrs)
        usrPolicy.setAttributedTitle(attributedStrings, for: .normal)
        
        let attrs = [
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12.0),
            NSAttributedString.Key.foregroundColor :  UIColor(red: 236/255, green: 74/255, blue: 36/255, alpha: 1.0),
            NSAttributedString.Key.underlineStyle : 1] as [NSAttributedString.Key : Any] as [NSAttributedString.Key : Any]
        let attributedString = NSMutableAttributedString(string:"")
        let buttonTitleStr = NSMutableAttributedString(string:"Login".localized, attributes:attrs)
        attributedString.append(buttonTitleStr)
        loginBtn.setAttributedTitle(attributedString, for: .normal)
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
}


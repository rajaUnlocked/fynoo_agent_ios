//
//  CompanyAgentBankDetailsTableViewCell.swift
//  Fynoo Business
//
//  Created by Sendan IT on 07/01/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit
protocol CompanyAgentBankDetailsTableViewCellDelegate: class {
    
    func AgentselectBank(_ sender: Any)
   
}
class CompanyAgentBankDetailsTableViewCell: UITableViewCell {
   weak var delegate: CompanyAgentBankDetailsTableViewCellDelegate?
    @IBOutlet var mainView: UIView!
    @IBOutlet var bankNameTxtFld: UITextField!
    @IBOutlet var bankBtn: UIButton!
    @IBOutlet var accountHolderNameTxtFld: UITextField!
    @IBOutlet var ibanNumberTxtFld: UITextField!
    @IBOutlet weak var bankNameView: UIView!
    @IBOutlet weak var accountHolderNameView: UIView!
    @IBOutlet weak var ibanNumberView: UIView!
    
    @IBOutlet weak var bankNameHeaderLbl: UILabel!
    @IBOutlet weak var accountHolderNameLbl: UILabel!
    @IBOutlet weak var IbanNumberHeaderLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setShadowsInFields()
        self.SetFontAndTextColor()
//       self.ibanNumberTxtFld.keyboardType = .asciiCapableNumberPad
        
        ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: bankNameView)
        ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: accountHolderNameView)
       ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: ibanNumberView)
    }

    func SetFontAndTextColor(){
        
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        
        self.bankNameHeaderLbl.font = UIFont(name:"\(fontNameLight)",size:12)
        self.bankNameTxtFld.font = UIFont(name:"\(fontNameLight)",size:14)
        
        self.accountHolderNameLbl.font = UIFont(name:"\(fontNameLight)",size:12)
        self.accountHolderNameTxtFld.font = UIFont(name:"\(fontNameLight)",size:14)
        
        self.IbanNumberHeaderLbl.font = UIFont(name:"\(fontNameLight)",size:12)
        self.ibanNumberTxtFld.font = UIFont(name:"\(fontNameLight)",size:14)
        
        self.bankNameHeaderLbl.textColor = Constant.Black_TEXT_COLOR
        self.bankNameTxtFld.textColor = Constant.Black_TEXT_COLOR
        self.accountHolderNameLbl.textColor = Constant.Black_TEXT_COLOR
        self.accountHolderNameTxtFld.textColor = Constant.Black_TEXT_COLOR
        self.IbanNumberHeaderLbl.textColor = Constant.Black_TEXT_COLOR
        self.ibanNumberTxtFld.textColor = Constant.Black_TEXT_COLOR
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    @IBAction func bankClicked(_ sender: Any) {
        self.delegate?.AgentselectBank(self)
      }
    func setShadowsInFields(){
        self.bankNameView.setAllSideShadowForFields(shadowShowSize: 2.0, sizeFloat: UIScreen.main.bounds.size.width - 36)
        self.accountHolderNameView.setAllSideShadowForFields(shadowShowSize: 2.0, sizeFloat: UIScreen.main.bounds.size.width - 36)
        self.ibanNumberView.setAllSideShadowForFields(shadowShowSize: 2.0, sizeFloat: UIScreen.main.bounds.size.width - 36)
    }
}

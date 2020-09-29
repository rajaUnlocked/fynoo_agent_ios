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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setShadowsInFields()
//       self.ibanNumberTxtFld.keyboardType = .asciiCapableNumberPad
        self.bankNameTxtFld.textColor = UIColor(red: 56/255, green: 56/255, blue: 56/255, alpha: 1)
        self.accountHolderNameTxtFld.textColor = UIColor(red: 56/255, green: 56/255, blue: 56/255, alpha: 1)
        self.ibanNumberTxtFld.textColor = UIColor(red: 56/255, green: 56/255, blue: 56/255, alpha: 1)
        
        ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: bankNameView)
        ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: accountHolderNameView)
       ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: ibanNumberView)
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

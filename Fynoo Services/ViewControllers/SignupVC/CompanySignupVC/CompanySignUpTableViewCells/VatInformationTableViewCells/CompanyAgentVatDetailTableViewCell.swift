//
//  CompanyAgentVatDetailTableViewCell.swift
//  Fynoo Business
//
//  Created by Sendan IT on 07/01/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit
protocol CompanyAgentVatDetailTableViewCellDelegate: class {
    
    func AgentselectYesOnVat(_ sender: Any)
     func AgentselectNoOnVat(_ sender: Any)
   
}
class CompanyAgentVatDetailTableViewCell: UITableViewCell {
    weak var delegate: CompanyAgentVatDetailTableViewCellDelegate?
    @IBOutlet var mainView: UIView!
    @IBOutlet var yesView: UIView!
    @IBOutlet var yesBtn: UIButton!
    @IBOutlet var noView: UIView!
    @IBOutlet var noBtn: UIButton!
    @IBOutlet var vatNumberView: UIView!
    @IBOutlet var vatNumberTxtFld: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
         self.vatNumberTxtFld.keyboardType = .asciiCapableNumberPad
        
        self.setShadowsInFields()
        self.vatNumberTxtFld.textColor = UIColor(red: 56/255, green: 56/255, blue: 56/255, alpha: 1)
         ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: vatNumberView)
           }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func yesBtnClicked(_ sender: Any) {
        self.delegate?.AgentselectYesOnVat(self)
       }
    @IBAction func noBtnClicked(_ sender: Any) {
        self.delegate?.AgentselectNoOnVat(self)
       }
    func setShadowsInFields(){
//        print("vatViewWidth:-",self.vatNumberView.)
          self.vatNumberView.setAllSideShadowForFields(shadowShowSize: 2.0, sizeFloat: UIScreen.main.bounds.size.width - 130)
        
      }
}

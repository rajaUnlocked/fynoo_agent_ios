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
    func AddVatDocumentClicked(_ sender: Any)
    func RemoveVatDocumentClicked(_ sender: Any)
    
}
class CompanyAgentVatDetailTableViewCell: UITableViewCell {
    weak var delegate: CompanyAgentVatDetailTableViewCellDelegate?
    
    @IBOutlet weak var headerTxtLbl: UILabel!
    @IBOutlet weak var yesLbl: UILabel!
    @IBOutlet weak var noLbl: UILabel!
    
    @IBOutlet var mainView: UIView!
    @IBOutlet var yesView: UIView!
    @IBOutlet var yesBtn: UIButton!
    @IBOutlet var noView: UIView!
    @IBOutlet var noBtn: UIButton!
    @IBOutlet var vatNumberView: UIView!
    @IBOutlet var vatNumberTxtFld: UITextField!
    
    @IBOutlet weak var documentMainView: UIView!
    @IBOutlet weak var documentHeaderLbl: UILabel!
    @IBOutlet weak var documentInnerView: UIView!
    
    @IBOutlet weak var vatDocumentImageView: UIImageView!
    @IBOutlet weak var addDocumentLbl: UILabel!
    @IBOutlet weak var addDocumentBtn: UIButton!
    @IBOutlet weak var deleteDocuementBtn: UIButton!    
    @IBOutlet weak var vatDocumentHeightConstant: NSLayoutConstraint!
    
    
    @IBOutlet weak var sampleImage: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.vatNumberTxtFld.keyboardType = .asciiCapableNumberPad
        self.SetFontAndTextColor()
        self.setShadowsInFields()
        
        ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: vatNumberView)
        
        if let value = UserDefaults.standard.value(forKey: "AppleLanguages") as? [String]{
            if value[0]=="ar"{
                print("arabic langugage")
                headerTxtLbl.textAlignment = .right
                
            }else if value[0]=="en"{
                headerTxtLbl.textAlignment = .left
                
            }
        }
        
    }
    
    func SetFontAndTextColor(){
        
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        
        self.headerTxtLbl.font = UIFont(name:"\(fontNameLight)",size:12)
        self.yesLbl.font = UIFont(name:"\(fontNameLight)",size:12)
        self.noLbl.font = UIFont(name:"\(fontNameLight)",size:12)
        self.documentHeaderLbl.font = UIFont(name:"\(fontNameLight)",size:12)
        self.addDocumentLbl.font = UIFont(name:"\(fontNameLight)",size:18)
        self.vatNumberTxtFld.font = UIFont(name:"\(fontNameLight)",size:14)
        self.sampleImage.font = UIFont(name:"\(fontNameLight)",size:10)
        
        self.headerTxtLbl.textColor = Constant.Black_TEXT_COLOR
        self.yesLbl.textColor = Constant.Black_TEXT_COLOR
        self.noLbl.textColor = Constant.Black_TEXT_COLOR
        self.documentHeaderLbl.textColor = Constant.Black_TEXT_COLOR
        self.addDocumentLbl.textColor = Constant.Black_TEXT_COLOR
        self.vatNumberTxtFld.textColor = Constant.Black_TEXT_COLOR
        self.documentHeaderLbl.text = "Upload VAT registration certificate".localized
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
    
    @IBAction func addDocumentClicked(_ sender: Any) {
        self.delegate?.AddVatDocumentClicked(self)
       }
       
       @IBAction func deleteDocumentClicked(_ sender: Any) {
        self.delegate?.RemoveVatDocumentClicked(self)
       }
}

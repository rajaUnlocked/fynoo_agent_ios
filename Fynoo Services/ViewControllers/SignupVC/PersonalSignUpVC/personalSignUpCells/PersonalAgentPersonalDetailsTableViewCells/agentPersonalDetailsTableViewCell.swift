//
//  agentPersonalDetailsTableViewCell.swift
//  Fynoo Business
//
//  Created by Sendan IT on 10/01/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit
import iOSDropDown
protocol agentPersonalDetailsTableViewCellDelegate: class {
    
    func AgentselectDOB(_ sender: Any)
    func AgentselectGender(_ sender: Any)
    func agentEducationClicked(_ sender: Any)
    func agentMajorEductionClicked(_ sender: Any)
}
class agentPersonalDetailsTableViewCell: UITableViewCell {
      weak var delegate: agentPersonalDetailsTableViewCellDelegate?
    @IBOutlet var mainView: UIView!
    @IBOutlet var nametxtFld: UITextField!
    @IBOutlet var genderDropDown: DropDown!
    @IBOutlet var genderBtn: UIButton!
    @IBOutlet var dobTxtFld: UITextField!
    @IBOutlet var dobBtn: UIButton!
    @IBOutlet var educationTxtFld: UITextField!
    @IBOutlet var majorEducationTxtFld: UITextField!
    @IBOutlet var majorEducationBtn: UIButton!
    @IBOutlet var educationBtn: UIButton!
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var genderView: UIView!
    @IBOutlet weak var dobView: UIView!
    @IBOutlet weak var educationView: UIView!
    @IBOutlet weak var majorView: UIView!
    
    
    @IBOutlet weak var nameHeaderLbl: UILabel!
    @IBOutlet weak var genderHeaderLbl: UILabel!
    @IBOutlet weak var dobHeaderLbl: UILabel!
    @IBOutlet weak var educationHeaderLbl: UILabel!
    
    @IBOutlet weak var majorHeaderLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setShadowsInFields()
        self.SetFontAndTextColor()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        self.genderDropDown.optionArray = ["Male".localized, "Female".localized]
             //Its Id Values and its optional
             self.genderDropDown.optionIds = [1,2]
             self.genderDropDown.isSearchEnable = false
             self.genderDropDown.listHeight = 80
             self.genderDropDown.rowHeight = 30
             self.genderDropDown.arrowColor = .white
             self.genderDropDown.selectedRowColor = .lightGray
        
    }
    
    
    func SetFontAndTextColor(){
        
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        
        self.nameHeaderLbl.font = UIFont(name:"\(fontNameLight)",size:12)
        self.nametxtFld.font = UIFont(name:"\(fontNameLight)",size:14)
        
        self.genderHeaderLbl.font = UIFont(name:"\(fontNameLight)",size:12)
        self.genderDropDown.font = UIFont(name:"\(fontNameLight)",size:14)
        
        self.dobHeaderLbl.font = UIFont(name:"\(fontNameLight)",size:12)
        self.dobTxtFld.font = UIFont(name:"\(fontNameLight)",size:14)
        
        self.educationHeaderLbl.font = UIFont(name:"\(fontNameLight)",size:12)
        self.educationTxtFld.font = UIFont(name:"\(fontNameLight)",size:14)
        
        self.majorHeaderLbl.font = UIFont(name:"\(fontNameLight)",size:12)
        self.majorEducationTxtFld.font = UIFont(name:"\(fontNameLight)",size:14)
        
        
        self.nameHeaderLbl.textColor = Constant.Black_TEXT_COLOR
        self.nametxtFld.textColor = Constant.Black_TEXT_COLOR
        self.genderHeaderLbl.textColor = Constant.Black_TEXT_COLOR
        self.genderDropDown.textColor = Constant.Black_TEXT_COLOR
        self.dobHeaderLbl.textColor = Constant.Black_TEXT_COLOR
        self.dobTxtFld.textColor = Constant.Black_TEXT_COLOR
        self.educationHeaderLbl.textColor = Constant.Black_TEXT_COLOR
        self.educationTxtFld.textColor = Constant.Black_TEXT_COLOR
        self.majorHeaderLbl.textColor = Constant.Black_TEXT_COLOR
        self.majorEducationTxtFld.textColor = Constant.Black_TEXT_COLOR
        
        
    }
    
    func setShadowsInFields(){
        
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let wid = (screenWidth / 2) - 24
    
        print("wid:-", wid)
        
        self.nameView.setAllSideShadowForFields(shadowShowSize: 2.0, sizeFloat: UIScreen.main.bounds.size.width - 36)
        self.genderView.setAllSideShadowForFields(shadowShowSize: 2.0, sizeFloat: UIScreen.main.bounds.size.width - 36)
        self.dobView.setAllSideShadowForFields(shadowShowSize: 2.0, sizeFloat: UIScreen.main.bounds.size.width - 36)
        self.educationView.setAllSideShadowForFields(shadowShowSize: 2.0, sizeFloat: UIScreen.main.bounds.size.width - 36)
        self.majorView.setAllSideShadowForFields(shadowShowSize: 2.0, sizeFloat: UIScreen.main.bounds.size.width - 36)
    }

    

    
    @IBAction func dobClicked(_ sender: Any) {
        self.delegate?.AgentselectDOB(self)
    }
    
    @IBAction func genderClicked(_ sender: Any) {
        self.delegate?.AgentselectGender(self)
        
      }
    @IBAction func educationBtnClicked(_ sender: Any) {
        self.delegate?.agentEducationClicked(self)
       }
    @IBAction func majorEducationClicked(_ sender: Any) {
        self.delegate?.agentMajorEductionClicked(self)
       }
}

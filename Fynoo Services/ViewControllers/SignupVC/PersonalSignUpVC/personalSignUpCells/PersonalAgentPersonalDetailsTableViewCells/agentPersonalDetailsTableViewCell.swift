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
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setShadowsInFields()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.nametxtFld.textColor = UIColor(red: 56/255, green: 56/255, blue: 56/255, alpha: 1)
        self.genderDropDown.textColor = UIColor(red: 56/255, green: 56/255, blue: 56/255, alpha: 1)
        self.dobTxtFld.textColor = UIColor(red: 56/255, green: 56/255, blue: 56/255, alpha: 1)
        self.educationTxtFld.textColor = UIColor(red: 56/255, green: 56/255, blue: 56/255, alpha: 1)
                 
        self.majorEducationTxtFld.textColor = UIColor(red: 56/255, green: 56/255, blue: 56/255, alpha: 1)
        
        self.genderDropDown.optionArray = ["Male".localized, "Female".localized]
             //Its Id Values and its optional
             self.genderDropDown.optionIds = [1,2]
             self.genderDropDown.isSearchEnable = false
             self.genderDropDown.listHeight = 80
             self.genderDropDown.rowHeight = 30
             self.genderDropDown.arrowColor = .white
             self.genderDropDown.selectedRowColor = .lightGray
        
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

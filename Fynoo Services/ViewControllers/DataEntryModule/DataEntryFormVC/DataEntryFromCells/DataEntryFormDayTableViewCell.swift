//
//  DataEntryFormDayTableViewCell.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-040 on 06/12/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit

class DataEntryFormDayTableViewCell: UITableViewCell {

    @IBOutlet weak var headerLbl: UILabel!
    @IBOutlet weak var timeTxtFld: UITextField!
    @IBOutlet weak var whatTimeLbl: UILabel!
    @IBOutlet weak var bottomTxtLbl: UILabel!
    
    @IBOutlet weak var timeView: UIView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if let value = UserDefaults.standard.value(forKey: "AppleLanguages") as? [String]{
            if value[0]=="ar"{
                self.headerLbl.textAlignment = .right
            }else if value[0]=="en"{
                self.headerLbl.textAlignment = .left
            }
        }
        self.timeTxtFld.keyboardType = .asciiCapableNumberPad
        self.timeTxtFld.setLeftPaddingPoints(10)
        self.timeTxtFld.setRightPaddingPoints(10)
        self.SetFont()
        
        ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: timeView)

    }
    
    func SetFont() {
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        
        self.headerLbl.font = UIFont(name:"\(fontNameLight)",size:14)
        self.timeTxtFld.font = UIFont(name:"\(fontNameLight)",size:16)
        self.whatTimeLbl.font = UIFont(name:"\(fontNameLight)",size:14)
         self.bottomTxtLbl.font = UIFont(name:"\(fontNameLight)",size:11)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

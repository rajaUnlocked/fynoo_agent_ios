//
//  DataEntryFromOrderInstractionTableViewCell.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-040 on 06/12/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit

class DataEntryFromOrderInstractionTableViewCell: UITableViewCell {

    @IBOutlet weak var headerLbl: UILabel!
    @IBOutlet weak var instructionTxtView: UITextView!
    @IBOutlet weak var instructionView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.SetFont()
        
   if let value = UserDefaults.standard.value(forKey: "AppleLanguages") as? [String]{
         if value[0]=="ar"{
             self.headerLbl.textAlignment = .right
         }else if value[0]=="en"{
             self.headerLbl.textAlignment = .left
         }
     }
        
    }
    func SetFont() {
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        
        self.headerLbl.font = UIFont(name:"\(fontNameLight)",size:16)
        self.instructionTxtView.font = UIFont(name:"\(fontNameLight)",size:12)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

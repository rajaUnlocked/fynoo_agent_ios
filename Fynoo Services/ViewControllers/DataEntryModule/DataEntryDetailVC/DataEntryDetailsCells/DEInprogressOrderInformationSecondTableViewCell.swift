//
//  DEInprogressOrderInformationSecondTableViewCell.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-040 on 23/12/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit

class DEInprogressOrderInformationSecondTableViewCell: UITableViewCell {

    @IBOutlet weak var orderInstructionHeaderLbl: UILabel!
    @IBOutlet weak var orderInstructionValueLbl: UILabel!
    
     @IBOutlet weak var upperLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
         self.SetFont()
        if let value = UserDefaults.standard.value(forKey: "AppleLanguages") as? [String]{
            if value[0]=="ar"{
                self.orderInstructionValueLbl.textAlignment = .right
            }else if value[0]=="en"{
                self.orderInstructionValueLbl.textAlignment = .left
            }
        }
        
        }
                    
        func SetFont() {
            
            let fontNameLight = NSLocalizedString("LightFontName", comment: "")
            
            self.orderInstructionHeaderLbl.font = UIFont(name:"\(fontNameLight)",size:16)
             self.orderInstructionValueLbl.font = UIFont(name:"\(fontNameLight)",size:12)
            
        }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

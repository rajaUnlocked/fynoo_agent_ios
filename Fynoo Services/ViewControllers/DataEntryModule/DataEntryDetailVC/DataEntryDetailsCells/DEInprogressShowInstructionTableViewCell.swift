//
//  DEInprogressShowInstructionTableViewCell.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-040 on 27/12/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit

class DEInprogressShowInstructionTableViewCell: UITableViewCell {

    
    @IBOutlet weak var orderInstructionLbl: UILabel!
    @IBOutlet weak var instructionValueLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.SetFont()
        if let value = UserDefaults.standard.value(forKey: "AppleLanguages") as? [String]{
            if value[0]=="ar"{
                self.instructionValueLbl.textAlignment = .right
            }else if value[0]=="en"{
                self.instructionValueLbl.textAlignment = .left
            }
        }
    }
                             
    func SetFont() {
        
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        
        self.orderInstructionLbl.font = UIFont(name:"\(fontNameLight)",size:16)
        self.instructionValueLbl.font = UIFont(name:"\(fontNameLight)",size:12)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

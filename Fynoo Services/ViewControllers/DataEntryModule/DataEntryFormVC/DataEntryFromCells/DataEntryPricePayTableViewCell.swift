//
//  DataEntryPricePayTableViewCell.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-040 on 06/12/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit

class DataEntryPricePayTableViewCell: UITableViewCell {

    @IBOutlet weak var headerLbl: UILabel!
    
    @IBOutlet weak var priceTxtFld: UITextField!
    @IBOutlet weak var currencyLbl: UILabel!
    @IBOutlet weak var priceView: UIView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.SetFont()
        self.priceTxtFld.keyboardType = .decimalPad

        if let value = UserDefaults.standard.value(forKey: "AppleLanguages") as? [String]{
            if value[0]=="ar"{
                self.headerLbl.textAlignment = .right
            }else if value[0]=="en"{
                self.headerLbl.textAlignment = .left
            }
        }

        
        self.priceTxtFld.setLeftPaddingPoints(10)
        self.priceTxtFld.setRightPaddingPoints(10)
        
        
    }
    func SetFont() {
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        
        self.headerLbl.font = UIFont(name:"\(fontNameLight)",size:14)
        self.priceTxtFld.font = UIFont(name:"\(fontNameLight)",size:16)
        self.currencyLbl.font = UIFont(name:"\(fontNameLight)",size:14)
        
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

//
//  DataEntryItemEntryTableViewCell.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-040 on 06/12/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit

class DataEntryItemEntryTableViewCell: UITableViewCell {

    @IBOutlet weak var itemTypeImgeView: UIImageView!
    @IBOutlet weak var itemNameTxtFld: UITextField!
    @IBOutlet weak var quantityTxtFld: UITextField!
    @IBOutlet weak var deleteItemBtn: UIButton!
    @IBOutlet weak var entryItemView: UIView!
    @IBOutlet weak var quantityView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.SetFont()
        
        self.quantityTxtFld.keyboardType = .asciiCapableNumberPad
        
        self.itemNameTxtFld.setLeftPaddingPoints(10)
        self.itemNameTxtFld.setRightPaddingPoints(10)
        
        self.quantityTxtFld.setLeftPaddingPoints(5)
        self.quantityTxtFld.setRightPaddingPoints(5)
        
        ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: entryItemView)
        ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: quantityView)
        
        
    }
   
    func SetFont() {
        
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        
        self.itemNameTxtFld.font = UIFont(name:"\(fontNameLight)",size:16)
        self.quantityTxtFld.font = UIFont(name:"\(fontNameLight)",size:16)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)


    }
}

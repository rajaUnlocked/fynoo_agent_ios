//
//  BankListAddCell.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-046 on 21/02/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit

class BankListAddCell: UITableViewCell {

    @IBOutlet weak var addnewlbl: UILabel!
    @IBOutlet weak var addNewBank: UIButton!
    @IBOutlet weak var transferRequest: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        transferRequest.titleLabel?.font = UIFont(name:"\(fontNameLight)",size:12)
        addnewlbl?.font = UIFont(name:"\(fontNameLight)",size:16)
        // self.addNewBank.setAllSideShadowForFields(shadowShowSize: 2.0, sizeFloat: UIScreen.main.bounds.size.width - 40)
        self.transferRequest.setAllSideShadowForFields(shadowShowSize: 2.0, sizeFloat: UIScreen.main.bounds.size.width - 40)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

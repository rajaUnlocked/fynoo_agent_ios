//
//  DataEntryFormAddItemTableViewCell.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-040 on 05/12/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit

class DataEntryFormAddItemTableViewCell: UITableViewCell {

    @IBOutlet weak var addEntryItemBtn: UIButton!
    @IBOutlet weak var txtLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.SetFont()
        
    }
    
    func SetFont() {
        
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        self.txtLbl.font = UIFont(name:"\(fontNameLight)",size:16)
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)


    }
    
}

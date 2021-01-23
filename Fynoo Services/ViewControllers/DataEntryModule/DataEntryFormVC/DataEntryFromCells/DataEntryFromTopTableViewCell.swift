//
//  DataEntryFromTopTableViewCell.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-040 on 05/12/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit

class DataEntryFromTopTableViewCell: UITableViewCell {
    @IBOutlet weak var textLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.SetFont()
    }
    
    func SetFont() {
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        
        self.textLbl.font = UIFont(name:"\(fontNameLight)",size:16)
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

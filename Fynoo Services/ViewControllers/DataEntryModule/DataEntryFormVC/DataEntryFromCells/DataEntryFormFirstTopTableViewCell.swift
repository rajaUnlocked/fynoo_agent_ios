//
//  DataEntryFormFirstTopTableViewCell.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-040 on 07/12/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit

class DataEntryFormFirstTopTableViewCell: UITableViewCell {

    @IBOutlet weak var createLbl: UILabel!
    @IBOutlet weak var requirementLbl: UILabel!
    
    
    @IBOutlet weak var bttomLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.SetFont()
        
    }
    func SetFont() {
        
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        
        self.createLbl.font = UIFont(name:"\(fontNameLight)",size:22)
        self.requirementLbl.font = UIFont(name:"\(fontNameLight)",size:16)
    }
         

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

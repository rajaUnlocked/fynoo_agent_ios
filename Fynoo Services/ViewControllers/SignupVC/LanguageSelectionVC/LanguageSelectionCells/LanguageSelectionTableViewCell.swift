//
//  LanguageSelectionTableViewCell.swift
//  Fynoo Services
//
//  Created by IND-SEN-LP-040 on 29/09/20.
//  Copyright © 2020 Aishwarya. All rights reserved.
//

import UIKit

class LanguageSelectionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var catName: UILabel!
    @IBOutlet weak var tickImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        self.catName.font = UIFont(name:"\(fontNameLight)",size:12)
        self.catName.textColor = Constant.Black_TEXT_COLOR
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

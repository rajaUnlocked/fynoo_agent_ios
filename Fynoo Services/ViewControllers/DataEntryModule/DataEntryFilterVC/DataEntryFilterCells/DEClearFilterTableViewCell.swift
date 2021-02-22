//
//  DEClearFilterTableViewCell.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-040 on 12/02/21.
//  Copyright © 2021 Sendan. All rights reserved.
//

import UIKit

class DEClearFilterTableViewCell: UITableViewCell {

    @IBOutlet weak var filterLbl: UILabel!
    @IBOutlet weak var clearAllLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        clearAllLbl.font  = UIFont(name:"\(fontNameLight)",size:12)
        filterLbl.font  = UIFont(name:"\(fontNameLight)",size:12)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

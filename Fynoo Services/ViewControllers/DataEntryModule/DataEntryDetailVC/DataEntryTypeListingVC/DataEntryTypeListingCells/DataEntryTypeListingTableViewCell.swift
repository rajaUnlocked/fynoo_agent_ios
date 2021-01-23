//
//  DataEntryTypeListingTableViewCell.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-040 on 27/12/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit

class DataEntryTypeListingTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var tickImageView: UIImageView!
    @IBOutlet weak var productTxtLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.thick.rawValue]
        let underlineAttributedString = NSAttributedString(string: "StringWithUnderLine", attributes: underlineAttribute)
        self.productTxtLbl.attributedText = underlineAttributedString
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
